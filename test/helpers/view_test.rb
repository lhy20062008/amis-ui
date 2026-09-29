# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class AmisViewTest < Minitest::Test
  include AmisUi::Helpers

  def test_builds_static_fields
    assert_equal(
      { type: "static", label: "Name", value: "Acme" },
      amis_static_field(label: "Name", value: "Acme")
    )
    assert_equal(
      { type: "static-mapping", label: "Active", value: "true", map: { "true" => "YES" } },
      amis_static_mapping_field(label: "Active", value: "true", map: { "true" => "YES" })
    )
    assert_equal(
      { type: "static-html", label: "Permissions", value: "<strong>Read</strong>" },
      amis_static_html_field(label: "Permissions", value: "<strong>Read</strong>")
    )
    assert_equal(
      { type: "static", label: "Created at", value: "29 Sep 2026" },
      amis_datetime_field(label: "Created at", value: "29 Sep 2026")
    )
  end

  def test_builds_a_static_group
    fields = [ amis_static_field(label: "Name", value: "Acme") ]

    assert_equal(
      {
        title: "Basic Information",
        body: { type: "form", wrapWithPanel: false, columnCount: 3, body: fields }
      },
      amis_static_group(title: "Basic Information", fields: fields)
    )
  end

  def test_builds_a_panel_header_with_actions
    actions = [ { type: "button", label: "Edit" } ]

    assert_equal(
      {
        type: "flex",
        justify: "space-between",
        alignItems: "center",
        items: [
          { type: "tpl", tpl: "Basic Information" },
          { type: "flex", justify: "flex-end", items: actions }
        ]
      },
      amis_panel_header(title: "Basic Information", actions: actions)
    )
  end

  def test_builds_a_static_group_with_a_custom_header
    fields = [ amis_static_field(label: "Name", value: "Acme") ]
    header = amis_panel_header(title: "Basic Information")

    assert_equal(
      {
        header: header,
        body: { type: "form", wrapWithPanel: false, columnCount: 3, body: fields }
      },
      amis_static_group(header: header, fields: fields)
    )
  end
end
