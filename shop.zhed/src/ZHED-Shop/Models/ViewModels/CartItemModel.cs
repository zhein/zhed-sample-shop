using ZHED_Shop.Models.Entities;

namespace ZHED_Shop.Models.ViewModels
{
    public class CartItemModel: Item
    {
        public int Qty { get; set; }
        public decimal SubTotal { get; set; }
    }
}
