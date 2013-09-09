RailsAdminContent::Engine.routes.draw do
  match '/', to: "develop/manages#index"
  namespace :develop do
    resources :manages do
      post :filter, on: :collection
      get :query, on: :collection
      put :update_field, on: :member
      get :edit_column, on: :member
      get :details, on: :member
      put :modify_default_value, on: :collection
    end
  end
end