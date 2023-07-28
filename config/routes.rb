Rails.application.routes.draw do
  devise_for :users
  root to: "commissions#index"
  resources :commissions, only:[:index, :new, :create, :show] do
    member do
      patch "direct"
    end
    resources :dealings, only:[:new]
  end

  resources :notifications, only:[:index]
  
  resources :creators, only:[:index]
end
