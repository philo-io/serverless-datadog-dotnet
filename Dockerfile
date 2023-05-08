FROM public.ecr.aws/datadog/lambda-extension:39 AS extension
FROM ghcr.io/philo-io/datadog-tracer-dotnet:2.30.0 AS tracer

FROM scratch
COPY --from=extension /opt/. /opt/
COPY --from=tracer /opt/datadog /opt/datadog
