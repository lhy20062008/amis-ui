# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class AmisColumnTest < Minitest::Test
  include AmisUi::Helpers

  def test_builds_standard_columns
    assert_equal(
      { name: "id", label: "ID", fixed: "left" },
      amis_id_column(label: "ID")
    )
    assert_equal(
      { name: "name", label: "Name", searchable: { name: "name_cont" } },
      amis_text_column(name: "name", label: "Name", searchable: { name: "name_cont" })
    )
    assert_equal(
      { name: "permissions_text", label: "Permissions", type: "html" },
      amis_html_column(name: "permissions_text", label: "Permissions")
    )
  end

  def test_builds_mapping_and_operation_columns
    assert_equal(
      { name: "active", label: "Active", type: "mapping", map: { "true" => "YES" } },
      amis_boolean_column(name: "active", label: "Active", map: { "true" => "YES" })
    )
    assert_equal(
      { type: "operation", label: "Actions", fixed: "right", buttons: [ { label: "Edit" } ] },
      amis_operation_column(label: "Actions", buttons: [ { label: "Edit" } ])
    )
  end

  def test_builds_a_switch_column
    assert_equal(
      {
        name: "active", label: "Active", type: "switch", mode: "horizontal", disabled: false,
        onEvent: { change: { actions: [ { actionType: "ajax", api: "post:/cms/clients/${id}/active" } ] } }
      },
      amis_switch_column(name: "active", label: "Active", api: "post:/cms/clients/${id}/active")
    )
  end
end
