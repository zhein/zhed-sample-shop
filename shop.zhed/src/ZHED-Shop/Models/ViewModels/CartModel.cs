using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ZHED_Shop.Models.ViewModels
{
    public class CartModel
    {
        public string CustomerName { get; set; }
        public List<CartItemModel> Items { get; set; }
        public decimal Total { get; set; }
        public string Address { get; set; }
        public string ShippingCourier { get; set; }
        public decimal ShippingFee { get; set; }
    }
}
