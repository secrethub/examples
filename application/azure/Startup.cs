using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace azure
{
    public class Startup
    {
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapGet("/", async context =>
                {
                    string usernameEnvVar = Environment.GetEnvironmentVariable("DEMO_USERNAME");
                    string passwordEnvVar = Environment.GetEnvironmentVariable("DEMO_PASSWORD");
                    if( (string.IsNullOrEmpty(usernameEnvVar)) || (string.IsNullOrEmpty(passwordEnvVar)) ){
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync("DEMO_USERNAME or DEMO_PASSWORD environment variables were not set.");
                        return;
                    }

                    string username;
                    string password;
                    string outputSuccess = "";
                    try {

                        // First we check whether the username secret exists
                        if (!SecretHub.Client.Exists(usernameEnvVar))
                        {
                            context.Response.StatusCode = 500;
                            await context.Response.WriteAsync("Username secret does not exist.");
                            return;
                        }

                        // Then we read the 2 environment variables
                        username = SecretHub.Client.ReadString(usernameEnvVar);
                        password = SecretHub.Client.ReadString(passwordEnvVar);

                        outputSuccess += "Hello "+username+"!\n";

                        // To get more details about the secret, you can do this
                        SecretHub.SecretVersion secret = SecretHub.Client.Read(usernameEnvVar);
                        outputSuccess += "Username secret value's version: " + secret.Version.ToString() + "\n";

                    } catch(Exception ex) {
                        Console.WriteLine(ex.ToString());
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync("Error encountered while reading secrets.");
                        return;
                    }

                    string newPath = username + "/demo/new-secret";

                    try {
                        // Let's write a new secret
                        SecretHub.Client.Write(newPath, "Hello from SecretHub XGO.\n");
                        outputSuccess += "The new secret written is: " + SecretHub.Client.ReadString(newPath);
                    } catch(Exception ex) {
                        Console.WriteLine(ex.ToString());
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync(outputSuccess + "Error encountered while writing secret.");
                        return;
                    }

                    try {
                        // Now we will remove it
                        SecretHub.Client.Remove(newPath);
                        if (SecretHub.Client.Exists(newPath)) 
                        {
                            context.Response.StatusCode = 500;
                            await context.Response.WriteAsync(outputSuccess + "Secret was not removed.");
                            return;
                        }
                    } catch(Exception ex) {
                        Console.WriteLine(ex.ToString());
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync(outputSuccess + "Error encountered while removing secret.");
                        return;
                    }

                    try {
                        // In case you have to fetch a secret value from SecretHub by using a `reference` string 
                        // (it has the format `secrethub://<path>`), then you can do this:
                        string secretValue = SecretHub.Client.Resolve("secrethub://" + usernameEnvVar);
                        if (!username.Equals(secretValue))
                        {
                            context.Response.StatusCode = 500;
                            await context.Response.WriteAsync(outputSuccess + "Refernce string not resolved properly.");
                            return;
                        }
                    } catch(Exception ex) {
                        Console.WriteLine(ex.ToString());
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync(outputSuccess + "Error encountered while resolving reference.");
                        return;
                    }

                    try {
                        // Here we will get the list of environment variables and their values. If one's value is a 
                        // reference of the format `secrethub://<path>`, this function will replace it with the secret value,
                        // the one you will use in your code.
                        Dictionary<string, string> envVars = SecretHub.Client.ResolveEnv();
                        foreach(KeyValuePair<string, string> kvp in envVars)
                            outputSuccess += string.Format("Key: {0}, Value: {1}\n", kvp.Key, kvp.Value);
                    } catch(Exception ex) {
                        Console.WriteLine(ex.ToString());
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync(outputSuccess + "Error encountered while resolving environment variables.");
                        return;
                    }

                    await context.Response.WriteAsync(outputSuccess);
                });
            });
        }
    }
}
