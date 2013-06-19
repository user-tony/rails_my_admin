module RailsAdmin
	module Mysql
		module Adapters
			class Client

				def initialize
					@client = client = Mysql2::Client.new ActiveRecord::Base.connection_config
				end

				def query(sql)
					@client.query(sql).each
				end

			end
		end

	end
end