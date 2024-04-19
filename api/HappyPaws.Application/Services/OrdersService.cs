using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Enums;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System.Text;

namespace HappyPaws.Application.Services
{
    public class OrdersService : BaseService<Order, OrderDto, IOrdersRepository, OrderSearchObject>, IOrdersService
    {
        protected readonly IEmailService _emailService;
        public OrdersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<OrderDto> validator, IEmailService emailService) : base(mapper, unitOfWork, validator)
        {
            _emailService = emailService;
        }

        public override async Task<OrderDto> AddAsync(OrderDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await UnitOfWork.BeginTransactionAsync(cancellationToken);
                var items = await UnitOfWork.UserCartsRepository.GetPagedAsync(new UserCartSearchObject() { UserId = dto.UserId }, cancellationToken);
                var order = await base.AddAsync(dto, cancellationToken);

                foreach (var item in items.Items)
                {
                    var orderDetail = new OrderDetail()
                    {
                        Order = null,
                        Product = null,
                        OrderId = order.Id,
                        ProductId = item.ProductId,
                        Quantity = item.Quantity,
                        UnitPrice = item.Product.Price,

                    };
                    await UnitOfWork.OrderDetailsRepository.AddAsync(orderDetail, cancellationToken);
                    await UnitOfWork.UserCartsRepository.RemoveByIdAsync(item.Id, cancellationToken);
                }

                await UnitOfWork.CommitTransactionAsync(cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                return order;
            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }
        }

        public async Task SendPlacedOrderConfirmation(int id, CancellationToken cancellationToken = default)
        {
            var order = await CurrentRepository.GetByIdAsync(id, cancellationToken);

            if (order == null)
                return;

            var invoiceHtml = GenerateInvoiceHtml(order);

            await _emailService.SendAsync("Order confirmation", invoiceHtml, order.User.Email);
        }


        public async Task UpdateAsync(int id, OrderStatus status, CancellationToken cancellationToken = default)
        {
            var order = await CurrentRepository.GetByIdAsync(id, cancellationToken) ?? throw new Exception("Order with provided id not found");
            order.Status = status;
            CurrentRepository.Update(order);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
        }
        private static string GenerateInvoiceHtml(Order order)
        {
            var invoiceBuilder = new StringBuilder();

            invoiceBuilder.Append(@"<!DOCTYPE html>
        <html lang=""en"">
        <head>
          <meta charset=""UTF-8"">
          <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
          <title>Invoice</title>
          <style>
            body {
              font-family: Arial, sans-serif;
              line-height: 1.6;
              margin: 0;
              padding: 0;
            }
            .container {
              max-width: 600px;
              margin: 0 auto;
              padding: 20px;
              background-color: #f9f9f9;
            }
            h1, h2, p {
              margin: 0 0 10px;
            }
            table {
              width: 100%;
              border-collapse: collapse;
            }
            th, td {
              border: 1px solid #ddd;
              padding: 8px;
              text-align: left;
            }
            th {
              background-color: #f2f2f2;
            }
            .total {
              font-weight: bold;
            }
          </style>
        </head>
        <body>
          <div class=""container"">
            <h1>Invoice</h1>
            <p>Thank you for your order!</p>
            <p>This invoice confirms your recent purchase from Happy Paws Shop.</p>
            
            <h2>Invoice Details</h2>
            <table>
              <tr>
                <th>Invoice Number:</th>
                <td>" + order.Id + @"</td>
              </tr>
              <tr>
                <th>Invoice Date:</th>
                <td>" + order.CreatedAt + @"</td>
              </tr>
            </table>
            
            <h2>Order Details</h2>
            <table>
              <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
              </tr>");

            foreach (var orderDetail in order.OrderDetails)
            {
                invoiceBuilder.Append(@"<tr>
                <td>" + orderDetail.Product.Name + @"</td>
                <td>" + orderDetail.Quantity + @"</td>
                <td>$" + orderDetail.UnitPrice + @"</td>
                <td>$" + Math.Round(orderDetail.UnitPrice * orderDetail.Quantity, 2) + @"</td>
              </tr>");
            }

            invoiceBuilder.Append(@"</table>
            <p class=""total""><strong>Total: $" + order.Total + @"</strong></p>
            
            <p>We appreciate your business!</p>
            <p>Sincerely,</p>
            <p>Happy Paws</p>
          </div>
        </body>
        </html>");

            return invoiceBuilder.ToString();
        }
    }
}
