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
    }
}
