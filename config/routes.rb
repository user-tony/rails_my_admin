
RailsAdmin::Engine.routes.draw do
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
	end
end

Rails.application.routes.draw do
	mount RailsAdmin::Engine => ""
end