FROM public.ecr.aws/datadog/lambda-extension:29 AS datadog-extension

FROM alpine:latest AS datadog-tracer
RUN apk add tar wget gzip
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v2.14.0/datadog-dotnet-apm-2.14.0.tar.gz
RUN mkdir /opt/datadog
RUN tar -C /opt/datadog -xzf datadog-dotnet-apm-2.14.0.tar.gz

FROM scratch
COPY --from=datadog-extension /opt/. /opt/
COPY --from=datadog-tracer /opt/datadog /opt/datadog
