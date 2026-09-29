# amis_ui

A small Rails helper gem for creating [AMis](https://aisuda.bce.baidu.com/amis/en-US/docs/index) schemas.

## Installation

Add the gem to your Rails application's Gemfile:

```ruby
gem "amis_ui"
```

The helper is automatically available in views after Rails loads Action View.

## Usage

```ruby
amis_input_text(name: "title", label: "Title")
# => {
#      name: "title",
#      label: "Title",
#      type: "input-text",
#      trimContents: true,
#      clearValueOnHidden: true,
#      labelAlign: "left"
#    }
```

Explicit options always take precedence over defaults.

## Configuration

Member action buttons use `/cms` by default. Configure a different prefix in
your Rails initializer when necessary:

```ruby
AmisUi.configure do |config|
  config.cms_path = "/admin"
end
```

The path is normalized, so `"admin"` and `"/admin/"` both become `"/admin"`.

### Related-resource links

The gem also provides helpers compatible with OCA3 AMIS CMS schemas:

```ruby
client = amis_custom_clickable(client_record, label: client_record.name)
amis_clickable_column(name: "client", label: "Client")
amis_static_link(label: "Client", link: client)
```

For multiple relations, use `amis_custom_clickables`, `amis_clickables_column`,
and `amis_static_links`. Link data follows the shared contract:

```ruby
{ resource: "clients", id: 1, label: "Acme Pte Ltd" }
```
