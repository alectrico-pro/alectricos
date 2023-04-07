class AddColumnNombreCompletoToAutorizados < ActiveRecord::Migration[6.0]
  def change
    add_column :autorizados, :nombre_completo, :string
  end
end
