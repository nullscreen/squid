require 'active_support'
require 'active_support/core_ext/string/inflections' # for titleize
require 'active_support/core_ext/module/delegation' # for delegate
require 'action_view/helpers/number_helper' # for number_with_precision

require 'prawn'
require 'prawn/chart/interface'

module Prawn
  module Chart
  end
end