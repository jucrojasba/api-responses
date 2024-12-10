Rails.application.routes.draw do
  # Rutas para la salud de la aplicación
  get "up" => "rails/health#show", as: :rails_health_check

  # Rutas para el servicio PWA (opcional)
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Rutas para los formularios
  resources :surveys, only: [:index, :new, :create]  # Puedes agregar las rutas para "show", "edit", etc., si las necesitas

  # Define la ruta raíz (la página de inicio)
  root to: 'surveys#index'  # Establece "Todos los formularios" como la página de inicio

end
