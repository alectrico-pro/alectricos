Rails.application.routes.draw do
  root to: 'autorizados#index'

  resources :autorizados do
    member do
      get :prueba
      get :enviar_presentacion
      get :enviar_mas_info
    end
  end
 
  namespace :electrico do
    resources :desuscripciones, only: [:desuscribeme, :desuscripcion_exitosa, :desuscripcion_fallida ] do
      member do
        get :desuscribeme
        get :desuscripcion_exitosa
        get :desuscripcion_fallida
      end
    end
  end

end
