FROM public.ecr.aws/datadog/lambda-extension:28 AS datadog-extension

FROM alpine:latest AS datadog-tracer
ARG DD_TRACER_VERSION=2.15.0
RUN apk add tar wget gzip
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${DD_TRACER_VERSION}/datadog-dotnet-apm-${DD_TRACER_VERSION}.tar.gz
RUN mkdir /opt/datadog
RUN tar -C /opt/datadog -xzf datadog-dotnet-apm-${DD_TRACER_VERSION}.tar.gz

FROM scratch
COPY --from=datadog-extension /opt/. /opt/
COPY --from=datadog-tracer /opt/datadog /opt/datadog
