Routini::Application.routes.draw do
  devise_for :users

  root :to => "tasks#index"
  match '/help' => 'pages#help'

  resources :tasks, :only => [ :create, :destroy, :index, :show, :edit, :update ] do
    resources :microtasks, :only => [ :create, :update, :index ]
    resources :logs, :only => [ :create ]
  end
  resources :situations, :only => [ :create, :destroy, :show, :edit, :update ]

  match "/contexts/:id" => "situations#show"
end
