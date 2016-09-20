Rails.application.routes.draw do

  root 'pages#home'

  devise_for 	:users,
  						:path => '',
  						:path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  						:controllers => {:omniauth_callbacks => 'omniauth_callbacks',
  														 :registrations => 'registrations'
  														}

  resources :users, only: [:show]
  resources :properties
  resources :photos

  resources :properties do
    resources :reservations, only: [:create]
  end

  resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index, :create]
    end

  resources :properties do
    resources :reviews, only: [:create, :destroy]
  end

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'

  get '/your_places' => 'reservations#your_places'
  get '/your_reservations' => 'reservations#your_reservations'

  post '/notify' => 'reservations#notify'
  post '/your_places' => 'reservations#your_places'
  
end
