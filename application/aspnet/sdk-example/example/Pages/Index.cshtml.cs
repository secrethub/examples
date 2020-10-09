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
                var secrets = new SecretHub.Client().ResolveEnv();
                string username = secrets["DEMO_USERNAME"];
                string password = secrets["DEMO_PASSWORD"];
                return "Hello, " + username + "!";
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return "your username, password or secrethub credential have not been set correctly.";
            }
        }
    }
}
