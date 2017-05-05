
# Synergy .NET Web API 2 Example

This repository contains an examples of implementing ASP.NET Web API 2 RESTful
web services in Synergy .NET.

This example was used during the RESTful web services presentation at the 2017
DevPartner Conference.

Requirements

1. Visual Studio 2015 or 2017.
2. Synergy/DE, inclyding Synergy DBL integration for Visual Studio.
3. Internet Information Server.

Basic setup instructions:

1. Clone the repository to a local folder
2. Open a command prompt and execute the setup.bat script to load data files and repository.
3. Start Visual Studio as administrator and open the solution.
4. In the WebApiServices project, edit WebApiServicesConfog.dbl and set the value of the DAT environment variable to an appropriate value for your system.
5. In the properties of the WebServer project, go to the Web tab and click the Create Virtual Directory button.

