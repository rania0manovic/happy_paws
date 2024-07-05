using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class User : BaseEntity
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public required string PasswordSalt { get; set; }
        public required string PasswordHash { get; set; }
        public Gender Gender { get; set; }
        public Role Role { get; set; }

        public Image? ProfilePhoto { get; set; }
        public int? ProfilePhotoId { get; set; }
        public string? MyPawNumber { get; set; }
        public string? ConnectionId { get; set; }
        public bool IsVerified { get; set; }
        public bool IsSubscribed { get; set; }
        public EmployeePosition? EmployeePosition { get; set; }


        public ICollection<Order>? Orders { get; set; }
        public ICollection<Appointment>? Appointments { get; set; }
        public ICollection<UserAddress>? UserAddresses { get; set; }
        public ICollection<Pet>? Pets { get; set; }
        public ICollection<UserCart>? UserCartItems { get; set; }
        public ICollection<UserFavourite>? UserFavouriteItems { get; set; }
        public ICollection<Notification>? Notifications { get; set; }
        public ICollection<Donation>? Donations { get; set; }


    }
}
