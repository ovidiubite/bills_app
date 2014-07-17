class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.string :author
      t.date :limit_date

      t.timestamps
    end
  end
end
