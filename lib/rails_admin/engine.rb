require 'jquery-rails'
require 'slim'
require 'rails_admin/mysql/adapters/client'
require 'rails_admin/paginate'
require 'rails_admin/client'
require 'rails_admin/helper'
require 'mysql2/result'

module RailsAdmin
	class Engine < ::Rails::Engine
		isolate_namespace RailsAdmin
	end
end