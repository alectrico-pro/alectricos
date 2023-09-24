class Autorizado < ApplicationRecord
 
  comunas = Autorizado.order(:comuna).distinct.pluck(:comuna).map{ |c| begin; c.downcase.to_sym; rescue; end }


  before_validation do
    llamadas_telefonicas =      fono ? :no_ha_sido_telefoneado : :sin_fono
    envios_de_email =           email ? :no_se_le_ha_enviado_email : :sin_email
  end

  scope :orden_clase_desc,   ->          { order ("clase DESC" )}

  comunas.each do |c|
    scope c, -> { where ("comuna like '#{c.to_s.camelize}'")}
  end  

  enum llamadas_telefonicas: [:no_ha_sido_telefoneado, :ha_sido_telefoneado, :su_telefono_responde, :este_numero_no_existe, :suena_pero_no_responde, :sin_fono, :tiene_fono, :no_responde_en_whatsapp, :fono_no_disponible]
  enum envios_de_email: [:no_se_le_ha_enviado_email, :recibe_email, :no_recibe_email, :responde_email, :no_existe_email, :problemas_con_email, :sin_email, :tiene_email ]
  enum clase:          [:a, :b, :c, :d, :x]
  enum suscripcion:    [:suscrito,   :no_suscrito] 
  enum presentacion:   [:presentada, :no_presentada]
  enum pedido_adicional_de_informacion: [:entregada_mas_informacion, :no_entregada_mas_informacion]
  enum interes:        [:interesado, :no_interesado]
  enum reclutamiento:  [:reclutado,  :no_reclutado, :no_activo]
  enum wapp:           [:presentado, :aun_no_responde, :me_bloqueoh]
  validates :comuna, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nombre, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, :allow_nil => true
#  validates :email, uniqueness: {case_sensitive: false} unless Rails.env.test?

#  VALID_FONO_REGEX = /\A(56|)\d{9}\z/i
 # validates :fono , presence: true, format: { with: VALID_FONO_REGEX}

  def self.get_filtros
   
   %w(sin_fono no_ha_sido_telefoneado ha_sido_telefoneado su_telefono_responde este_numero_no_existe suena_pero_no_responde fono_no_disponible sin_email no_se_le_ha_enviado_email recibe_email no_recibe_email responde_email no_existe_email problemas_con_email a b c d x entregada_mas_informacion no_entregada_mas_informacion interesado no_interesado reclutado no_reclutado no_activo suscrito no_suscrito presentada no_presentada presentado aun_no_responde me_bloqueoh) + comunas
  end

  def genera_token(column)
    begin
      self[column] = ::SecureRandom.urlsafe_base64
    end while Autorizado.exists?( column => self[column] )
  end

end
