## Rails Admin

## Getting started   

```ruby
gem 'rails_admin'

```

Run bundle install command


add routes.rb

```ruby

mount RailsAdmin::Engine => "/rails_admin"

or

namespace :admin do
	mount RailsAdmin::Engine => "/rails_admin"
end

```


Connect rails_admin configuration file

```ruby

http://localhost:3000/rails_admn/

or

http://localhost:3000/admin/rails_admn/

```