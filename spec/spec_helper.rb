require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Dir['./spec/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false
end

require 'pdf/inspector'
require 'squid'

RSpec.shared_context 'PDF Inspector', inspect: true do
  let(:pdf) { Prawn::Document.new }
  let(:output) { pdf.render }
  let(:inspected_line) { PDF::Inspector::Graphics::Line.analyze output }
  let(:options) { {} }
end
