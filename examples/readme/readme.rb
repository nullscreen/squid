Prawn::ManualBuilder::Example.generate 'readme.pdf' do
  package 'readme' do |p|
    p.name = 'Readme'

    p.intro do
    end

    p.section 'Single series' do |s|
      s.example '01-basic'
      s.example '02-type-point'
      s.example '03-type-line'
      s.example '04-color'
      s.example '05-gridlines'
      s.example '06-ticks'
      s.example '07-baseline'
      s.example '08-legend'
      s.example '09-format'
      s.example '10-labels'
      s.example '11-border'
      s.example '12-height'
      s.example '13-multiple-series'
    end
  end
end
