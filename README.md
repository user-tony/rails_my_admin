
### Installation
	
1.Add Gemfile file code is as follows

		gem 'rails_admin'
	
2.Add a script file 

	//= require rails_admin
	
3.Add Style File

	*= require rails_admin
4.Add route
	
	mount RailsAdmin::Engine => "/rails_admin"

	or

	namespace :admin do
		mount RailsAdmin::Engine => "/rails_admin"
	end

### Connect rails_admin configuration file
		After running Access Address
	
		http://localhost:3000/admin/rails_admn/develop/manages

