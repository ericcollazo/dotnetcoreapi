## Use build image
FROM mcr.microsoft.com/dotnet/core/sdk:2.2.402-bionic AS build-env

## Set working directory
WORKDIR /app

# copy everything and build
COPY . ./

RUN dotnet publish -c Release -o out

# build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2.7-bionic

WORKDIR /app

COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "dotnetcoreapi.dll"]