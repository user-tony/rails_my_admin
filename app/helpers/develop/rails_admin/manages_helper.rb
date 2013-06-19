module Develop::RailsAdmin::ManagesHelper

	 #分页
  def paginate(scope, options = {})
    paginate = RailsAdmin::Paginate.new(scope, options.update(per_page: options[:stint]))
    paginate.to_s
  end

  	def format(value, limit=10)
  		value = value.is_a?(String) && value.size > limit ? value.truncate(limit) : value
  		value = value.is_a?(Time) ? value.to_s(:db) : value
  		value ||= "null"
  	end


  	def gofs(article = nil, prompt = nil)
  		grouped_options = ArticleCategory.select_list
  		selected_key = nil
  		selected_key = article.article_categories.pluck(:id) if article && article.article_categories.present?
  		body = ''
  		body << content_tag(:option, prompt, { :value => "" }, true) if prompt
  		grouped_options = grouped_options.sort if grouped_options.is_a?(Hash)
  		grouped_options.each do |group|
  			body << content_tag(:optgroup, options_for_select(group[1], selected_key), :label => group[0])
  		end
  		body.html_safe
  	end

  	def menu_value(value, icon)
  		raw <<-HTML
  			<i class="#{icon}"></i><span class="hidden-tablet">#{value}</span>
  		HTML
  	end

  	def link_to_menu(*args, &block)
      name         = menu_value(args[0], args[1])
      options      = args[2] || {}
      html_options = args[3]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)

      href = html_options['href']
      tag_options = tag_options(html_options)
      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      "<a #{href_attr}#{tag_options}>#{ERB::Util.html_escape(name || url)}</a>".html_safe
    end


    def menu_li_link_to(table_name,&block)
    	"<li class=\"#{'active' if table_name }\">#{capture(&block)}</li>".html_safe
    end
end
