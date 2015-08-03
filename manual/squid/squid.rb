Prawn::ManualBuilder::Example.generate 'squid.pdf' do
  package 'squid' do |p|
    p.name = 'Squid'

    p.intro do
      prose('
        Prawn is a great library to generate PDF files from Ruby, but lacks high-level components to generate graphs.
        Squid integrates Prawn by providing methods to plot charts in PDF files with few lines of code.
        This manual shows:
      ')

      list(
        'How to create graphs',
      )
    end

    p.section 'Basics' do |s|
      s.example 'basic'
    end

    p.section 'Styling' do |s|
      s.example 'height'
    end

  end
end
