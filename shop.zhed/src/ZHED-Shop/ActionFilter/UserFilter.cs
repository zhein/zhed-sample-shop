using System;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Routing;
using ZHED_Shop.Common;

namespace ZHED_Shop.ActionFilter
{
    public class UserFilter : IActionFilter
    {
        public void OnActionExecuted(ActionExecutedContext context)
        {
            CommonHelper helper = new CommonHelper();
            byte[] rawGuestName = null;
            context.HttpContext.Session.TryGetValue(ApplicationConfiguration.ACTIVE_USER, out rawGuestName);

            if (rawGuestName == null)
            {
                context.Result = new RedirectToRouteResult(
                new RouteValueDictionary
                {
                    { "controller", "Home" },
                    { "action", "Index" }
                });
            }
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            Debug.WriteLine("OnActionExecuting Filter.");
        }
    }
}
