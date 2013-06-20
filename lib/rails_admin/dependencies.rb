require 'active_support/dependencies'
module ActiveSupport
  module Dependencies
    module Extend

      def self.included(base)
        base.class_eval do
          alias_method_chain :require_or_load, :rails_admin
        end
      end

      def require_or_load_with_rails_admin(file_name, const_path = nil)
        require_or_load_without_rails_admin(file_name, const_path)
        if file_name.starts_with?(Rails.root.to_s + '/app')
          relative_name = file_name.gsub(Rails.root.to_s, '')
          engine_file = File.join(::RailsAdmin::Engine.root, relative_name)
          require_or_load_without_rails_admin(engine_file, const_path) if File.file?(engine_file)
        end
      end
    end
    include Extend
  end
end