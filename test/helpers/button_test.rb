# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class AmisButtonTest < Minitest::Test
  include AmisUi::Helpers

  def test_builds_view_and_edit_buttons
    assert_equal(
      { type: "button", level: "primary", label: "View", actionType: "link", link: "/clients/${id}" },
      amis_view_button(label: "View", resource: "clients")
    )
    assert_equal(
      { type: "button", level: "primary", label: "Edit", actionType: "link", link: "/clients/7/edit" },
      amis_edit_button(label: "Edit", resource: "clients", id: 7)
    )
  end

  def test_builds_a_member_action_button
    assert_equal(
      { type: "button", level: "primary", label: "Activate", actionType: "ajax", api: "post:/cms/clients/${id}/activate" },
      amis_member_button(label: "Activate", resource: "clients", action: "activate")
    )
  end

  def test_uses_the_configured_cms_path_for_member_actions
    original_cms_path = AmisUi.configuration.cms_path
    AmisUi.configure { |config| config.cms_path = "/admin" }

    assert_equal(
      "post:/admin/clients/${id}/activate",
      amis_member_button(label: "Activate", resource: "clients", action: "activate")[:api]
    )
  ensure
    AmisUi.configure { |config| config.cms_path = original_cms_path }
  end

  def test_normalizes_the_configured_cms_path
    original_cms_path = AmisUi.configuration.cms_path

    ["admin", "/admin/"].each do |path|
      AmisUi.configure { |config| config.cms_path = path }
      assert_equal "/admin", AmisUi.configuration.cms_path
      assert_equal(
        "post:/admin/clients/${id}/activate",
        amis_member_button(label: "Activate", resource: "clients", action: "activate")[:api]
      )
    end
  ensure
    AmisUi.configure { |config| config.cms_path = original_cms_path }
  end
end
