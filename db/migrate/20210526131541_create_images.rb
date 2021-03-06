class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :imagable, polymorphic: true, null: false
      t.jsonb :image_data

      t.timestamps
    end
  end
end
