## Rails Admin Content

## Getting started   

```ruby
gem 'rails-admin-content'

```

Run bundle install command


add routes.rb

```ruby

mount RailsAdminContent::Engine => "/rails_admin_content"

or

namespace :admin do
	mount RailsAdminContent::Engine => "/rails_admin_content"
end

```


Connect rails_admin_content configuration file

```ruby

http://localhost:3000/rails_admn_content/

or

http://localhost:3000/admin/rails_admn_content/

```