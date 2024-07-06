using HappyPaws.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Core.SearchObjects
{
    public class UserSearchObject : BaseSearchObject
    {
        public string? FullName { get; set; }
        public Role Role { get; set; }
        public bool OnlySubscribers { get; set; } = false;
    }
}
