﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class PetSearchObject : BaseSearchObject
    {
        public string? MyPawNumber { get; set; }
        public bool FormatPhotos { get; set; } = false;
    }
}
