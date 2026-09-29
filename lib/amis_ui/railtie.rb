# frozen_string_literal: true

module AmisUi
  class Railtie < Rails::Railtie
    initializer "amis_ui.helpers" do
      ActiveSupport.on_load(:action_view) do
        include AmisUi::Helpers
      end
    end
  end
end
