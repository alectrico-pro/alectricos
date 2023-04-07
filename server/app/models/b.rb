class B < ApplicationRecord

  before_validation do
    interes =                         :no_interesado
    reclutamiento =                   :no_reclutado
    suscripcion    =                  :no_suscrito
    presentacion =                    :no_presentada
    pedido_adicional_de_informacion = :no_entregada_mas_informacion
  end

  scope :orden_clase_desc,   ->          { order ("clase DESC" )}
  scope :clase,              -> (clase)  { where ("clase like '#{clase}'")}
  scope :comuna,             -> (comuna) { where ("comuna like '#{comuna}'")}

  enum interes:        [:interesado, :no_interesado]
  enum reclutamiento:  [:reclutado,  :no_reclutado]
  enum suscripcion:    [:suscrito,   :no_suscrito] 
  enum presentacion:   [:presentada, :no_presentada]
  enum pedido_adicional_de_informacion: [:entregada_mas_informacion, :no_entregada_mas_informacion]

  validates :comuna, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}
#  validates :email, uniqueness: {case_sensitive: false} unless Rails.env.test?

#  VALID_FONO_REGEX = /\A(56|)\d{9}\z/i
 # validates :fono , presence: true, format: { with: VALID_FONO_REGEX}

  def genera_token(column)
    begin
      self[column] = ::SecureRandom.urlsafe_base64
    end while Autorizado.exists?( column => self[column] )
  end

end
