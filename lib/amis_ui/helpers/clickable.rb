# frozen_string_literal: true

require "erb"
require "active_support/core_ext/string/inflections"

module AmisUi
  module Helpers
    # AMIS schemas for linking to one or more related CMS resources.
    module Clickable
      def amis_custom_clickable(object, options = {})
        return unless object

        {
          resource: options[:resource] || object.class.name.tableize,
          label: options[:label] || amis_clickable_label(object),
          id: object.id
        }
      end

      def amis_custom_clickables(objects, options = {})
        return unless objects

        objects.map { |object| amis_custom_clickable(object, options) }
      end

      def amis_clickable_column(options = {})
        schema = options.slice(:name, :label, :searchable)
        schema[:type] = "button"
        schema[:body] = {
          type: "button",
          level: "link",
          actionType: "link",
          label: "${#{options[:name]}.label}",
          link: "/${#{options[:name]}.resource}/${#{options[:name]}.id}"
        }
        schema[:body][:className] = options[:className] if options[:className] && !options[:className].to_s.empty?
        schema
      end

      def amis_clickables_column(options = {})
        {
          name: options[:name],
          type: "each",
          label: options[:label],
          placeholder: options[:placeholder] || "-",
          items: {
            type: "button",
            actionType: "link",
            level: "link",
            label: "${item.label}",
            link: "/${item.resource}/${item.id}"
          },
          searchable: options[:searchable]
        }
      end

      def amis_static_link(options = {})
        return { type: "static", label: options[:label] } if options[:link].nil?

        schema = options.dup
        schema[:type] ||= "static-link"
        schema[:body] = options.dig(:link, :label)
        schema[:href] = "/#{options.dig(:link, :resource)}/#{options.dig(:link, :id)}"
        schema.delete(:link)
        schema
      end

      def amis_static_links(options = {})
        html = options.fetch(:links).map do |link|
          href = "/#{link[:resource]}/#{link[:id]}"
          %(<a href="#{ERB::Util.html_escape(href)}">#{ERB::Util.html_escape(link[:label])}</a>)
        end.join("; ")

        { type: "static-html", label: options[:label], value: html }.merge(options.reject { |key, _| %i[label links].include?(key) })
      end

      private

      def amis_clickable_label(object)
        display_name = object.public_send(:display_name) if object.respond_to?(:display_name)
        display_name.nil? || display_name == "" ? object.id : display_name
      end
    end
  end
end
