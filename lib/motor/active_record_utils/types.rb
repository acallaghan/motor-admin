# frozen_string_literal: true

module Motor
  module ActiveRecordUtils
    module Types
      MUTEX = Mutex.new
      DEFAULT_TYPE = 'string'

      UNIFIED_TYPES = {
        'smallint' => 'integer',
        'int' => 'integer',
        'int4' => 'integer',
        'int8' => 'integer',
        'int16' => 'integer',
        'bigint' => 'integer',
        'numeric' => 'float',
        'decimal' => 'float',
        'float4' => 'float',
        'float8' => 'float',
        'float16' => 'float',
        'text' => 'string',
        'citext' => 'string',
        'jsonb' => 'json',
        'timestamp' => 'datetime'
      }.freeze

      module_function

      def all
        @all || MUTEX.synchronize do
          @all ||= build_types_hash
        end
      end

      def find_class_for_name(name)
        all.invert[name.to_s]
      end

      def find_name_for_class(klass)
        name = all[klass.to_s]

        return UNIFIED_TYPES.fetch(name, name) if name

        DEFAULT_TYPE
      end

      def build_types_hash
        type_map = ActiveRecord::Base.connection.send(:type_map)

        type_map.instance_variable_get('@mapping').map do |name, type|
          next unless name.is_a?(String)

          [type.call.class.to_s, name]
        end.compact.to_h
      end
    end
  end
end
