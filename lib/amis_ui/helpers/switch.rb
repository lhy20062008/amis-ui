# frozen_string_literal: true

module AmisUi
  module Helpers
    module Switch
      def amis_switch_column(name:, label:, api:, disabled: false)
        {
          name: name,
          label: label,
          type: "switch",
          mode: "horizontal",
          disabled: disabled,
          onEvent: {
            change: {
              actions: [
                { actionType: "ajax", api: api }
              ]
            }
          }
        }
      end
    end
  end
end
