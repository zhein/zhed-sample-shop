using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ZHED_Shop.ActionFilter;
using ZHED_Shop.Common;
using ZHED_Shop.Models.ViewModels;
using ZHED_Shop.Services;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ZHED_Shop.Controllers
{
    public class CheckoutController : Controller
    {
        private CartService cartService;
        private CommonHelper commonHelper;

        public CheckoutController(CartService cartService, CommonHelper commonHelper) {
            this.cartService = cartService;
            this.commonHelper = commonHelper;
        }

        // GET: /<controller>/
        [TypeFilter(typeof(UserFilter))]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Confirm(CartModel checkoutData)
        {
            UserModel userData = cartService.GetUserDataFromSession(HttpContext);
            CartModel cartData = cartService.GetCartData(userData);
            cartData.Address = checkoutData.Address;
            cartData.ShippingFee = checkoutData.ShippingFee;
            cartData.ShippingCourier = checkoutData.ShippingCourier;

            ResponseModel response = commonHelper.GetDefaultResponse();
            bool isSalesConfirmed = cartService.ConfirmSales(cartData);

            if (isSalesConfirmed)
            {
                response.Status = true;
                response.Message = "Order has been Confirmed!";
                cartService.DestroySession(HttpContext);
            }

            return Json(response);
        }
    }
}
