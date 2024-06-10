using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Helpers;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Helpers;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;
using System.IO;

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
                memoryStream = ImageSharp.OptimizeImage(memoryStream);
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
        public override async Task<PagedList<PetDto>> GetPagedAsync(PetSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var result = await base.GetPagedAsync(searchObject, cancellationToken);
            if (searchObject.FormatPhotos)
            {
                foreach (var item in result.Items)
                {
                    if (item.Photo != null)
                    {
                        var inputStream = new MemoryStream(item.Photo.Data)
                        {
                            Position = 0
                        };
                        inputStream = ImageSharp.OptimizeImage(inputStream, width: 64, height: 64, quality:100);
                        item.Photo.Data = inputStream.ToArray();
                    }
                }
            }
            return result;
        }
        public async Task<int> GetCountAsync(CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetCountAsync(cancellationToken);
        }

        public async Task<List<PetTypeCountDto>> GetCountByPetTypeAsync(CancellationToken cancellationToken = default)
        {
            var allPetTypes = await UnitOfWork.PetTypesRepository.GetPagedAsync(new PetTypeSearchObject() { PageSize = 9999 }, cancellationToken);
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
            var pet = await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken) ?? throw new Exception("Pet not found");
            Mapper.Map(dto, pet);
            if (dto.PhotoFile != null)
            {
                var memoryStream = new MemoryStream();
                await dto.PhotoFile.CopyToAsync(memoryStream, cancellationToken);
                memoryStream = ImageSharp.OptimizeImage(memoryStream);
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
                    pet.PhotoId = photo.Id;
                }

            }
            CurrentRepository.Update(pet);
            await UnitOfWork.SaveChangesAsync(cancellationToken);

            return dto;
        }

        public async Task<bool> HasAnyWithPetTypeIdAsync(int petTypeId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.HasAnyWithPetTypeIdAsync(petTypeId, cancellationToken);
        }

        public async Task<bool> HasAnyWithPetBreedIdAsync(int petBreedId, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.HasAnyWithPetBreedIdAsync(petBreedId, cancellationToken);
        }
    }

}
