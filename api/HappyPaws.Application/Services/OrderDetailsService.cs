using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.OrderDetail;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public class OrderDetailsService : BaseService<OrderDetail, OrderDetailDto, IOrderDetailsRepository, OrderDetailSearchObject>, IOrderDetailsService
    {
        public OrderDetailsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<OrderDetailDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
