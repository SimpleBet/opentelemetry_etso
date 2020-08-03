# OpentelemetryEtso

Telemetry handler that creates Opentelemetry spans from Etso Ecto query events. 
Because Etso emits all standard telemetry events, OpentelemetryEtso requires a
different handling from the OpentelemetryEcto handlers

After installing, setup the handler in your application behaviour before your
top-level supervisor starts.

```elixir
OpentelemetryEtso.setup()
```

See the documentation for `OpentelemetryEtso.setup/1` for additional options that
may be supplied.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `opentelemetry_etso` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:opentelemetry_etso, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/opentelemetry_etso](https://hexdocs.pm/opentelemetry_etso).

