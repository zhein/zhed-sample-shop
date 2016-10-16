using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ZHED_Shop.ActionFilter;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ZHED_Shop.Controllers
{
    public class StoreController : Controller
    {
        [TypeFilter(typeof(UserFilter))]
        public IActionResult Index()
        {
            return View("~/Views/Store/Index.cshtml");
        }
    }
}
