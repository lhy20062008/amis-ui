# frozen_string_literal: true

module AmisUi
  module Helpers
    module Button
      def amis_view_button(label:, resource:, id: "${id}", **options)
        amis_member_link_button(label: label, resource: resource, id: id, **options)
      end

      def amis_edit_button(label:, resource:, id: "${id}", **options)
        amis_member_link_button(label: label, resource: resource, id: id, path: "/#{resource}/#{id}/edit", **options)
      end

      def amis_member_button(label:, resource:, action:, id: "${id}", method: "post", **options)
        cms_path = AmisUi.configuration.cms_path == "/" ? "" : AmisUi.configuration.cms_path

        options.merge(
          type: options.fetch(:type, "button"),
          level: options.fetch(:level, "primary"),
          label: label,
          actionType: options.fetch(:actionType, "ajax"),
          api: options.fetch(:api, "#{method}:#{cms_path}/#{resource}/#{id}/#{action}")
        )
      end

      private

      def amis_member_link_button(label:, resource:, id:, path: nil, **options)
        options.merge(
          type: options.fetch(:type, "button"),
          level: options.fetch(:level, "primary"),
          label: label,
          actionType: options.fetch(:actionType, "link"),
          link: options.fetch(:link, path || "/#{resource}/#{id}")
        )
      end
    end
  end
end
