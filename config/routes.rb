Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  scope '/api' do
    resources :documents do
      member do
        get :html
      end
    end
  end

  # Catch-all. Send all not-found paths to VueJS to deal with
  get '*path', to: 'home#index'
end
