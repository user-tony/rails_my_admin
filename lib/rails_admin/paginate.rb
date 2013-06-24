module RailsAdmin
	class Paginate
		
		def initialize(scope, options = {})
			@scope, @options = scope, options
		end

		def to_s
			return "" unless @scope
			current_page, total_pages = @options[:spage].to_i, RailsAdmin::Client.total_nums / @options[:stint]
			return "" if total_pages <= 1
			param_name = @options["param_name"] || "page"
			url = @options["url"] || ""
			helpers.content_tag :div, :class => "pagination" do
				helpers.content_tag :ul do
					result = ''
					result += helpers.content_tag(:li, class: 'previous'){helpers.link_to("‹ 上一页","#{url}?#{param_name}=#{current_page-1}")} if current_page.to_i > 1
					
					if total_pages > 8
						1.upto(3) { |i| result << page_link(i, current_page) }
						if current_page > 1 and current_page < total_pages
							result << helpers.content_tag(:li, helpers.link_to("...",'#'), class: 'disabled') if current_page > 5
							min = current_page > 4 ? current_page-1 : 4
							max = current_page < total_pages-4 ? current_page+2 : total_pages-2
							(min..max-1).each { |i| result << page_link(i, current_page) } if max >= min+1
							result << helpers.content_tag(:li, helpers.link_to("...", "#"), class: 'disabled') if current_page < total_pages-4
						else
							result << helpers.content_tag(:li, helpers.link_to("...",'#'), class: 'disabled')
						end
						(total_pages-2..total_pages).each{ |i| result << page_link(i, current_page) }
					else
						(1..total_pages).each{ |i| result << page_link(i, current_page) }
					end
					result += helpers.content_tag :li, :class => "next" do
											helpers.link_to("下一页 ›", "#{url}?#{param_name}=#{current_page+1}")
										end if current_page < total_pages
					result += helpers.content_tag :li, class: 'disabled total_pages' do
											helpers.link_to "共#{RailsAdmin::Client.total_nums}条数据", "#"
										end
					result.html_safe
				end
			end
		 
		end

		private
		def page_link(page, current_page)
			param_name = @options["param_name"] || "page"
			url = @options["url"] || ""
			current_page == page ? helpers.content_tag(:li, page, :class => "active"){helpers.link_to page, '#'} : helpers.content_tag(:li, helpers.link_to("#{page}", "#{url}?#{param_name}=#{page}"))
		end

		def helpers
			ActionController::Base.helpers
		end   
		
	end
end