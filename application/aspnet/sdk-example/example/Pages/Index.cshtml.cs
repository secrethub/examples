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
            Dictionary<string, string> secrets;
            string username, password;

            try
            {
                secrets = new SecretHub.Client().ResolveEnv();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error creating client/resolving environment";
            }
            try
            {
                username = secrets[System.Environment.GetEnvironmentVariable("DEMO_USERNAME")];
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error reading demo username";
            }
            try
            {
                password = secrets[System.Environment.GetEnvironmentVariable("DEMO_PASSWORD")];
                return "Hello, " + username + "!";
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "error reading demo password";
            }
        }
    }
}
