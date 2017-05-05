using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using WebApiServices;
using WebApiServices.Filters;

namespace WebServer
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            //Implement a Unity IoC container
            config.DependencyResolver = WebApiServicesConfig.GetUnityResolver();

            // Web API configuration and services
            config.Filters.Add(new ValidateModelAttribute());

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
