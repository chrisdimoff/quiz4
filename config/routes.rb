Rails.application.routes.draw do
  root 'home#index'

  resources :auctions do
    post '/publish', to: 'states#publish', as: :publish
    post '/unpublish', to: 'states#unpublish', as: :unpublish
    post '/reserve', to: 'states#reserve', as: :reserve
    post '/unreserve', to: 'states#unreserve', as: :unreserve
    post '/win', to: 'states#win', as: :win
    post '/cancel', to: 'states#cancel', as: :cancel
    resources :bids
  end

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
