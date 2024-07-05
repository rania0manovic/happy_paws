using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Advanced;
using SixLabors.ImageSharp.Formats;
using SixLabors.ImageSharp.Formats.Jpeg;
using SixLabors.ImageSharp.Formats.Png;
using SixLabors.ImageSharp.Processing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Helpers
{
    public class ImageSharp
    {
        public static MemoryStream OptimizeImage(MemoryStream inputMemoryStream, int width = 256, int height = 256, int quality = 75)
        {
            var fileBytes = inputMemoryStream.ToArray();
            var image = Image.Load(fileBytes);
            var format = image.Metadata.DecodedImageFormat;

            image.Mutate(x => x.Resize(new ResizeOptions
            {
                Size = new Size(width, height),
                Mode = ResizeMode.Max
            }));

            IImageEncoder encoder;
            if (format?.Name == "PNG")
            {
                encoder = new PngEncoder
                {
                    CompressionLevel = PngCompressionLevel.BestCompression
                };
            }
            else
            {
                encoder = new JpegEncoder
                {
                    Quality = quality
                };
            }

            var outputMemoryStream = new MemoryStream();
            image.Save(outputMemoryStream, encoder);
            outputMemoryStream.Position = 0; 
            return outputMemoryStream;
        }

    }
}
