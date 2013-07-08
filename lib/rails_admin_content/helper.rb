module ActionView
  module Helpers
    module DateHelper
      def custom_paginate(scope, options = {})
        paginate = RailsAdminContent::Paginate.new(scope, options.update(per_page: options[:stint]))
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

      def edited(key, value, str='')
        str << 'editable' unless key == 'id'
        str << ' edit_datepicker' if value.is_a?(Time)
        str
      end

      def options_for_select_column_data(table, selected=nil)
        options_for_select RailsAdminContent::Client.desc_table(table).map{|a| [ a["Field"],a["Field"], column_type: a["Type"].gsub(/\(.*?\)/,'') ]}, selected
      end

      def content_field(column, value=nil)
        type = column["Type"].gsub(/\(.*?\)/,'')
        column["Default"] = value if value
        column["Field"] = "field[#{column["Field"]}]"
        case type
        when 'text'
          text_area_tag column["Field"], column["Default"], :size => "25x6", 'data-field' => column["Field"], class: "#{type} span10"
        when 'varchar'
          text_field_tag column["Field"], column["Default"], 'data-field' => column["Field"],  class: "#{type} span10"
        when 'int'
          number_field_tag column["Field"], column["Default"], 'data-field' => column["Field"],  class: "#{type} span10"
        when 'tinyint'
          select_tag column["Field"], options_for_select([['Yes',1],['No',0]], column["Default"]), 'data-field' => column["Field"],  class: "#{type} span10"
        else
          text_field_tag column["Field"], column["Default"],  'data-field' => column["Field"], class: "#{type} span10"
        end
      end

    end
  end
end