Rails.application.routes.draw do
	namespace :api do
		resources :user
		get "typeahead/:input", to: 'user#typeahead'
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
