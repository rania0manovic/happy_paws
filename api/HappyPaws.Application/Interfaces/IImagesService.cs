﻿using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Interfaces
{
    public interface IImagesService : IBaseService<int, ImageDto, BaseSearchObject>
    {
    }
}
