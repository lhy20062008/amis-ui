# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class AmisFilterTest < Minitest::Test
  include AmisUi::Helpers

  def test_builds_a_text_filter
    assert_equal(
      { name: "email_cont", type: "input-text", label: false, placeholder: "Email" },
      amis_text_filter(name: "email_cont", placeholder: "Email")
    )
  end

  def test_allows_filter_options_to_be_overridden
    assert_equal(
      { name: "name_cont", type: "input-text", label: "Name", placeholder: "Name" },
      amis_text_filter(name: "name_cont", placeholder: "Name", label: "Name")
    )
  end

  def test_builds_select_filters
    assert_equal(
      {
        name: "client_id_eq", type: "select", label: false, clearable: true,
        placeholder: "Client", options: [ { label: "Acme", value: 1 } ]
      },
      amis_select_filter(name: "client_id_eq", placeholder: "Client", options: [ { label: "Acme", value: 1 } ])
    )
    assert_equal(
      {
        name: "admin_role_ids", type: "select", label: false, clearable: true,
        placeholder: "Roles", options: [], multiple: true, joinValues: false, extractValue: true
      },
      amis_select_filter(name: "admin_role_ids", placeholder: "Roles", options: [], multiple: true)
    )
  end
end
