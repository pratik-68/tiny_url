class CreateClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :clicks do |t|
      t.references :short_url, null: false, foreign_key: true
      t.datetime   :clicked_at, null: false

      t.timestamps
    end

    add_index :clicks, [:short_url_id, :clicked_at]
  end
end
