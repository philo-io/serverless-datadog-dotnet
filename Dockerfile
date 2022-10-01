FROM scratch
COPY --from=public.ecr.aws/datadog/lambda-extension:29 /opt/. /opt/
COPY --from=ghcr.io/philo-io/datadog-tracer-dotnet:2.15.0 /opt/datadog /opt/datadog
