class CreateShortUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :short_urls do |t|
      t.text     :original_url, null: false
      t.string   :short_code, null: false
      t.boolean  :is_active, default: true, null: false

      t.timestamps
    end

    add_index :short_urls, :short_code, unique: true
    add_index :short_urls, [:original_url, :is_active]
  end
end
