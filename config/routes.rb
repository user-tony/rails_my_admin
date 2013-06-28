RailsAdmin::Engine.routes.draw do
	match '/', to: "develop/manages#index"
	namespace :develop do
		resources :manages do
			post :filter, on: :collection
		end
	end
end