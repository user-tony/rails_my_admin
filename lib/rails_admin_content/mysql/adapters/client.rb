module RailsAdminContent
  module Mysql
    module Adapters
      class Client
        def initialize
          @client ||= Mysql2::Client.new ActiveRecord::Base.connection_config
        end

        def query(sql)
          @client.query(sql).each
        rescue
          []
        end
      end

    end
  end
end
