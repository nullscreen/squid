Prawn::ManualBuilder::Example.generate 'screenshots.pdf' do
  package 'screenshots' do |p|
    p.name = 'Screenshots'

    p.intro do
    end

    p.section 'Examples' do |s|
      s.example '01-basic'
      s.example '02-type-point'
      s.example '03-type-line'
      s.example '04-type-stack'
      s.example '05-type-two_axis'
      s.example '06-line_width'
      s.example '07-colors'
      s.example '08-steps'
      s.example '09-ticks-false'
      s.example '10-baseline-false'
      s.example '11-every'
      s.example '12-legend-false'
      s.example '13-legend-offset'
      s.example '14-border'
      s.example '15-height'
      s.example '16-labels'
      s.example '17-format-percentage'
      s.example '18-format-currency'
      s.example '19-format-float'
      s.example '20-format-seconds'
      s.example '21-singular-options'
    end
  end
end
