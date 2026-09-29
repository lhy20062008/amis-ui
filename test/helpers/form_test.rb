# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class AmisInputTextTest < Minitest::Test
  include AmisUi::Helpers

  def test_builds_an_input_text_schema_with_defaults
    options = { name: "title", label: "Title" }

    assert_equal(
      {
        name: "title",
        label: "Title",
        type: "input-text",
        trimContents: true,
        clearValueOnHidden: true,
        labelAlign: "left"
      },
      amis_input_text(options)
    )
    assert_equal({ name: "title", label: "Title" }, options)
  end

  def test_preserves_explicit_values
    schema = amis_input_text(
      type: "input-password",
      trimContents: false,
      clearValueOnHidden: false,
      labelAlign: "right"
    )

    assert_equal "input-password", schema[:type]
    assert_equal false, schema[:trimContents]
    assert_equal false, schema[:clearValueOnHidden]
    assert_equal "right", schema[:labelAlign]
  end

  def test_builds_specialized_input_schemas
    assert_equal "input-email", amis_input_email(name: "email")[:type]
    assert_equal "input-password", amis_input_password(name: "password")[:type]
    assert_equal "textarea", amis_textarea(name: "description")[:type]
    assert_equal({ type: "switch", name: "active" }, amis_switch(name: "active"))
  end

  def test_builds_rich_text_schemas_for_each_toolbar_level
    low = amis_rich_text(name: "description", level: :low)
    medium = amis_rich_text(name: "description", level: :medium)
    high = amis_rich_text(name: "description", level: :high)

    assert_equal "input-rich-text", low[:type]
    assert_equal "froala", low[:vendor]
    assert_includes low[:buttons], "fontFamily"
    assert_includes low[:buttons], "fontSize"
    refute_includes low[:buttons], "insertImage"
    assert_includes medium[:buttons], "insertImage"
    assert_includes high[:buttons], "insertVideo"
    assert_includes high[:buttons], "html"
  end

  def test_uses_medium_toolbar_for_a_nil_level_and_rejects_unknown_levels
    assert_equal(
      amis_rich_text(level: :medium)[:buttons],
      amis_rich_text(level: nil)[:buttons]
    )

    error = assert_raises(ArgumentError) { amis_rich_text(level: :unsupported) }
    assert_equal "Unknown rich text level: :unsupported", error.message
  end

  def test_builds_select_schemas
    assert_equal(
      {
        type: "select", name: "client_id", clearable: true,
        clearValueOnHidden: true, clearValueOnSourceChange: true
      },
      amis_select(name: "client_id")
    )
    assert_equal(
      {
        type: "select", name: "admin_role_ids", multiple: true, clearable: true,
        clearValueOnHidden: true, clearValueOnSourceChange: true,
        joinValues: false, extractValue: true
      },
      amis_select(name: "admin_role_ids", multiple: true)
    )
  end

  def test_builds_checkbox_schemas
    assert_equal(
      {
        type: "checkboxes", name: "permissions.AdminUser", checkAll: true,
        joinValues: false, extractValue: true
      },
      amis_checkboxes(name: "permissions.AdminUser")
    )
  end
end
