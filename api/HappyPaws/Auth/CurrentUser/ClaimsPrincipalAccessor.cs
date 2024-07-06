using System.Security.Claims;

namespace HappyPaws.Api.Auth.CurrentUserClaims
{
    public class ClaimsPrincipalAccessor
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public ClaimsPrincipalAccessor(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public ClaimsPrincipal? Principal => _httpContextAccessor.HttpContext?.User;

       
    }
}
