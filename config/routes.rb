RailsAdmin::Engine.routes.draw do
	match '/', to: "develop/manages#index"
	namespace :develop do
		resources :manages, only: %w(index) do
			post :filter, on: :collection
			get :show, on: :member
			put :update, on: :member
		end
	end
end