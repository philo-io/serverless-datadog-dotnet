FROM public.ecr.aws/datadog/lambda-extension:29 AS datadog-extension

FROM alpine:latest AS datadog-tracer
RUN apk add tar wget gzip
RUN mkdir /opt/datadog
COPY Project.csproj .
RUN VERSION=$(cat Project.csproj | grep Datadog.Trace | sed 's/.*Version="\([^"]*\).*/\1/i') && \
    wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v$VERSION/datadog-dotnet-apm-$VERSION.tar.gz && \
    tar -C /opt/datadog -xzf datadog-dotnet-apm-$VERSION.tar.gz

FROM scratch
COPY --from=datadog-extension /opt/. /opt/
COPY --from=datadog-tracer /opt/datadog /opt/datadog
