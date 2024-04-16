using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Dtos.User;


namespace HappyPaws.Core.Dtos.Address
{
    public class UserAddressDto : BaseDto
    {
        public  string? FullName { get; set; }
        public  string? AddressOne { get; set; }
        public string? AddressTwo { get; set; }
        public  string? City { get; set; }
        public  string? Country { get; set; }
        public  string? PostalCode { get; set; }
        public  string? Phone { get; set; }
        public string? Note { get; set; }
        public bool IsInitialUserAddress { get; set; }

        public  UserDto? User { get; set; }
        public int UserId { get; set; }

        public ICollection<OrderDto>? Orders { get; set; }
    }
}
