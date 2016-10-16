using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using ZHED_Shop.ActionFilter;
using ZHED_Shop.Common;
using ZHED_Shop.Models.Entities;
using ZHED_Shop.Models.ViewModels;
using ZHED_Shop.Services;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ZHED_Shop.Controllers
{
    [Route("Cart")]
    public class CartController : Controller
    {
        private CartService cartService;
        private CommonHelper commonHelper;

        public CartController(CartService cartService, CommonHelper commonHelper)
        {
            this.cartService = cartService;
            this.commonHelper = commonHelper;
        }

        // GET: /<controller>/
        [TypeFilter(typeof(UserFilter))]
        public IActionResult Index()
        {
            return View("~/Views/Cart/Index.cshtml");
        }

        [TypeFilter(typeof(UserFilter))]
        [Route("Buy/Item/{id}")]
        public IActionResult Buy(string id)
        {
            UserModel userData = cartService.GetUserDataFromSession(HttpContext);
            bool isItemSavedToCart = cartService.SaveItemToCart(HttpContext, userData, id);

            if (isItemSavedToCart)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ViewBag.ErrorMessage = "Item cannot be added into Cart!";
                return RedirectToAction("~/Views/Store/Index");
            }
        }

        [TypeFilter(typeof(UserFilter))]
        [Route("Remove/Item/{id}")]
        public IActionResult Remove(string id)
        {
            UserModel userData = cartService.GetUserDataFromSession(HttpContext);
            bool isItemRemovedFromCart = cartService.RemoveItemFromCart(HttpContext, userData, id);

            if (isItemRemovedFromCart)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ViewBag.ErrorMessage = "Item cannot be removed from Cart!";
                return RedirectToAction("~/Views/Store/Index");
            }
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
            }

            return Json(response);
        }

        [HttpPost]
        [Route("Details")]
        public JsonResult CartDetails()
        {
            UserModel userData = cartService.GetUserDataFromSession(HttpContext);
            CartModel cartData = cartService.GetCartData(userData);

            return Json(cartData);
        }
    }
}
