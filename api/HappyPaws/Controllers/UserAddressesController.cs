using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Application.Interfaces;
using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.SearchObjects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HappyPaws.Api.Controllers
{
    public class UserAddressesController : BaseCrudController<UserAddressDto, IUserAddressesService, UserAddressSearchObject>
    {
        protected readonly CurrentUser _currentUser;
        public UserAddressesController(IUserAddressesService service, ILogger<BaseController> logger, CurrentUser currentUser) : base(service, logger)
        {
            _currentUser = currentUser;
        }

        public override Task<IActionResult> Post([FromBody] UserAddressDto upsertDto, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            if (!userId.HasValue) throw new Exception("Unauthorized!");
            upsertDto.UserId = userId.Value;
            return base.Post(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> Put([FromBody] UserAddressDto upsertDto, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            if (!userId.HasValue) throw new Exception("Unauthorized!");
            upsertDto.UserId = userId.Value;
            return base.Put(upsertDto, cancellationToken);
        }
        public override Task<IActionResult> GetPaged([FromQuery] UserAddressSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var userId = _currentUser.Id;
            if (!userId.HasValue) throw new Exception("Unauthorized!");
            searchObject.UserId = userId.Value;
            return base.GetPaged(searchObject, cancellationToken);
        }
    }
}
