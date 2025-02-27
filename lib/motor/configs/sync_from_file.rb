# frozen_string_literal: true

module Motor
  module Configs
    module SyncFromFile
      FILE_PATH = Motor::Configs::FILE_PATH
      MUTEXT = Mutex.new
      FILE_TIMESTAMPS_STORE = ActiveSupport::Cache::MemoryStore.new(size: 1.megabyte)

      module_function

      def call(with_exception: false)
        MUTEXT.synchronize do
          file = Rails.root.join(FILE_PATH)

          file_timestamp =
            begin
              file.ctime
            rescue Errno::ENOENT
              raise if with_exception

              nil
            end

          next unless file_timestamp

          FILE_TIMESTAMPS_STORE.fetch(file_timestamp.to_s) do
            Motor::Configs::SyncFromHash.call(
              YAML.safe_load(file.read, permitted_classes: [Time, Date])
            )
          end
        end
      end
    end
  end
end
