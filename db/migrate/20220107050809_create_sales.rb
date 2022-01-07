class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.integer :percent_off
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
