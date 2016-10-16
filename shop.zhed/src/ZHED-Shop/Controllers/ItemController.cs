using Microsoft.AspNetCore.Mvc;
using ZHED_Shop.Models.Entities;
using ZHED_Shop.Services;

namespace ZHED_Shop.Controllers
{
    public class ItemController : Controller
    {
        private ItemService itemService;
        private ZhedShopContext zhedShopContext;

        public ItemController(ZhedShopContext zhedShopContext, ItemService itemService)
        {
            this.zhedShopContext = zhedShopContext;
            this.itemService = itemService;
        }

        [HttpPost]
        public JsonResult GetItems()
        {
            var items = itemService.GetItems(zhedShopContext);
            return Json(items);
        }
    }
}
