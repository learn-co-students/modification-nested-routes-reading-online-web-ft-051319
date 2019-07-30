Rails.application.routes.draw do
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end

  resources :posts, only: [:show, :index, :new, :create, :edit]
end
