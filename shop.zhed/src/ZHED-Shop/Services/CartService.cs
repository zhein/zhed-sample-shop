using System;
using System.Collections.Generic;
using System.Diagnostics;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using ZHED_Shop.Common;
using ZHED_Shop.Models.Entities;
using ZHED_Shop.Models.ViewModels;
using System.Linq;

namespace ZHED_Shop.Services
{
    public class CartService
    {
        private CommonHelper commonHelper;
        private ZhedShopContext zhedShopContext;

        public CartService(CommonHelper commonHelper, ZhedShopContext zhedShopContext)
        {
            this.commonHelper = commonHelper;
            this.zhedShopContext = zhedShopContext;
        }

        public UserModel GetUserDataFromSession(HttpContext httpContext)
        {
            byte[] rawUserData = null;
            httpContext.Session.TryGetValue(ApplicationConfiguration.ACTIVE_USER, out rawUserData);

            if (rawUserData == null)
            {
                return new UserModel();
            }
            else
            {
                string serializedUserData = commonHelper.ConvertByteToString(rawUserData);
                UserModel userData = JsonConvert.DeserializeObject<UserModel>(serializedUserData);

                return userData;
            }
        }

        public bool SaveItemToCart(HttpContext httpContext, UserModel userData, string itemID)
        {
            bool status = false;

            try
            {
                if (userData.Items == null)
                {
                    userData.Items = new Dictionary<string, int>();
                }

                if (userData.Items.ContainsKey(itemID))
                {
                    userData.Items[itemID] += 1;
                }
                else
                {
                    userData.Items.Add(itemID, 1);
                }

                string serializedUserData = JsonConvert.SerializeObject(userData);
                httpContext.Session.SetString(ApplicationConfiguration.ACTIVE_USER, serializedUserData);

                status = true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return status;
        }

        internal void DestroySession(HttpContext httpContext)
        {
            httpContext.Session.SetString(ApplicationConfiguration.ACTIVE_USER, "");
        }

        public bool RemoveItemFromCart(HttpContext httpContext, UserModel userData, string itemID)
        {
            bool status = false;

            try
            {
                if (userData.Items == null)
                {
                    userData.Items = new Dictionary<string, int>();
                }

                if (userData.Items.ContainsKey(itemID))
                {
                    userData.Items.Remove(itemID);
                }

                string serializedUserData = JsonConvert.SerializeObject(userData);
                httpContext.Session.SetString(ApplicationConfiguration.ACTIVE_USER, serializedUserData);

                status = true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return status;
        }

        public CartModel GetCartData(UserModel userData)
        {
            CartModel cartData = new CartModel();
            cartData.CustomerName = userData.GuestName;
            cartData.Items = new List<CartItemModel>();

            if (userData.Items == null)
            {
                return cartData;
            }
            else
            {
                foreach (KeyValuePair<string, int> item in userData.Items)
                {
                    string itemID = item.Key;
                    Item itemData = zhedShopContext.Item.Where(x => x.ItemID == itemID).FirstOrDefault();

                    CartItemModel cartItem = new CartItemModel();
                    cartItem.ItemID = itemData.ItemID;
                    cartItem.ItemName = itemData.ItemName;
                    cartItem.Picture = itemData.Picture;
                    cartItem.Price = itemData.Price;
                    cartItem.Qty = item.Value;
                    cartItem.Remarks = itemData.Remarks;
                    cartItem.SubTotal = item.Value * itemData.Price;

                    cartData.Items.Add(cartItem);
                }
            }


            return cartData;
        }

        public bool ConfirmSales(CartModel cartData)
        {
            bool result = false;

            if (cartData != null)
            {
                string orderHeaderID = Guid.NewGuid().ToString();

                OrderHeader orderHeader = new OrderHeader()
                {
                    Address = cartData.Address,
                    OrderDate = DateTime.Now,
                    CustomerName = cartData.CustomerName,
                    OrderHeaderID = orderHeaderID,
                    ShippingCourier = cartData.ShippingCourier,
                    ShippingFee = cartData.ShippingFee,
                    Total = cartData.Total
                };
                zhedShopContext.OrderHeader.Add(orderHeader);

                int orderDetailID = 1;
                foreach (CartItemModel item in cartData.Items)
                {
                    OrderDetail orderDetail = new OrderDetail()
                    {
                        ItemID = item.ItemID,
                        ItemPrice = item.Price,
                        OrderDetailID = Guid.NewGuid().ToString(),
                        OrderHeaderID = orderHeaderID,
                        Qty = item.Qty,
                        Subtotal = item.SubTotal
                    };

                    zhedShopContext.OrderDetail.Add(orderDetail);
                    orderDetailID++;
                }
            }

            try
            {
                zhedShopContext.SaveChanges();
                result = true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.StackTrace);
            }

            return result;
        }
    }
}
