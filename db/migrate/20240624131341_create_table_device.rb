class CreateTableDevice < ActiveRecord::Migration[7.1]
  def change
    create_table :devices, id: false do |t|
      t.integer :id
      t.text :bodega
      t.text :local
      t.text :factor
      t.timestamps
    end
  end
end
