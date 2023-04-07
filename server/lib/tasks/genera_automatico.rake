namespace :genera do
  desc "Crea la tabla de Automáticos"
  task automatico: :environment do

    Electrico::Automatico.delete_all
    pdc_6 =6
    pdc_10=10
    pdc_16=16
    pdc_20=20
    pdc_25=25
    pdc_36=36
    pdc_50=50
    pdc_70=70
    pdc_100=100
    pdc_100_50=100

    ['B','C','D'].each do |curva|
      [1,2,3,4, 6,10,16,20,25,32,40,50,63].each do |calibre|
	Electrico::Automatico.create(:poder_corte => pdc_6, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['B','C'].each do |curva|
      [1,2,3,4, 6,10,16,20,25,32,40,50,63].each do |calibre|
	Electrico::Automatico.create(:poder_corte => pdc_10, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['C','D'].each do |curva|
      [63,80,100,125].each do |calibre|
	 Electrico::Automatico.create(:poder_corte => pdc_10, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['C'].each do |curva|
      [2,3,4,6,10,20,25,32].each do |calibre|
	Electrico::Automatico.create(:poder_corte => pdc_25, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['D'].each do |curva|
      [2,3,4,6,10,20].each do |calibre|
	Electrico::Automatico.create(:poder_corte => pdc_25, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
     end
    end

    ['C'].each do |curva|
      [32,40,50,63,80,100,125].each do |calibre|
	Electrico::Automatico.create(:poder_corte => pdc_25, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['D'].each do |curva|
      [20,25,32,40,50,63,80,100,125].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc_25, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['D'].each do |curva|
      [20,25,32,40,50,63,80,100,125].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc_25, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    ['C'].each do |curva|
      [6,10,16,20,25,32,40,50,63,80].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc_36, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end


    ['C','D'].each do |curva|
      [6,10,16,20,25,32,40,50,63].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc_50, :corriente_nominal => calibre,:curva => curva, :es_mcb => true, :es_monofasico => true)
      end
    end

    curva = ""
    [pdc_16,pdc_25,pdc_36,pdc_50].each do |pdc|
      [16,20,25,32,40,50,63,80,100,125,160].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_20].each do |pdc|
      [15,20,25,30,40,50,63,80,100,125].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_36].each do |pdc|
      [15,20,25,30,40,50,60,63,75,80,100,125].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_36].each do |pdc|
      [15,20,25,30,40,50,60,63,75,80,100,125].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_25,pdc_36].each do |pdc|
      [125, 160, 200, 225, 250].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
       end
    end

    [pdc_36,pdc_50].each do |pdc|
      [320, 400, 500, 630].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
       end
    end

    [40,50,63,80,100,125,160,200,250].each do |calibre|
      [pdc_25,pdc_36,pdc_50,pdc_70].each do |pdc|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_36,pdc_70,pdc_100_50].each do |pdc|
      [320,630].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_36,pdc_70,pdc_100_50].each do |pdc|
      [250,320,630].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
       end
    end

    [pdc_36,pdc_70,pdc_100].each do |pdc|
      [800,1250].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end


    [pdc_50,pdc_70].each do |pdc|
      [800,1250,1600].each do |calibre|
        Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_16,pdc_25,pdc_36,pdc_50].each do |pdc|
       [16,25,40,63,80,100,125,160].each do |calibre|
          Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
       end
    end

    [pdc_16,pdc_25,pdc_36,pdc_50,pdc_70].each do |pdc|
      [100,160,200,250].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end

    [pdc_25,pdc_36,pdc_50,pdc_70].each do |pdc|
      [40,100,160,250].each do |calibre|
         Electrico::Automatico.create(:poder_corte => pdc, :corriente_nominal => calibre,:curva => curva, :es_mcb => false, :es_trifasico => true)
      end
    end
  end
end
