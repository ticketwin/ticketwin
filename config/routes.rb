Rails.application.routes.draw do
  apipie
  root to: redirect('/api')

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: %i[show create update]
      resources :sessions, only: %i[create destroy]
      resources :organizations, only: %i[create show update] do
        resources :events, only: %i[index create show update]
      end
    end
  end

  match '*path', to: 'application#routing_error', via: %i[get post put patch delete]
end
