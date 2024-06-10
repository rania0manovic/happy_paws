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
        public  string? MyPawNumber { get; set; }
        public string? ConnectionId { get; set; }
        public bool IsVerified { get; set; }
        public EmployeePosition? EmployeePosition { get; set; }


        public required ICollection<Order> Orders { get; set; }
        public required ICollection<Appointment> Appointments { get; set; }
        public required ICollection<UserAddress> UserAddresses { get; set; }
        public required ICollection<Pet> Pets { get; set; }
        public required ICollection<UserCart> UserCartItems { get; set; }
        public required ICollection<UserFavourite> UserFavouriteItems { get; set; }
        public required ICollection<Notification> Notifications { get; set; }
        public required ICollection<Donation> Donations { get; set; }


    }
}
