ARG DD_EXTENSION_VERSION=29
FROM public.ecr.aws/datadog/lambda-extension:$DD_EXTENSION_VERSION AS datadog-extension
ARG DD_TRACER_VERSION=2.15.0
# COPY --from=datadog-extension /opt/. /opt/
RUN apk add tar wget gzip
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${DD_TRACER_VERSION}/datadog-dotnet-apm-${DD_TRACER_VERSION}.tar.gz
RUN mkdir /opt/datadog
RUN tar -C /opt/datadog -xzf datadog-dotnet-apm-${DD_TRACER_VERSION}.tar.gz
