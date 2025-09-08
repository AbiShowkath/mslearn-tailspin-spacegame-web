FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

RUN apt-get update && apt-get install -y curl ca-certificates gnupg2 \
&& curl -fsSL http://deb.nodesource.com/setup_18.x | bash - \
&& apt-get install -y nodejs

COPY package*.json ./
RUN npm install --no-audit --no-fund
RUN npx sass Tailspin.SpaceGame.Web/wwwroot -I Tailspin.SpaceGame.Web/wwwroot || true
RUN npx gulp || true

COPY Tailspin.SpaceGame.Web/*.csproj Tailspin.SpaceGame.Web/
RUN dotnet restore Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj

COPY . .

RUN dotnet publish Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT [ "dotnet", "Tailspin.SpaceGame.Web.dll" ]
