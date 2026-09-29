# frozen_string_literal: true

module AmisUi
  module Helpers
    # Form schema helpers for AMis.
    module Form
      RICH_TEXT_TOOLBARS = {
        low: %w[
          undo redo bold italic underline strikeThrough
          fontFamily fontSize textColor backgroundColor
          align formatOL formatUL removeFormat
        ],
        medium: %w[
          undo redo paragraphFormat bold italic underline strikeThrough
          fontFamily fontSize textColor backgroundColor
          align formatOL formatUL outdent indent quote
          insertLink insertImage insertTable removeFormat
        ],
        high: %w[
          undo redo paragraphFormat bold italic underline strikeThrough
          fontFamily fontSize textColor backgroundColor
          align formatOL formatUL outdent indent quote
          insertLink insertImage insertVideo insertFile insertTable
          specialCharacters emoticons html fullscreen print selectAll removeFormat
        ]
      }.freeze

      # Builds an AMis input-text schema.
      #
      # Caller-supplied values take precedence over the standard defaults.
      # The input hash is not mutated.
      def amis_input_text(options = {})
        options.merge(
          type: options.fetch(:type, "input-text"),
          trimContents: options.fetch(:trimContents, true),
          clearValueOnHidden: options.fetch(:clearValueOnHidden, true),
          labelAlign: options.fetch(:labelAlign, "left")
        )
      end

      def amis_input_email(options = {})
        amis_input_text(options.merge(type: "input-email"))
      end

      def amis_input_password(options = {})
        amis_input_text(options.merge(type: "input-password"))
      end

      def amis_input_file(options = {})
        options.merge(
          type: 'input-file',
          autoUpload: options.fetch(:autoUpload, false),
          useChunk: options.fetch(:useChunk, false),
          clearValueOnHidden: options.fetch(:clearValueOnHidden, true),
          labelAlign: options.fetch(:labelAlign, 'left')
        )
      end

      def amis_textarea(options = {})
        amis_input_text(options.merge(type: "textarea"))
      end

      def amis_rich_text(options = {})
        level = (options[:level] || :medium).to_sym
        buttons = RICH_TEXT_TOOLBARS.fetch(level) do
          raise ArgumentError, "Unknown rich text level: #{level.inspect}"
        end

        options.reject { |key, _| key == :level }.merge(
          type: "input-rich-text",
          vendor: options.fetch(:vendor, "froala"),
          buttons: options.fetch(:buttons, buttons),
          clearValueOnHidden: options.fetch(:clearValueOnHidden, true),
          labelAlign: options.fetch(:labelAlign, "left")
        )
      end

      def amis_switch(options = {})
        options.merge(type: "switch")
      end

      def amis_select(options = {})
        schema = options.merge(
          type: "select",
          clearable: options.fetch(:clearable, true),
          clearValueOnHidden: options.fetch(:clearValueOnHidden, true),
          clearValueOnSourceChange: options.fetch(:clearValueOnSourceChange, true)
        )

        return schema unless schema[:multiple]

        schema.merge(
          joinValues: options.fetch(:joinValues, false),
          extractValue: options.fetch(:extractValue, true)
        )
      end

      def amis_checkboxes(options = {})
        options.merge(
          type: "checkboxes",
          checkAll: options.fetch(:checkAll, true),
          joinValues: options.fetch(:joinValues, false),
          extractValue: options.fetch(:extractValue, true)
        )
      end
    end
  end
end
