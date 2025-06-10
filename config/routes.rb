Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post   'shorten',         to: 'short_urls#create'
      post   'shorten/batch',   to: 'short_urls#batch_create'
      get    'analytics',       to: 'short_urls#analytics'
      post   'deactivate/:code', to: 'short_urls#deactivate'
    end
  end

  get '/:code', to: 'redirect#show', as: :short
end
