using System.Security.Claims;

namespace HappyPaws.Api.Auth.CurrentUser
{
    public static class PrincipalHelper
    {
        public static int? GetUserId(this ClaimsPrincipal principal)
        {
            var claim = principal.FindFirst("Id");

            if (int.TryParse(claim?.Value, out var id))
                return id;

            return null;
        }
    }
}
