class CreaTablaAutorizado < ActiveRecord::Migration[6.0]
  def change
    create_table "autorizados", force: :cascade do |t|
      t.string "rut"
      t.string "nombre"
      t.string "direccion"
      t.string "comuna"
      t.string "fono"
      t.integer "clase"
      t.string "email"
      t.integer "interes"
      t.integer "llamadas_telefonicas"
      t.integer "envios_de_email"
      t.integer "reclutamiento"
      t.integer "suscripcion"
      t.integer "presentacion"
      t.integer "pedido_adicional_de_informacion"
      t.integer "wapp"
      t.string "comentario"
      t.string "desuscripcion_token"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
