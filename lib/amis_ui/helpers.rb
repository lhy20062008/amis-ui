# frozen_string_literal: true

require "amis_ui/helpers/form"
require "amis_ui/configuration"
require "amis_ui/helpers/clickable"
require "amis_ui/helpers/button"
require "amis_ui/helpers/column"
require "amis_ui/helpers/filter"
require "amis_ui/helpers/mapping"
require "amis_ui/helpers/switch"
require "amis_ui/helpers/view"

module AmisUi
  module Helpers
    include Form
    include Clickable
    include Button
    include Column
    include Filter
    include Mapping
    include Switch
    include View
  end
end
