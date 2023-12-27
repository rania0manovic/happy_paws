using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Entities;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class OrdersService : BaseService<Order, OrderDto, IOrdersRepository>, IOrdersService
    {
        public OrdersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<OrderDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
