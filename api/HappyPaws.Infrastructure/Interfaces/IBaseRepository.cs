﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Infrastructure.Interfaces
{
    public interface IBaseRepository<TEntity, in TPrimaryKey, TSearchObject> where TEntity : BaseEntity
    {
        Task<TEntity?> GetByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default);
        Task<PagedList<TEntity>> GetPagedAsync(TSearchObject searchObject, CancellationToken cancellationToken = default);

        Task AddAsync(TEntity entity, CancellationToken cancellationToken = default);
        Task AddRangeAsync(IEnumerable<TEntity> entities, CancellationToken cancellationToken = default);

        void Update(TEntity entity);
        void UpdateRange(IEnumerable<TEntity> entities);

        void Remove(TEntity entity);
        Task RemoveByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default);
    }
}
