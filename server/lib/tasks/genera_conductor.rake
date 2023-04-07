namespace :genera do
  desc "Crea la table de conductores, a partir de la tabla 8.7"

  task conductor: :environment do

    izth_A_60 = [20, 25, 30, 40, 55  ,
                    70, 85, 95, 110, 125, 145,
		    165, 195, 215, 240, 250, 280,
		    320, 355, 385, 400, 410, 435,
		    455, 495, 520, 545, 560 ]
    izth_B_60 = [ 25, 30, 40, 60, 80,
		     105, 120, 140, 165, 195, 225,
		     260, 300, 340, 375, 420, 455,
		     515, 575, 630, 655, 680, 730,
		     780, 890, 980, 1070, 1155]
    izth_A_75 = [ 20, 25, 35, 50, 65,
		     85, 100, 115, 130, 150, 175,
		     200, 230, 255, 285, 310, 335,
		     380, 420, 460, 475, 490, 520,
		     545, 590, 625, 650, 665]
    izth_B_75 = [ 30, 35, 50, 70, 95,
		     125, 145, 170, 195, 230, 265,
		     310, 360, 405, 445, 505,545,
		     620, 690, 755, 785, 815, 870,
		     935, 1065, 1175, 1280, 1385]
    izth_A_90 = [ 25, 30, 40, 55, 75,
		     95, 110, 130, 150, 170, 195,
		     225, 260, 290, 320, 350, 380,
		     430, 475, 520, 535, 555, 585,
		     615, 665, 705, 735, 750]
    izth_B_90 = [ 35, 40, 55, 80, 105,
		     140, 165, 190, 220, 260, 300,
		     350, 405, 455, 505, 570, 615,
		     700, 780, 855, 885, 920, 985,
		     1055, 1200, 1325, 1455, 1560]
    izth_grupo_1_70 = [ -1, 11, 15, 20, 25,
			33, 45, 61, 83, 103,
			132, 164, 197, 235,-1,
			 -1, -1, -1, -1, -1]
    izth_grupo_2_70 = [12, 15, 19, 25, 34,
		       44, 61, 82, 108, 134,
		       167, 207, 249, 291, 327,
		       274, 442, 510, -1, -1]
    izth_grupo_3_70 = [15, 19, 23, 32, 42,
		       54, 73, 98, 129, 158,
		       197, 244, 291, 343, 382,
		       436, 516, 595, 708, 809]
    izth_excepcion = [ 16, 20, 32 ]
    seccion_alambre = [0.75, 1, 1.5, 2.5, 4,
		       6, 10, 16, 25, 35,
		       50, 70, 95, 120, 150,
		       185, 240, 300, 400, 500]
    
    seccion_cable  = [2.08, 3.31, 5.26, 8.37, 13.3,
		      21.2, 26.7, 33.6, 42.4, 53.5, 67.4,
		      85, 107.2, 126.7, 151.8, 177.3, 202.7,
		      253.2, 303.6, 354.7, 379.5, 405.4, 456.0,
		      506.7, 633.4, 750.1, 886.7, 10013]
    awg            = ['14',   '12',  '10', '8' , '6',
		       '4',    '3',   '2',  '1','1/0', '2/0',
		       '3/0',  '4/0'] #Faltan más, pero no los econtré, awg es un campo integer habrá que cambiarlo algún día
    izth_cable = [ izth_A_60, izth_B_60, izth_A_75, izth_B_75, izth_A_90, izth_B_90]
    izth_alambre = [izth_grupo_1_70, izth_grupo_2_70, izth_grupo_3_70]
    grupo_cable = [ 'A', 'B', 'A', 'B' , 'A', 'B' ]
    grupo_alambre = [ '1','2', '3' ]
    temperatura_alambre = [ 70, 70, 70]

    temperatura_cable = [ 60, 60, 75, 75, 90, 90 ]
    Electrico::Conductor.delete_all
    largo = seccion_cable.length - 1 

    for j in 0..5
      for i in 0..largo
	Electrico::Conductor.create do |u|
	  puts "-----------------------------------"
	  puts "#{izth_cable[j][i]} - #{seccion_cable[i]} #{grupo_cable[j]}"
	  u.izth = izth_cable[j][i]
	  u.izth = izth_excepcion[i] if izth_excepcion[i].present?
	  u.Iz   = izth_cable[j][i]
	  u.alma = 'Cu'
	  u.tservicio = temperatura_cable[j]
	  u.grupo = grupo_cable[j]
	  u.seccion = seccion_cable[i]
	  u.tamb = 30
	  u.awg  = awg[i] if awg[i].present?
	end
      end
    end

    largo = seccion_alambre.length - 1

    for j in 0..2
      for i in 0..largo
        Electrico::Conductor.create do |u|
	  puts "--------------------------------------------"
	  puts "#{izth_alambre[j][i]} - #{seccion_alambre[i]} #{grupo_alambre[j]}"
          u.izth = izth_alambre[j][i] if izth_alambre[j][i] > 0
          u.Iz   = izth_alambre[j][i] if izth_alambre[j][i] > 0
          u.alma = 'Cu'
          u.tservicio = temperatura_alambre[j]
          u.grupo = grupo_alambre[j]
          u.seccion = seccion_alambre[i]
          u.tamb = 30
        end
      end
    end

  end
end
