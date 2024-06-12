using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Donation;
using HappyPaws.Core.Entities;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Services
{
    public class DonationsService : BaseService<Donation, DonationDto, IDonationsRepository, DonationSearchObject>, IDonationsService
    {
        public DonationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<DonationDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<double> GetAmountForMonthAsync(int month, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetAmountForMonthAsync(month, cancellationToken);
        }
    }
}
