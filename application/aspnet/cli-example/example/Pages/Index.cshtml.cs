using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;

namespace example.Pages
{
    public class IndexModel : PageModel
    {
        public string Content()
        {
          string content;
          string username = Environment.GetEnvironmentVariable("DEMO_USERNAME");
          string password = Environment.GetEnvironmentVariable("DEMO_PASSWORD");

          if( (string.IsNullOrEmpty(username)) || (string.IsNullOrEmpty(username)) ){
            Response.StatusCode = 500;
            content = "not all variables are set";
          }
          else{
            Response.StatusCode = 200;
            content = "Welcome " + username;
          }
          return content;
        }

        public void OnGet()
        {
        }
    }
}
