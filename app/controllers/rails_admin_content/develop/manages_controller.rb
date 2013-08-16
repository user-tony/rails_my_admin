class RailsAdminContent::Develop::ManagesController < RailsAdminContent::Develop::ApplicationController

	before_filter :find_params, except: %w(update create new)

	def index
		@version = RailsAdminContent::Client.conn.origin_query("SELECT VERSION() as version").each
	end

	def query
		@entries = RailsAdminContent::Client.query(RailsAdminContent::Client.query_str,@page, @per).each  if RailsAdminContent::Client.query_str
	rescue Exception => e
		flash[:errors] = e.message
	end

	def filter
		RailsAdminContent::Client.query_str = params[:q]
		redirect_to action: :query
	end

	def show
		@query_str = "SELECT * FROM #{params[:id]} ORDER BY id DESC"
		@query_str = RailsAdminContent::Client.compose(params) if params[:field].present?
		@fields = RailsAdminContent::Client.desc_table params[:id]
		@entries = RailsAdminContent::Client.query(@query_str,@page, @per)
	rescue Exception => e
		flash[:errors] = e.message
	end

	def new;end

	def edit; end

	def edit_column
		@fields = RailsAdminContent::Client.desc_table params[:id]
	end

	def details
		@details = RailsAdminContent::Client.conn.origin_query("SHOW TABLE STATUS LIKE '#{params[:id]}'").each
	end

	def create
		RailsAdminContent::Client.insert(params[:table_name], params[:field])
		flash[:success] = "成功添加#{params[:table_name]}一条数据。"
	rescue Exception => e
		flash[:errors] = e.message
	ensure
		redirect_to develop_manage_path(params[:table_name])
	end

	def update
		RailsAdminContent::Client.update(params[:table_name], params[:id], params[:field])
		flash[:success] = "更新#{params[:id]}内容成功。"
	rescue Exception => e
		flash[:errors] = e.message
	ensure
		redirect_to develop_manage_path(params[:table_name])
	end


	def update_field
		RailsAdminContent::Client.conn.origin_query("UPDATE #{params[:table]} SET #{params[:field]} = REPLACE(REPLACE(REPLACE('#{params[:value]}', '&','&amp;'), '>', '&gt;'), '<', '&lt;') WHERE id = #{params[:id]}")
		render text: 'success'
	end

	def destroy
		RailsAdminContent::Client.delete(params[:id], params[:edit_id]) if params[:edit_id].present?
		render json: params[:edit_id]
	end

	private

	def find_params
		@page, @per = (params[:page] || 1).to_i, (params[:per] || 100).to_i
	end

end