module ActionView
	module Helpers
		module DateHelper
			def custom_paginate(scope, options = {})
				paginate = RailsAdmin::Paginate.new(scope, options.update(per_page: options[:stint]))
				paginate.to_s
			end

			def format(value, limit=10)
				value = value.is_a?(String) && value.size > limit ? value.truncate(limit) : value
				value = value.is_a?(Time) ? value.to_s(:db) : value
				value ||= "null"
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


			def menu_li_link_to(mark ,&block)
				"<li class=\"#{'active' if mark }\">#{capture(&block)}</li>".html_safe
			end
		end
	end
end