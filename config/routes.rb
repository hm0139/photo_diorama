Rails.application.routes.draw do
  devise_for :users
  root to: "commissions#index"
  resources :commissions, only:[:index, :new, :create, :show, :destroy] do
    member do
      get "select"
      get "selected_confirmation"
      patch "direct"
      get "unsuccessful"
      get "delete_confirmation"
    end
    collection do
      get "search"
    end
    resources :dealings, only:[:new, :create, :show, :destroy] do
      collection do
        get "make"
      end
    end
    resources :chats, only:[:create]
    resources :evaluations, only:[:new ,:create, :show]
  end

  resources :notifications, only:[:index, :destroy]
  
  resources :creators, only:[:index] do
    collection do
      get "search"
    end
  end
  resources :users, only:[:show, :edit, :update] do
    resources :achievements, only:[:new, :create ,:edit ,:update]
  end
end
