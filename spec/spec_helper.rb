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
  let(:inspected_points) { inspected_line.points.each_slice(2) }
  let(:inspected_text) { PDF::Inspector::Text.analyze output }
  let(:inspected_strings) { inspected_text.strings }
  let(:inspected_rectangle) { PDF::Inspector::Graphics::Rectangle.analyze output }
  let(:data) { {} }
  let(:options) { {} }

  let(:views) { {2013 => 182, 2014 => 46, 2015 => 102} }
  let(:uniques) { {2013 => 110, 2014 => 30, 2015 => 88} }
  let(:subscribers) { {2013 => 50, 2014 => -30, 2015 => 20} }
end
