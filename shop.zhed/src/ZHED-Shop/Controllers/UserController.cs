using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using ZHED_Shop.Models.ViewModels;
using ZHED_Shop.Common;
using ZHED_Shop.Services;
using ZHED_Shop.Models.Entities;
using System.Linq;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace ZHED_Shop.Controllers
{
    public class UserController : BaseController
    {
        private ZhedShopContext zhedShopContext;
        private CommonHelper helper;
        private CartService cartService;

        public UserController(ZhedShopContext zhedShopContext, CommonHelper helper, CartService cartService) : base()
        {
            this.zhedShopContext = zhedShopContext;
            this.helper = helper;
            this.cartService = cartService;
        }

        [HttpPost]
        public IActionResult ActiveUser()
        {
            UserModel usertData = cartService.GetUserDataFromSession(HttpContext);
            ResponseModel response = helper.GetDefaultResponse();
            response.Status = true;
            response.Data = usertData;

            return Json(response);
        }

        [HttpPost]
        public IActionResult SaveUser(UserModel user)
        {
            ResponseModel response = helper.GetDefaultResponse();

            if (!string.IsNullOrEmpty(user.GuestName))
            {
                string serializedUserData = JsonConvert.SerializeObject(user);
                HttpContext.Session.SetString(ApplicationConfiguration.ACTIVE_USER, serializedUserData);
            }

            response.Status = true;
            response.Message = "Guest Name has been saved.";

            return Json(response);

        }
    }
}
