﻿using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Dtos.User;
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
    public class PetsService : BaseService<Pet, PetDto, IPetsRepository, PetSearchObject>, IPetsService
    {
        public PetsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PetDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
        public override async Task<PetDto> AddAsync(PetDto dto, CancellationToken cancellationToken = default)
        {
            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);

                var photo = new Image()
                {
                    ContentType = dto.PhotoFile.ContentType,
                    Data = memoryStream.ToArray(),
                };
                await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                await UnitOfWork.SaveChangesAsync(cancellationToken);
                dto.PhotoId = photo.Id;
            }
            return await base.AddAsync(dto, cancellationToken);
        }

        public async Task<int> GetCountAsync(CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetCountAsync(cancellationToken);
        }

        public async Task<List<PetTypeCountDto>> GetCountByPetTypeAsync(CancellationToken cancellationToken = default)
        {
            var allPetTypes = await UnitOfWork.PetTypesRepository.GetPagedAsync(new PetTypeSearchObject() { PageSize=9999}, cancellationToken);
            var groupedPets = await CurrentRepository.GetCountByPetTypeAsync(cancellationToken);
            var mergedCounts = allPetTypes.Items.Select(petType => new PetTypeCountDto
            {
                Name = petType.Name,
                Count = groupedPets.FirstOrDefault(x => x.Name == petType.Name)?.Count ?? 0
            }).ToList();
            return mergedCounts;
        }

        public override async Task<PetDto> UpdateAsync(PetDto dto, CancellationToken cancellationToken = default)
        {
            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);
                if (dto.PhotoId != null)
                {
                    var photo = await UnitOfWork.ImagesRepository.GetByIdAsync((int)dto.PhotoId, cancellationToken);

                    photo!.ContentType = dto.PhotoFile.ContentType;
                    photo.Data = memoryStream.ToArray();
                    UnitOfWork.ImagesRepository.Update(photo);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                }
                else
                {
                    var photo = new Image()
                    {
                        ContentType = dto.PhotoFile.ContentType,
                        Data = memoryStream.ToArray(),
                    };
                    await UnitOfWork.ImagesRepository.AddAsync(photo, cancellationToken);
                    await UnitOfWork.SaveChangesAsync(cancellationToken);
                    dto.PhotoId = photo.Id;
                }
            }
            dto.PetBreed.PetType = null;
            dto.PetBreed = null;
            dto.Owner = null;
            return await base.UpdateAsync(dto, cancellationToken);
        }
    }
}
