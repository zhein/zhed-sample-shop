using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZHED_Shop.Models.Entities;
using System.Linq;

namespace ZHED_Shop.Services
{
    public class ItemService
    {
        public List<Item> GetItems(ZhedShopContext zhedShopContext)
        {
            List<Item> items = zhedShopContext.Item.ToList();
            return items;
        }
    }
}
