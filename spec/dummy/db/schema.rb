# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_714_081_950) do
  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false, default: ''
    t.string 'encrypted_password', null: false, default: ''

    t.string 'reset_password_token'
    t.string 'role', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false

    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness',
                                          unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false if Rails::VERSION::MAJOR >= 6 && Rails::VERSION::MINOR >= 1
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'countries', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'code', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['code'], name: 'index_countries_on_code', unique: true
  end

  create_table 'line_items', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'product_id', null: false
    t.float 'unit_price', null: false
    t.integer 'quantity', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_line_items_on_order_id'
    t.index ['product_id'], name: 'index_line_items_on_product_id'
  end

  create_table 'order_notes', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.text 'body', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_notes_on_order_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.text 'address_line_one', null: false
    t.text 'address_line_two'
    t.text 'address_city', null: false
    t.text 'address_state', null: false
    t.text 'address_zip', null: false
    t.text 'status', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'shipped_at'
    t.index ['customer_id'], name: 'index_orders_on_customer_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.text 'name', null: false
    t.text 'email', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'email_subscriber', null: false, default: true
    t.text 'kind', null: false
    t.text 'country_code', null: false
  end

  create_table 'products', force: :cascade do |t|
    t.text 'name', null: false
    t.float 'price', null: false
    t.text 'description', null: false
    t.text 'category', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug', null: false
    t.bigint 'release_year', null: false
    t.index ['slug'], name: 'index_products_on_slug', unique: true
  end

  create_table 'motor_alert_locks', force: :cascade do |t|
    t.bigint 'alert_id', null: false
    t.string 'lock_timestamp', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[alert_id lock_timestamp], name: 'index_motor_alert_locks_on_alert_id_and_lock_timestamp', unique: true
    t.index ['alert_id'], name: 'index_motor_alert_locks_on_alert_id'
  end

  create_table 'motor_alerts', force: :cascade do |t|
    t.bigint 'query_id', null: false
    t.string 'name', null: false
    t.text 'description'
    t.text 'to_emails', null: false
    t.boolean 'is_enabled', default: true, null: false
    t.text 'preferences', null: false
    t.bigint 'author_id'
    t.string 'author_type'
    t.datetime 'deleted_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index 'name', name: 'motor_alerts_name_unique_index', unique: true,
                    where: '(deleted_at IS NULL)'
    t.index ['query_id'], name: 'index_motor_alerts_on_query_id'
  end

  create_table 'motor_audits', force: :cascade do |t|
    t.bigint 'auditable_id'
    t.string 'auditable_type'
    t.bigint 'associated_id'
    t.string 'associated_type'
    t.bigint 'user_id'
    t.string 'user_type'
    t.string 'username'
    t.string 'action'
    t.text 'audited_changes'
    t.integer 'version', default: 0
    t.text 'comment'
    t.string 'remote_address'
    t.string 'request_uuid'
    t.datetime 'created_at'
    t.index %w[associated_type associated_id], name: 'associated_index'
    t.index %w[auditable_type auditable_id version], name: 'auditable_index'
    t.index ['created_at'], name: 'index_motor_audits_on_created_at'
    t.index ['request_uuid'], name: 'index_motor_audits_on_request_uuid'
    t.index %w[user_id user_type], name: 'user_index'
  end

  create_table 'motor_configs', force: :cascade do |t|
    t.string 'key', null: false
    t.text 'value', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['key'], name: 'index_motor_configs_on_key', unique: true
  end

  create_table 'motor_dashboards', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'description'
    t.text 'preferences', null: false
    t.bigint 'author_id'
    t.string 'author_type'
    t.datetime 'deleted_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index 'title', name: 'motor_dashboards_title_unique_index', unique: true,
                     where: '(deleted_at IS NULL)'
  end

  create_table 'motor_forms', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.text 'api_path', null: false
    t.text 'http_method', null: false
    t.text 'preferences', null: false
    t.bigint 'author_id'
    t.string 'author_type'
    t.datetime 'deleted_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index 'name', name: 'motor_forms_name_unique_index', unique: true,
                    where: '(deleted_at IS NULL)'
    t.index ['updated_at'], name: 'index_motor_forms_on_updated_at'
  end

  create_table 'motor_queries', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.text 'sql_body', null: false
    t.text 'preferences', null: false
    t.bigint 'author_id'
    t.string 'author_type'
    t.datetime 'deleted_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index 'name', name: 'motor_queries_name_unique_index', unique: true,
                    where: '(deleted_at IS NULL)'
  end

  create_table 'motor_resources', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'preferences', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_motor_resources_on_name', unique: true
  end

  create_table 'motor_taggable_tags', force: :cascade do |t|
    t.bigint 'tag_id', null: false
    t.bigint 'taggable_id', null: false
    t.string 'taggable_type', null: false
    t.index ['tag_id'], name: 'index_motor_taggable_tags_on_tag_id'
    t.index %w[taggable_id taggable_type tag_id], name: 'motor_polymorphic_association_tag_index', unique: true
  end

  create_table 'motor_tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index 'name', name: 'motor_tags_name_unique_index', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'line_items', 'orders'
  add_foreign_key 'line_items', 'products'
  add_foreign_key 'motor_alert_locks', 'motor_alerts', column: 'alert_id'
  add_foreign_key 'motor_alerts', 'motor_queries', column: 'query_id'
  add_foreign_key 'motor_taggable_tags', 'motor_tags', column: 'tag_id'
  add_foreign_key 'orders', 'customers'
end
