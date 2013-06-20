
RailsAdmin::Engine.routes.draw do
	namespace :develop do
		resources :manages, only: %w(index) do
			post :filter, on: :collection
			get :show, on: :member
			put :update, on: :member
		end
	end
end
