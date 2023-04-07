namespace :prepara do
  desc "Actualiza la ruta del backend de designer, de las imágnes de los tipos de equipo para que los pueda usar el frontend de designer, durante la asignación de cargas"

  task designer: :environment do
    id           = [844 ,99, 1363, 1692, 124, 236, 211, 579, 140, 843, 252, 921, 7, 276, 101, 36, 138, 71, 76]
    grupo        = %w[green green green golden golden golden golden golden golden coral coral coral coral coral coral coral coral coral red red]
   image_tareas_60_40_url   = %w[/img/alectrico_60_40.png /img/mantencion_electrica_60_40.png /img/atencion_corte_de_luz_60_40.png /img/proyecto_energia_solar_60_40.png /img/instalacion_luminaria_60_40.png /img/instalacion_enchufe_60_40.png /img/instalador_sec_60_40.png]
   image_60_40_url    = %w[/img/led_60_40.png /img/ampolleta_incandescente_60_40.png /img/juguera_60_40.png /img/microondas_60_40.png /img/hornillo_60_40.png /img/hervidor_60_40.png /img/olla_arrocera_60_40.png /img/cafetera_expresso_60_40.png /img/plancha_60_40.png /img/frigobar_60_40.png /img/refrigerador_60_40.png /img/refrigerador_dos_puertas_60_40.png /img/lavadora_de_ropa_60_40.png /img/secadora_de_ropa_60_40.png /img/lavaplatos_60_40.png /img/splitter_60_40.png /img/pc_60_40.png /img/encimera_60_40.png /img/encimera_induccion_60_40.png]
   image_tareas_url = %w[img/mantencion_electrica.png /img/atencion_corte_de_luz.png /img/proyecto_energia_solar.png /img/instalacion_luminaria.png /img/instalacion_enchufe.png /img/instalador_sec.png]
   full_image_url = %w[ /img/led.png /img/ampolleta_incandescente.png /img/juguera.png /img/microondas.png /img/hornillo.png /img/hervidor.png /img/olla_arrocera.png /img/cafetera_expresso.png /img/plancha.png /img/frigobar.png /img/refrigerador.png /img/refrigerador_dos_puertas.png /img/lavadora_de_ropa.png /img/secadora_de_ropa.png /img/lavaplatos.png /img/splitter.png /img/pc.png /img/encimera.png /img/encimera_induccion.png]

    id.each_with_index do |id, index |

       equipo = Electrico::TipoEquipo.find_or_create_by(:id => id) do |u|
         #esto es un parche. No son datos correctos. Deben crearse los tipos de equipos correctos.
         u.id = id
	 u.nombre = full_image_url[index]
	 u.img    = full_image_url[index]
	 u.i = 1.87
	 u.p = 350
	 u.modelo = 'Inventado'
	 u.tension = 220
	 u.fp = 0.85
	 u.curva = 'C'
	 u.es_monofasico = true
	 u.capacitancia_necesaria = 14

       end
       
       if equipo
       equipo.update_attributes(:img => full_image_url[index])
       puts "id:#{id} Se actualizó #{equipo.nombre} con #{equipo.img} del grupo #{grupo[index]}"
       else
	 puts "No se pudo encontrar el id #{id}"
       end

       equipo.to_json if equipo

    end
  end
end
