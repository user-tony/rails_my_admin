require 'jquery-rails'
require 'slim'
require 'rails_admin_content/mysql/adapters/client'
require 'rails_admin_content/paginate'
require 'rails_admin_content/client'
require 'rails_admin_content/helper'

module RailsAdminContent
  class Engine < ::Rails::Engine
    isolate_namespace RailsAdminContent
  end
end