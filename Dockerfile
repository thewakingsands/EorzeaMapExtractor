FROM mcr.microsoft.com/dotnet/sdk:7.0 AS builder
COPY "." "/src"
WORKDIR "/src"
RUN dotnet build --configuration Release

FROM ghcr.io/featuredcontainers/wine-dotnet:main
COPY --from=builder /src/EorzeaMapExtractor.Cli/bin/Release/net7.0/ /app
ENV WINEARCH=win32
RUN winetricks gdiplus && \
  rm -rf /root/.cache
ENTRYPOINT [ "wine", "/dotnet/win32/dotnet.exe", "/app/EorzeaMapExtractor.Cli.dll" ]
