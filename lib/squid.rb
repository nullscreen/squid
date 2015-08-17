require 'prawn'

require 'active_support' # Active Support does not load anything by default
require 'active_support/core_ext/string/inflections' # for titleize
require 'active_support/core_ext/object/inclusion' # for in?
require 'active_support/number_helper' # for number_to_rounded
require 'active_support/core_ext/enumerable' # for Array#sum

require 'squid/config'
require 'squid/interface'

module Squid
end
