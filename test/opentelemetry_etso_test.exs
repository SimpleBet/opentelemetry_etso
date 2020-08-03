defmodule OpentelemetryEtsoTest do
  require OpenTelemetry.Tracer
  use ExUnit.Case

  require Record

  for {name, spec} <- Record.extract_all(from_lib: "opentelemetry/include/ot_span.hrl") do
    Record.defrecord(name, spec)
  end

  setup do

    :ot_batch_processor.set_exporter(:ot_exporter_pid, self())

    OpenTelemetry.Tracer.start_span("test")

    on_exit(fn ->
      OpenTelemetry.Tracer.end_span()
    end)
  end

  # test "captures basic query events"
end
