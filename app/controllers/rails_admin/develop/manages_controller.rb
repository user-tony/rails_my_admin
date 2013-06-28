class RailsAdmin::Develop::ManagesController < RailsAdmin::Develop::ApplicationController

	before_filter :find_params, except: %w(update create new)

	def index
		@entries = RailsAdmin::Client.query(RailsAdmin::Client.query_str,@page, @per).each  if RailsAdmin::Client.query_str
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
		RailsAdmin::Client.query_str = params[:q]
		redirect_to action: :index
	end

	def update
		RailsAdmin::Client.conn.origin_query("UPDATE #{params[:table]} SET #{params[:field]} = REPLACE(REPLACE(REPLACE('#{params[:value]}', '&','&amp;'), '>', '&gt;'), '<', '&lt;') WHERE id = #{params[:id]}")
		render text: 'success'
	end

	def destroy
		RailsAdmin::Client.delete(params[:id], params[:edit_id]) if params[:edit_id].present?
		render json: params[:edit_id]
	end

	def new;end

	def create
		RailsAdmin::Client.insert(params[:table_name], params[:field])
		flash[:success] = "成功添加#{params[:table_name]}一条数据"
		redirect_to develop_manage_path(params[:table_name])
	rescue Exception => e
		flash[:errors] = e.message
	end

	def find_params
		@page , @per = (params[:page] || 1).to_i, (params[:per] || 100).to_i
	end

end
