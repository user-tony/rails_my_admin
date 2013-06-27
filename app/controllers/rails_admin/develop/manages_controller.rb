class RailsAdmin::Develop::ManagesController < RailsAdmin::Develop::ApplicationController

	before_filter :find_params, except: %w(update)

	def index
		@q = params[:q] || RailsAdmin::Client.query_str
		if @q.present?
			@entries = RailsAdmin::Client.query(@q,@page, @per) 
			RailsAdmin::Client.query_str = @q
			@total_nums =  @entries.size/@per+2
		end
	rescue Exception => e
		RailsAdmin::Client.query_str = @q
		flash[:errors] = e.message
	end

	def show 
		@query_str = "SELECT * FROM #{params[:id]}"
		@query_str = RailsAdmin::Client.compose(params) if params[:q].present? && params[:field].present?
		@fields = RailsAdmin::Client.conn.origin_query("desc #{params[:id]}").each
		@entries = RailsAdmin::Client.query(@query_str,@page, @per)
	rescue Exception => e
		flash[:errors] = e.message
	end

	def filter
		redirect_to action: :index
	end

	def update
		RailsAdmin::Client.conn.origin_query("UPDATE #{params[:table]} SET #{params[:field]} = REPLACE(REPLACE(REPLACE('#{params[:value]}', '&','&amp;'), '>', '&gt;'), '<', '&lt;') WHERE id = #{params[:id]}")
		render text: 'success'
	end

	def destroy
		RailsAdmin::Client.delete(params[:id], params[:edit_id]) if params[:edit_id].present? 
		# flash[:success] = "删除成功"
		# redirect_to develop_manage_path(params[:id])
		render json: params[:edit_id]
	end

	def find_params
		@page , @per = (params[:page] || 1).to_i, (params[:per] || 100).to_i
	end

end
