FROM public.ecr.aws/datadog/lambda-extension:29 AS extension
FROM ghcr.io/philo-io/datadog-tracer-dotnet:2.15.0 AS tracer

FROM scratch
COPY --from=extension /opt/. /opt/
COPY --from=tracer /opt/datadog /opt/datadog
