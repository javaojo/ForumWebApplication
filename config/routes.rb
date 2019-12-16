Rails.application.routes.draw do
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  resources :channels
  resources :discussions do
    resource :replies
  end
  #Makes the discussion page the root page which will be the home page for the application
  root 'discussions#index'
  devise_for :users, controllers: {registrations: 'registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
