RailsAdmin::Application.routes.draw do


  namespace :develop do
    namespace :rails_admin do
      resources :manages, only: %w(index) do
        post :filter, on: :collection
        get :show, on: :member
        put :update, on: :member
      end
    end
  end

  root :to => 'develop/rails_admin/manages#index'

end
