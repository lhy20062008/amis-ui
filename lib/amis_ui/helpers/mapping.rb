# frozen_string_literal: true

module AmisUi
  module Helpers
    module Mapping
      def amis_boolean_mapping(true_label:, false_label:)
        { "true" => true_label, "false" => false_label }
      end
    end
  end
end
