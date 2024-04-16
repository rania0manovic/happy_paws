using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class OrdersService : BaseService<Order, OrderDto, IOrdersRepository, OrderSearchObject>, IOrdersService
    {
        public OrdersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<OrderDto> validator) : base(mapper, unitOfWork, validator)
        {
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
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    await UnitOfWork.CommitTransactionAsync(cancellationToken);
                }
                return order;
            }
            catch (Exception)
            {
                await UnitOfWork.RollbackTransactionAsync(cancellationToken);
                throw;
            }
        }
    }
}
