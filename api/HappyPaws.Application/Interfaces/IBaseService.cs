using HappyPaws.Core.Dtos;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;

namespace HappyPaws.Application.Interfaces
{
    public interface IBaseService<TPrimaryKey, TDto, TBaseSearchObject>
         where TDto : BaseDto

    {
        Task<TDto?> GetByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default);
        Task<PagedList<TDto>> GetPagedAsync(TBaseSearchObject searchObject, CancellationToken cancellationToken = default);

        Task<TDto> AddAsync(TDto dto, CancellationToken cancellationToken = default);
        Task<IEnumerable<TDto>> AddRangeAsync(IEnumerable<TDto> dtos, CancellationToken cancellationToken = default);

        Task<TDto> UpdateAsync(TDto dto, CancellationToken cancellationToken = default);
        Task<IEnumerable<TDto>> UpdateRangeAsync(IEnumerable<TDto> dtos, CancellationToken cancellationToken = default);

        Task RemoveAsync(TDto dto, CancellationToken cancellationToken = default);
        Task RemoveByIdAsync(TPrimaryKey id, CancellationToken cancellationToken = default);
    }
}
