Rails.application.routes.draw do
  devise_for :users
  root to: "commissions#index"
  resources :commissions, only:[:index, :new, :create, :show] do
    member do
      patch "direct"
      get "unsuccessful"
    end
    resources :dealings, only:[:new, :create, :show]
  end

  resources :notifications, only:[:index, :destroy]
  
  resources :creators, only:[:index]
  resources :users, only:[:show]
  resources :achievement, only:[:new]
end
