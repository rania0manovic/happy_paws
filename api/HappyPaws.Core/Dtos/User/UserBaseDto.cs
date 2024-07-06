using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.User
{
    public class UserBaseDto:BaseDto
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public Gender Gender { get; set; }
        public Role Role { get; set; }

        public ImageDto? ProfilePhoto { get; set; }
        public int? ProfilePhotoId { get; set; }

        public string FullName => $"{FirstName} {LastName}";
    }
}
