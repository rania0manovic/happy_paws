using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;

namespace HappyPaws.Infrastructure.Repositories
{
    public class BaseRepository<TEntity, TPrimaryKey, TSearchObject> : IBaseRepository<TEntity, TPrimaryKey, TSearchObject>
          where TEntity : BaseEntity
          where TSearchObject : BaseSearchObject
    {
        protected readonly DatabaseContext DatabaseContext;
        protected readonly DbSet<TEntity> DbSet;

        protected BaseRepository(DatabaseContext databaseContext)
        {
            DatabaseContext = databaseContext;
            DbSet = DatabaseContext.Set<TEntity>();
        }

        public async virtual Task AddAsync(TEntity entity, CancellationToken cancellationToken = default)
        {
            entity.Id = default;
            await DbSet.AddAsync(entity, cancellationToken);
        }

        public virtual async Task<PagedList<TEntity>> GetPagedAsync(TSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.ToPagedListAsync(searchObject, cancellationToken);
        }

        public async virtual Task AddRangeAsync(IEnumerable<TEntity> entities, CancellationToken cancellationToken = default)
        {
            foreach (var entity in entities) entity.Id = default;
            await DbSet.AddRangeAsync(entities, cancellationToken);
        }

        public async virtual Task<TEntity?> GetByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default)
        {
            return await DbSet.FindAsync(new object?[] { id, cancellationToken }, cancellationToken: cancellationToken);
        }

        public void Remove(TEntity entity)
        {
            DbSet.Remove(entity);
        }

        public async virtual Task RemoveByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default)
        {
            await DbSet.Where(e => e.Id.Equals(id)).ExecuteUpdateAsync(p => p
                   .SetProperty(e => e.IsDeleted, true)
                   .SetProperty(e => e.ModifiedAt, DateTime.Now), cancellationToken);
        }

        public void Update(TEntity entity)
        {
            DbSet.Update(entity);
        }

        public void UpdateRange(IEnumerable<TEntity> entities)
        {
            DbSet.UpdateRange(entities);
        }
    }
}
