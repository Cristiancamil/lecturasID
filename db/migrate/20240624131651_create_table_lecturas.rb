class CreateTableLecturas < ActiveRecord::Migration[7.1]
  def change
    create_table :lecturas do |t|
      t.integer :lectura_anterior
      t.integer :lectura_actual
      t.integer :consumo
      t.timestamps
    end
  end
end
