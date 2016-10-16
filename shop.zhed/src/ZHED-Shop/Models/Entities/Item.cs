using System.ComponentModel.DataAnnotations;

namespace ZHED_Shop.Models.Entities
{
    public class Item
    {
        [Key]
        public string ItemID { get; set; }
        public string Barcode { get; set; }
        public string ItemName { get; set; }
        public string Category { get; set; }
        public string Picture { get; set; }
        public decimal Price { get; set; }
        public string Remarks { get; set; }
    }
}
