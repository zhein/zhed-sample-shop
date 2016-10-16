using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ZHED_Shop.Models.ViewModels
{
    public class ResponseModel
    {
        public bool Status { get; set; }
        public object Data { get; set; }
        public string Message { get; set; }
        public string Details { get; set; }
    }
}
