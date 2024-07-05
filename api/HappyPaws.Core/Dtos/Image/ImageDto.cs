using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.Dtos.Image
{
    public class ImageDto : BaseDto
    {
        public string DownloadURL { get; set; } = null!;
    }
}
