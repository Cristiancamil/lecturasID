class Lecturas < ActiveRecord::Migration[7.1]
  def change
    create_table :lecturas, id: false do |t|
      t.integer :id
      t.text :bodega
      t.text :local
      t.text :factor
      t.integer :lectura_anterior
      t.integer :lectura_actual
      t.integer :consumo

      t.timestamps
    end
  end
end
