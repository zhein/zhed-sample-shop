using Microsoft.AspNetCore.Mvc;
using ZHED_Shop.Models.ViewModels;
using Microsoft.AspNetCore.Http;
using ZHED_Shop.Common;
using ZHED_Shop.Models.Entities;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ZHED_Shop.Controllers
{

    public class BaseController : Controller
    {
        public BaseController()
        {
        }

        //protected ZhedShopContext zhedShopContext;
        //protected Helper helper;

        //public BaseController(ZhedShopContext zhedShopContext, Helper helper) : base() {
        //    this.zhedShopContext = zhedShopContext;
        //    this.helper = helper;
        //}
    }
}
