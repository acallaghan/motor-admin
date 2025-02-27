# frozen_string_literal: true

module Motor
  module BuildSchema
    ACTIVE_STORAGE_ATTACHMENT_SCHEMA = {
      name: 'active_storage/attachment',
      slug: 'active_storage__attachments',
      class_name: 'ActiveStorage::Attachment',
      table_name: 'active_storage_attachments',
      primary_key: 'id',
      display_name: 'Attachments',
      display_column: 'filename',
      icon: 'paperclip',
      columns: [
        {
          name: 'id',
          display_name: 'ID',
          column_type: 'integer',
          access_type: 'read_only',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: false
        },
        {
          name: 'path',
          display_name: 'Path',
          column_type: 'string',
          access_type: 'read_only',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: true
        },
        {
          name: 'name',
          display_name: 'Name',
          column_type: 'string',
          access_type: 'read_write',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: false
        },
        {
          name: 'record_type',
          display_name: 'Record type',
          column_type: 'string',
          access_type: 'read_write',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: false
        },
        {
          name: 'record_id',
          display_name: 'Record',
          column_type: 'integer',
          access_type: 'read_write',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: {
            name: 'record',
            display_name: 'Record',
            model_name: nil,
            reference_type: 'belongs_to',
            foreign_key: 'record_id',
            polymorphic: true
          },
          virtual: false
        },
        {
          name: 'file',
          display_name: 'File',
          column_type: 'file',
          access_type: 'write_only',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: false
        },
        {
          name: 'created_at',
          display_name: 'Created at',
          column_type: 'datetime',
          access_type: 'read_only',
          default_value: nil,
          validators: [],
          format: {},
          is_array: false,
          reference: nil,
          virtual: false
        }
      ],
      associations: [],
      scopes: [],
      actions: Motor::BuildSchema::DEFAULT_ACTIONS.reject { |e| e[:name] == 'edit' },
      tabs: Motor::BuildSchema::DEFAULT_TABS,
      visible: true
    }.with_indifferent_access
  end
end
