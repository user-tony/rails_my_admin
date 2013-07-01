class RailsAdmin::Client < Mysql2::Client

	Syntax = /limit\s+\d+,\d+|limit\s+\d+/
	Syntax_table = /from\s+(\w+)/

	cattr_accessor :query_str, :total_nums, :table_name

	def self.conn
		@client ||= new ActiveRecord::Base.connection_config
	end

	alias :origin_query :query

	def self.query(query_sql, page=nil, stint=nil)
		self.table_name = query_sql.downcase.match(Syntax_table)[1] if query_sql.downcase.match(Syntax_table)
		self.total_nums = conn.origin_query(query_sql).size
		query_sql = limit(query_sql, page, stint) if stint && page
		query_sql = query_sql.gsub(/;/, '')
		conn.origin_query(query_sql)
	end

	def self.limit(query_sql, page=1, stint)
		page = page == 1 ? page = 0 : page.to_i*stint.to_i-stint.to_i
		query_sql.downcase.match(Syntax).present? ? query_sql.downcase.gsub(Syntax, "LIMIT #{page},#{stint}") : "#{query_sql} LIMIT #{page},#{stint}"
	end

	def self.get_tables
		@tables ? @tables : @tables = conn.origin_query('SHOW TABLES')
	end

	def self.compose(params)
		"SELECT * FROM #{params[:id]} #{compose_key(params)}"
	end

	def self.compose_key(params)
		where = "WHERE #{params[:field]}"
		case params[:calc]
		when '=', '>', '<'
			"#{where} #{params[:calc]} '#{params[:q]}' "
		when 'IN'
			"#{where} #{params[:calc]} (#{params[:q]}) "
		when '≠'
			"#{where} != '#{params[:q]}'"
		when 'LIKE'
			"#{where} LIKE '%#{params[:q]}%'"
		when 'IS NULL'
			"#{where} IS NULL"
		when '≥'
			"#{where} >= '#{params[:q]}'"
		when '≤'
			"#{where} <= '#{params[:q]}'"
		end
	end


	def self.delete(table_name, ids)
		conn.origin_query("DELETE FROM #{table_name} WHERE id IN (#{ids.join(',')})") if ids.is_a?(Array)
	end

	def self.insert(table_name, field)
		conn.origin_query("INSERT INTO #{table_name} (#{field.keys.join(',')}) VALUES ('#{field.values.join("','")}')")
	end

	def self.update(table_name, id, field)
		conn.origin_query("UPDATE #{table_name} SET #{field.map{|a| "#{a[0]} = '#{a[1]}'" }.join(',')} WHERE id = #{id}")
	end


end