using AutoMapper;
using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos;
using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure;
using HappyPaws.Infrastructure.Interfaces;

namespace HappyPaws.Application.Services
{
    public abstract class BaseService<TEntity, TDto, TRepository, TBaseSearchObject> : IBaseService<int, TDto, TBaseSearchObject>
       where TEntity : BaseEntity
       where TDto : BaseDto
       where TRepository : class, IBaseRepository<TEntity, int, TBaseSearchObject>
    {
        protected readonly IMapper Mapper;
        protected readonly UnitOfWork UnitOfWork;
        protected readonly TRepository CurrentRepository;
        protected readonly IValidator<TDto> Validator;

        protected BaseService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<TDto> validator)
        {
            Mapper = mapper;
            UnitOfWork = (UnitOfWork)unitOfWork;
            Validator = validator;
            CurrentRepository = (TRepository)unitOfWork.GetType()
                                                       .GetFields()
                                                       .First(f => f.FieldType == typeof(TRepository))
                                                       .GetValue(unitOfWork)!;
        }

        public virtual async Task<TDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await CurrentRepository.GetByIdAsync(id, cancellationToken);
            return Mapper.Map<TDto>(entity);
        }


        public virtual async Task<PagedList<TDto>> GetPagedAsync(TBaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await CurrentRepository.GetPagedAsync(searchObject, cancellationToken);
            return Mapper.Map<PagedList<TDto>>(pagedList);
        }

        public virtual async Task<TDto> AddAsync(TDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            var entity = Mapper.Map<TEntity>(dto);
            await CurrentRepository.AddAsync(entity, cancellationToken);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<TDto>(entity);
        }

        public virtual async Task<IEnumerable<TDto>> AddRangeAsync(IEnumerable<TDto> dtos, CancellationToken cancellationToken = default)
        {
            await ValidateRangeAsync(dtos, cancellationToken);

            var entities = Mapper.Map<IEnumerable<TEntity>>(dtos);
            await CurrentRepository.AddRangeAsync(entities, cancellationToken);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<IEnumerable<TDto>>(entities);
        }

        public virtual async Task<TDto> UpdateAsync(TDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            var entity = Mapper.Map<TEntity>(dto);
            CurrentRepository.Update(entity);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<TDto>(entity);
        }

        public virtual async Task<IEnumerable<TDto>> UpdateRangeAsync(IEnumerable<TDto> dtos, CancellationToken cancellationToken = default)
        {
            await ValidateRangeAsync(dtos, cancellationToken);

            var entities = Mapper.Map<IEnumerable<TEntity>>(dtos);
            CurrentRepository.UpdateRange(entities);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<IEnumerable<TDto>>(entities);
        }

        public virtual async Task RemoveAsync(TDto dto, CancellationToken cancellationToken = default)
        {
            var entity = Mapper.Map<TEntity>(dto);
            CurrentRepository.Remove(entity);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
        }

        public virtual async Task RemoveByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            await CurrentRepository.RemoveByIdAsync(id, cancellationToken);
        }

        protected async Task ValidateAsync(TDto dto, CancellationToken cancellationToken = default)
        {
            var validationResult = await Validator.ValidateAsync(dto, cancellationToken);
            if (validationResult.IsValid == false)
            {
                throw new ValidationException("Validation error");
            }

        }

        protected async Task ValidateRangeAsync(IEnumerable<TDto> dtos, CancellationToken cancellationToken = default)
        {
            foreach (var dto in dtos)
            {
                await ValidateAsync(dto, cancellationToken);
            }
        }

    }
}
