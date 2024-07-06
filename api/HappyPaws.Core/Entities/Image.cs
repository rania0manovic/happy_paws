using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Entities
{
    public class Image : BaseEntity
    {
        public required string DownloadURL { get; set; }

        public ICollection<User> Employees { get; set; } = null!;
        public  ICollection<User> Users { get; set; } = null!;
        public  ICollection<Pet> Pets { get; set; } = null!;
        public  ICollection<ProductImage> ProductImages { get; set; } = null!;

    }
}
