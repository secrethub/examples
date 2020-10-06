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
            SecretHub.Client client;
            string user, username, password;

            try
            {
                client = new SecretHub.Client();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error in client creation";
            }
            try
            {
                user = System.Environment.GetEnvironmentVariable("SECRETHUB_USERNAME");

            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error in fetching username";
            }
            try
            {
                username = client.Read(user + "/demo/username").Data;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error in reading demo username";
            }
            try
            {
                password = client.Read(user + "/demo/password").Data;
                return "Hello, " + username + "!";
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error in reading demo password";
            }
        }
    }
}
