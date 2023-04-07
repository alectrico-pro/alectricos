FactoryBot.define do 
  factory :autorizado, :class => Autorizado do 
     nombre           {'nombre' } 
     rut              {'11.111.111-1'} 
     clase            {'d'}
     comuna           {'Providencia' } 
     direccion        {'registro.direccion'} 
     fono             {'987654321'} 
     email            {'email@alectrico.cl'} 
     suscripcion      { :suscrito } 
     desuscripcion_token { 'lll' } 
  end 

end 
