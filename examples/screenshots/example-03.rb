filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {
    'Internet Explorer' => {2011 => 46.00, 2012 => 37.45, 2013 => 30.71, 2014 => 22.85, 2015 => 19.28, },
    'Chrome' =>            {2011 => 15.68, 2012 => 28.40, 2013 => 36.52, 2014 => 43.67, 2015 => 48.15, },
    'Firefox' =>           {2011 => 30.68, 2012 => 24.78, 2013 => 21.42, 2014 => 18.90, 2015 => 16.96, },
    'Safari' =>            {2011 =>  5.09, 2012 =>  6.62, 2013 =>  8.29, 2014 =>  9.73, 2015 => 10.28, },
    'Opera' =>             {2011 =>  2.00, 2012 =>  1.95, 2013 =>  1.19, 2014 =>  1.30, 2015 =>  1.58, }
  }
  chart data, type: :stack, format: :percentage, colors: %w(219ad3 fcd031 ea6827 353f73 f2272e)
end
