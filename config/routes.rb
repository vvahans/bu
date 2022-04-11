Rails.application.routes.draw do
  devise_for :admins, defaults: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope :api, module: 'api' do
    scope :v1, module: 'v1' do
      resource :import, only: [:create]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
