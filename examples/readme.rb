require 'squid'
require 'prawn/manual_builder'
Prawn::ManualBuilder.manual_dir = File.dirname(__FILE__)
Prawn::Font::AFM.hide_m17n_warning = true
Prawn::ManualBuilder::Example.generate 'readme.pdf', skip_page_creation: true do
  load_package 'readme'
end
