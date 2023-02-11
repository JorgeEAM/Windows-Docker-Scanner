FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

WORKDIR /inetpub/wwwroot

SHELL ["powershell"]

RUN Remove-Website -Name 'Default Web Site';
RUN Remove-Item -Recurse C:\inetpub\wwwroot\*;
RUN New-Website -Name 'TestSite' -Port 80 -PhysicalPath C:\inetpub\wwwroot;
RUN New-WebApplication -Name 'TestApplication' -Site 'TestSite' -PhysicalPath C:\inetpub\wwwroot;
RUN dism /online /enable-feature /featurename:IIS-ASPNET45 /all;

WORKDIR /inetpub/wwwroot

COPY ./content/ ./