# frozen_string_literal: true

module AmisUi
  module Helpers
    module Filter
      def amis_text_filter(name:, placeholder:, **options)
        {
          name: name,
          type: "input-text",
          label: false,
          placeholder: placeholder
        }.merge(options)
      end

      def amis_select_filter(name:, placeholder:, options:, multiple: false, **attributes)
        schema = {
          name: name,
          type: "select",
          label: false,
          clearable: true,
          placeholder: placeholder,
          options: options
        }.merge(attributes)

        return schema unless multiple

        schema.merge(
          multiple: true,
          joinValues: attributes.fetch(:joinValues, false),
          extractValue: attributes.fetch(:extractValue, true)
        )
      end
    end
  end
end
