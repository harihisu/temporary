# Build dotnet
FROM microsoft/dotnet:2.2-sdk AS dotnet-build
WORKDIR /app

COPY *.sln .
COPY src/DebuggingExample/DebuggingExample.csproj ./src/DebuggingExample/DebuggingExample.csproj
COPY test/DebuggingExample.Tests/DebuggingExample.Tests.csproj ./test/DebuggingExample.Tests/DebuggingExample.Tests.csproj
RUN dotnet restore

# Copy all the source code and build
COPY ./test ./test
COPY ./src ./src
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release --no-build -o "/app/dist" --self-contained

# # Build SAM
FROM harihisu/serverless:sam as sam-build
WORKDIR /app

COPY --from=dotnet-build /app/dist .
COPY ./template.yml .

# ENTRYPOINT ["sam", "local", "start-api"]
CMD tail -f /dev/null
