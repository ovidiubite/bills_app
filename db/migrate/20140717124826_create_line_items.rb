class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.belongs_to :bill, index: true

      t.timestamps
    end
  end
end
