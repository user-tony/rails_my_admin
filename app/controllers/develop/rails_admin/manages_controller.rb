class Develop::RailsAdmin::ManagesController < Develop::RailsAdmin::ApplicationController

	before_filter :find_params, except: %w(update)

	def index;end

	def show;end

	def filter
		redirect_to action: :index
	end

	def update
		RailsAdmin::Client.conn.origin_query("UPDATE #{params[:table]} SET #{params[:field]} = REPLACE(REPLACE(REPLACE('#{params[:value]}', '&','&amp;'), '>', '&gt;'), '<', '&lt;') WHERE id = #{params[:id]}")
		render text: 'success'
	end

	def find_params
		@page , @per = (params[:page] || 1).to_i, (params[:per] || 100).to_i
		@q = params[:id].present? ? "SELECT * FROM #{params[:id]}" : params[:q] || RailsAdmin::Client.query_str
		if @q.present?
			@entries = RailsAdmin::Client.query(@q,@page, @per) 
			RailsAdmin::Client.query_str = @q
			@total_nums =  @entries.size/@per+2
		end
	rescue Exception => e
		RailsAdmin::Client.query_str = @q
		flash[:errors] = e.message
	end

end
