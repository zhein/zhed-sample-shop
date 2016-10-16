using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ZHED_Shop.Models.Entities
{
    public class OrderHeader
    {
        [Key]
        public string OrderHeaderID { get; set; }
        public DateTime OrderDate { get; set; }
        public string CustomerName { get; set; }
        public string Address { get; set; }
        public decimal ShippingFee { get; set; }
        public string ShippingCourier { get; set; }
        public decimal Total { get; set; }
    }

    public class OrderDetail
    {
        public string OrderHeaderID { get; set; }
        //[ForeignKey("OrderHeader")]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public string OrderDetailID { get; set; }
        public string ItemID { get; set; }
        public decimal ItemPrice { get; set; }
        public int Qty { get; set; }
        public decimal Subtotal { get; set; }

        //public virtual OrderHeader OrderHeader { get; set; }
    }
}
