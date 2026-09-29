# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui"
require "action_view"

class AmisUiTestApplication < Rails::Application
  config.eager_load = false
  config.secret_key_base = "amis-ui-test-secret-key-base"
end

class AmisUiRailtieTest < Minitest::Test
  def test_includes_helpers_in_action_view_after_rails_initializes
    AmisUiTestApplication.initialize!

    assert_equal "input-text", ActionView::Base.empty.amis_input_text(name: "title")[:type]
  end
end
