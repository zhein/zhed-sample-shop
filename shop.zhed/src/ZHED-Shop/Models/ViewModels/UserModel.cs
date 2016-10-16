using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ZHED_Shop.Models.ViewModels
{
    public class UserModel
    {
        [Required]
        public string GuestName { get; set; }
        public Dictionary<string, int> Items { get; set; }
    }
}
