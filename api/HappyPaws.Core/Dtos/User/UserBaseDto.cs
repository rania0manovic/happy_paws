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
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public Gender Gender { get; set; }
        public Role Role { get; set; }

        public ImageDto? ProfilePhoto { get; set; }
        public int? ProfilePhotoId { get; set; }
    }
}
