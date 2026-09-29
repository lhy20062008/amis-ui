# frozen_string_literal: true

module AmisUi
  module Helpers
    module Column
      def amis_id_column(label:, **options)
        { name: "id", label: label, fixed: "left" }.merge(options)
      end

      def amis_text_column(name:, label:, searchable: nil, **options)
        amis_column(name: name, label: label, searchable: searchable, **options)
      end

      def amis_html_column(name:, label:, searchable: nil, **options)
        amis_column(name: name, label: label, type: "html", searchable: searchable, **options)
      end

      def amis_mapping_column(name:, label:, map:, searchable: nil, **options)
        amis_column(name: name, label: label, type: "mapping", map: map, searchable: searchable, **options)
      end

      def amis_boolean_column(name:, label:, map:, **options)
        amis_mapping_column(name: name, label: label, map: map, **options)
      end

      def amis_operation_column(label:, buttons:, **options)
        { type: "operation", label: label, fixed: "right", buttons: buttons }.merge(options)
      end

      private

      def amis_column(name:, label:, searchable: nil, **options)
        schema = { name: name, label: label }.merge(options)
        schema[:searchable] = searchable if searchable
        schema
      end
    end
  end
end
