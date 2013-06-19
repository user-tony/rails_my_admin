class RailsAdmin::Client < Mysql2::Client

	Syntax = /limit\s+\d+,\d+|limit\s+\d+/
	Syntax_table = /from\s+(\w+)/

	cattr_accessor :query_str, :total_nums, :table_name

	def self.conn
		@client ||= new ActiveRecord::Base.connection_config
	end

	alias :origin_query :query

	def self.query(query_sql, page=nil, stint=nil)
		#TODO logging
		self.table_name = query_sql.downcase.match(Syntax_table)[1] if query_sql.downcase.match(Syntax_table)
		self.total_nums = conn.origin_query(query_sql).size
		query_sql = limit(query_sql, page, stint) if stint && page
		query_sql = query_sql.gsub(/;/, '')
		# p "*" * 20
		# p query_sql
		# p "*" * 20
		conn.origin_query(query_sql)
	end

	def self.limit(query_sql, page=1, stint)
		page = page == 1 ? page = 0 : page.to_i*stint.to_i
		query_sql.downcase.match(Syntax).present? ? query_sql.downcase.gsub(Syntax, "limit #{page},#{stint}") : "#{query_sql} LIMIT #{page},#{stint}"
	end

	def self.get_databases
		@databases ? @databases : @databases = conn.origin_query("SHOW DATABASES").each.map{|d| [d.values.first,d.values.first] }
	end

	def self.get_tables
		@tables ? @tables : @tables = conn.origin_query('SHOW TABLES')
	end


end