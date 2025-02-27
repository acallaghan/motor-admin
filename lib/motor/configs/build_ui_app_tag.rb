# frozen_string_literal: true

module Motor
  module Configs
    module BuildUiAppTag
      CACHE_STORE =
        if Motor.development?
          ActiveSupport::Cache::NullStore.new
        else
          ActiveSupport::Cache::MemoryStore.new(size: 5.megabytes)
        end

      module_function

      def call(current_user = nil, current_ability = nil)
        cache_keys = LoadFromCache.load_cache_keys

        CACHE_STORE.fetch("#{cache_keys.hash}#{current_user&.id}") do
          CACHE_STORE.clear

          data = build_data(cache_keys, current_user, current_ability)
          Motor::ApplicationController.helpers.tag.div('', id: 'app', data: data)
        end
      end

      # @return [Hash]
      def build_data(cache_keys = {}, current_user = nil, current_ability = nil)
        {
          current_user: current_user&.as_json(only: %i[id email]),
          current_rules: current_ability.serialized_rules,
          audits_count: Motor::Audit.count,
          base_path: Motor::Admin.routes.url_helpers.motor_path,
          schema: Motor::BuildSchema.call(cache_keys, current_ability),
          header_links: header_links_data_hash(cache_keys[:configs]),
          queries: queries_data_hash(build_cache_key(cache_keys, :queries, current_user, current_ability),
                                     current_ability),
          dashboards: dashboards_data_hash(build_cache_key(cache_keys, :dashboards, current_user, current_ability),
                                           current_ability),
          alerts: alerts_data_hash(build_cache_key(cache_keys, :alerts, current_user, current_ability),
                                   current_ability),
          forms: forms_data_hash(build_cache_key(cache_keys, :forms, current_user, current_ability), current_ability)
        }
      end

      # @return [String]
      def build_cache_key(cache_keys, key, current_user, current_ability)
        "#{cache_keys[key].hash}#{current_user&.id}#{current_ability&.rules_hash}"
      end

      def header_links_data_hash(cache_key = nil)
        configs = Motor::Configs::LoadFromCache.load_configs(cache_key: cache_key)

        configs.find { |c| c.key == 'header.links' }&.value || []
      end

      def queries_data_hash(cache_key = nil, current_ability = nil)
        Motor::Configs::LoadFromCache.load_queries(cache_key: cache_key, current_ability: current_ability)
                                     .as_json(only: %i[id name updated_at],
                                              include: { tags: { only: %i[id name] } })
      end

      def dashboards_data_hash(cache_key = nil, current_ability = nil)
        Motor::Configs::LoadFromCache.load_dashboards(cache_key: cache_key, current_ability: current_ability)
                                     .as_json(only: %i[id title updated_at],
                                              include: { tags: { only: %i[id name] } })
      end

      def alerts_data_hash(cache_key = nil, current_ability = nil)
        Motor::Configs::LoadFromCache.load_alerts(cache_key: cache_key, current_ability: current_ability)
                                     .as_json(only: %i[id name is_enabled updated_at],
                                              include: { tags: { only: %i[id name] } })
      end

      def forms_data_hash(cache_key = nil, current_ability = nil)
        Motor::Configs::LoadFromCache.load_forms(cache_key: cache_key, current_ability: current_ability)
                                     .as_json(only: %i[id name updated_at],
                                              include: { tags: { only: %i[id name] } })
      end
    end
  end
end
