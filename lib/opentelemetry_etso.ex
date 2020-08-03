defmodule OpentelemetryEtso do
  @moduledoc """
  Telemetry handler for creating OpenTelemetry Spans from Ecto query events.
  """

  require OpenTelemetry.Span
  require OpenTelemetry.Tracer

  @doc """
  Attaches the OpentelemetryEtso handler to your repo events. This should be called
  from your application behaviour on startup.

  Example:

      OpentelemetryEtso.setup()

  You may also supply the following options in the second argument:

    *
  """
  def setup(config \\ []) do
    # register the tracer. just re-registers if called for multiple repos
    _ = OpenTelemetry.register_application_tracer(:opentelemetry_etso)

    events = [
      [:ecto, :query, :start],
      [:ecto, :query, :stop],
      [:ecto, :query, :exception]
    ]

    :telemetry.attach_many({__MODULE__, :handlers}, events, &__MODULE__.handle_event/4, config)
  end

  @doc false
  def handle_event(
        [:ecto, :query, :start],
        _measurements,
        %{query: query, source: source, params: params, repo: repo, type: :etso_query},
        _config
      ) do
    span_name = "etso:query"

    attributes = [
      {"db.type", "ets"},
      {"db.statement", "#{inspect(query)}"},
      {"source", "#{inspect(source)}"},
      {"repo", "#{repo}"},
      {"params", "#{inspect(params)}"},
      {"adapter", "etso"}
    ]

    OpenTelemetry.Tracer.start_span(span_name, %{attributes: attributes})
  end

  def handle_event([:ecto, :query, :stop], _measurements, %{type: :etso_query}, _config) do
    OpenTelemetry.Tracer.end_span()
  end

  def handle_event(
        [:ecto, :query, :exception],
        _measurements,
        %{type: :etso_query} = meta,
        _config
      ) do
    exception_attrs = [
      {"type", to_string(meta.kind)},
      {"message", meta.reason.message},
      {"stacktrace", "#{inspect(meta.stacktrace)}"}
    ]

    OpenTelemetry.Span.add_event("exception", exception_attrs)

    OpenTelemetry.status(:InternalError, "")
    |> OpenTelemetry.Span.set_status()

    OpenTelemetry.Tracer.end_span()
  end
end
