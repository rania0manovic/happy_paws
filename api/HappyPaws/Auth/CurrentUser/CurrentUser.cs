using HappyPaws.Api.Auth.CurrentUser;

namespace HappyPaws.Api.Auth.CurrentUserClaims
{
    public class CurrentUser
    {
        private readonly ClaimsPrincipalAccessor _currentPrincipalAccessor;
        public CurrentUser(ClaimsPrincipalAccessor currentPrincipalAccessor)
        {
            _currentPrincipalAccessor = currentPrincipalAccessor;
        }
        public int? Id => _currentPrincipalAccessor?.Principal?.GetUserId();

    }
}
