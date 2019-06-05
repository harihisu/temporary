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
FROM docker:18.09-dind as sam-build
WORKDIR /app

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN apk update && \
    apk upgrade && \
    apk add bash && \
    apk add --no-cache --virtual build-deps build-base gcc && \
    pip install aws-sam-cli==0.17.0 && \
    apk del build-deps

COPY --from=dotnet-build /app/dist .
COPY ./template.yml .
COPY ./run_api.sh .

# ENTRYPOINT ["dockerd-entrypoint.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]