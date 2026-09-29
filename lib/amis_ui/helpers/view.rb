# frozen_string_literal: true

module AmisUi
  module Helpers
    module View
      def amis_static_field(label:, value:, **options)
        { type: "static", label: label, value: value }.merge(options)
      end

      def amis_static_mapping_field(label:, value:, map:, **options)
        { type: "static-mapping", label: label, value: value, map: map }.merge(options)
      end

      def amis_static_html_field(label:, value:, **options)
        { type: "static-html", label: label, value: value }.merge(options)
      end

      def amis_datetime_field(label:, value:, **options)
        amis_static_field(label: label, value: value, **options)
      end

      def amis_panel_header(title:, actions: [])
        {
          type: "flex",
          justify: "space-between",
          alignItems: "center",
          items: [
            { type: "tpl", tpl: title },
            { type: "flex", justify: "flex-end", items: actions }
          ]
        }
      end

      def amis_static_group(title: nil, fields:, column_count: 3, **options)
        {
          body: {
            type: "form",
            wrapWithPanel: false,
            columnCount: column_count,
            body: fields
          }
        }.tap { |schema| schema[:title] = title if title }.merge(options)
      end
    end
  end
end
