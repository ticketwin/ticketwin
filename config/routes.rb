Rails.application.routes.draw do
  apipie
  root to: redirect('/api')

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update]
      resources :sessions, only: [:create, :destroy]
    end
  end

  match '*path', to: 'application#routing_error', via: %i[get post put patch delete]
end
