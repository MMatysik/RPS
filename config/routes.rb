Rails.application.routes.draw do
  root to: 'games#new'
  resource :game, only: [:show, :create, :new]
end
