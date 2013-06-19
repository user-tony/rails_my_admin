module Mysql2
  class Result

  	# attr_accessor :total_nums

  	def total_nums
  		RailsAdmin::Client.total_nums
  	end

  	def table_name
  		RailsAdmin::Client.table_name
  	end

  end
end