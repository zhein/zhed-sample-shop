using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using ZHED_Shop.Models.ViewModels;
using System.Runtime.Serialization.Formatters;

namespace ZHED_Shop.Common
{
    public class CommonHelper
    {
        public List<ModelStateEntry> GetValidationMessage(ModelStateDictionary modelState)
        {
            var errorMessage = modelState.Values.ToList();
            return errorMessage;
        }

        public ResponseModel GetDefaultResponse()
        {
            return new ResponseModel()
            {
                Status = false,
                Data = null,
                Message = string.Empty,
                Details = string.Empty
            };
        }

        public string ConvertByteToString(byte[] rawData)
        {
            string cleanData = System.Text.Encoding.UTF8.GetString(rawData);
            return cleanData;
        }
    }
}
