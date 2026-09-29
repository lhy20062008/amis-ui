# frozen_string_literal: true

require "minitest/autorun"
require "amis_ui/helpers"

class ClickableNamedResource
  attr_reader :id

  def initialize(id)
    @id = id
  end
end

class AmisClickableTest < Minitest::Test
  include AmisUi::Helpers

  Resource = Struct.new(:id, :display_name)
  IdOnlyResource = Struct.new(:id)

  def test_builds_a_clickable_column
    assert_equal(
      {
        name: "client",
        label: "Client",
        searchable: { name: "client_id" },
        type: "button",
        body: {
          type: "button", level: "link", actionType: "link",
          label: "${client.label}", link: "/${client.resource}/${client.id}"
        }
      },
      amis_clickable_column(name: "client", label: "Client", searchable: { name: "client_id" })
    )
  end

  def test_builds_clickable_data_and_static_links
    resource = Resource.new(7, "Acme")
    clickable = amis_custom_clickable(resource, resource: "clients")

    assert_equal({ resource: "clients", id: 7, label: "Acme" }, clickable)
    assert_equal(
      { type: "static-link", label: "Client", body: "Acme", href: "/clients/7" },
      amis_static_link(label: "Client", link: clickable)
    )
    assert_equal(
      { type: "static-html", label: "Clients", labelRemark: "Related resources", value: '<a href="/clients/7">Acme</a>' },
      amis_static_links(label: "Clients", labelRemark: "Related resources", links: [ clickable ])
    )
  end

  def test_uses_the_id_when_a_resource_has_no_display_name
    assert_equal(
      { resource: "resources", id: 7, label: 7 },
      amis_custom_clickable(IdOnlyResource.new(7), resource: "resources")
    )
  end

  def test_derives_the_resource_name_when_helpers_are_loaded_directly
    assert_equal(
      { resource: "clickable_named_resources", id: 7, label: 7 },
      amis_custom_clickable(ClickableNamedResource.new(7))
    )
  end

  def test_escapes_static_link_urls_and_labels
    assert_equal(
      '<a href="/clients/7&quot; onclick=&quot;alert(1)">&lt;Acme&gt;</a>',
      amis_static_links(
        label: "Clients",
        links: [ { resource: "clients", id: '7" onclick="alert(1)', label: "<Acme>" } ]
      )[:value]
    )
  end

  def test_builds_a_boolean_mapping
    assert_equal(
      { "true" => "YES", "false" => "NO" },
      amis_boolean_mapping(true_label: "YES", false_label: "NO")
    )
  end
end
