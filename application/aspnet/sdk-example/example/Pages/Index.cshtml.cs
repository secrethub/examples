using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
namespace example.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        public string Message { get; set; }
        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }
        public void OnGet()
        {
            Message = response();
        }
        public static string response()
        {
            try
            {
                var client = new SecretHub.Client();
                try
                {
                    var user = System.Environment.GetEnvironmentVariable("SECRETHUB_USERNAME");
                    try
                    {
                        var username = client.Read(user + "/demo/username").Data;
                        try
                        {
                            var password = client.Read(user + "/demo/password").Data;
                            return "Hello, " + username + "!";
                        }
                        catch
                        {
                            return "error in reading demo password";
                        }
                    }
                    catch
                    {
                        return "error in reading demo username";
                    }
                }
                catch
                {
                    return "error in fetching username";
                }
            }
            catch
            {
                return "error in client creation";
            }
        }
    }
}