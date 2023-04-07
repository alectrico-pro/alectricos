#!/home/alex/.rvm/rubies/ruby-2.6.5/bin/ruby

 Gestion::Registro.all.each.select{|r| not r.email_secundario.nil?}.map{ |r| '|-----' + r.email + '.-.' + r.email_secundario + '--------|' }.each{ |a| a  }

