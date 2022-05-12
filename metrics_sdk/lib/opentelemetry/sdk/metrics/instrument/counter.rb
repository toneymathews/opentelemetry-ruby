# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module SDK
    module Metrics
      module Instrument
        # {Counter} is the SDK implementation of {OpenTelemetry::Metrics::Counter}.
        class Counter < OpenTelemetry::Metrics::Instrument::Counter
          attr_reader :name, :unit, :description, :instrumentation_library

          def initialize(name, unit, description, metric_store_registry, instrumentation_library)
            @name = name
            @unit = unit
            @description = description
            @metric_store_registry = metric_store_registry
            @instrumentation_library = instrumentation_library
          end

          # Increment the Counter by a fixed amount.
          #
          # @param [numeric] increment The increment amount, which MUST be a non-negative numeric value.
          # @param [Hash{String => String, Numeric, Boolean, Array<String, Numeric, Boolean>}] attributes
          #   Values must be non-nil and (array of) string, boolean or numeric type.
          #   Array values must not contain nil elements and all elements must be of
          #   the same basic type (string, numeric, boolean).
          def add(increment, attributes: nil)
            @metric_store_registry.produce(
              OpenTelemetry::Metrics::Measurement.new(increment, attributes),
              self
            )
          end
        end
      end
    end
  end
end
