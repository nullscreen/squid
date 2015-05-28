require 'prawn/chart'

name = 'example.pdf'
monthly_views = {"views"=> {"Apr ’14"=>1351534, "May ’14"=>1278075, "Jun ’14"=>1686821, "Jul ’14"=>1547802, "Aug ’14"=>3558486, "Sep ’14"=>4157628, "Oct ’14"=>940739, "Nov ’14"=>970788, "Dec ’14"=>2862445, "Jan ’15"=>4748578, "Feb ’15"=>2854643, "Mar ’15"=>1298676, "Apr ’15"=>2104046}}
viewership    = {"views"=> {"Apr 01"=>20555, "Apr 02"=>29722, "Apr 03"=>120738, "Apr 04"=>76805, "Apr 05"=>68729, "Apr 06"=>80283, "Apr 07"=>82264, "Apr 08"=>80273, "Apr 09"=>71902, "Apr 10"=>36759, "Apr 11"=>31104, "Apr 12"=>29423, "Apr 13"=>95888, "Apr 14"=>80782, "Apr 15"=>99182, "Apr 16"=>92247, "Apr 17"=>77122, "Apr 18"=>69747, "Apr 19"=>36367, "Apr 20"=>82588, "Apr 21"=>57739, "Apr 22"=>65039, "Apr 23"=>92715, "Apr 24"=>67310, "Apr 25"=>156063, "Apr 26"=>69908, "Apr 27"=>58076, "Apr 28"=>58582, "Apr 29"=>60140, "Apr 30"=>55994}, "uploads"=> {"Apr 01"=>2, "Apr 02"=>0, "Apr 03"=>12, "Apr 04"=>0, "Apr 05"=>0, "Apr 06"=>1, "Apr 07"=>3, "Apr 08"=>8, "Apr 09"=>7, "Apr 10"=>12, "Apr 11"=>0, "Apr 12"=>0, "Apr 13"=>3, "Apr 14"=>0, "Apr 15"=>0, "Apr 16"=>2, "Apr 17"=>2, "Apr 18"=>0, "Apr 19"=>0, "Apr 20"=>2, "Apr 21"=>3, "Apr 22"=>2, "Apr 23"=>1, "Apr 24"=>1, "Apr 25"=>0, "Apr 26"=>0, "Apr 27"=>0, "Apr 28"=>2, "Apr 29"=>1, "Apr 30"=>2}}
year_on_year  = {"last_period"=> {"Apr 01"=>51048, "Apr 02"=>52024, "Apr 03"=>86399, "Apr 04"=>60243, "Apr 05"=>51371, "Apr 06"=>47709, "Apr 07"=>59965, "Apr 08"=>53363, "Apr 09"=>51726, "Apr 10"=>48251, "Apr 11"=>39498, "Apr 12"=>37114, "Apr 13"=>35470, "Apr 14"=>34531, "Apr 15"=>45624, "Apr 16"=>42130, "Apr 17"=>40163, "Apr 18"=>37859, "Apr 19"=>36400, "Apr 20"=>38218, "Apr 21"=>38319, "Apr 22"=>39631, "Apr 23"=>38917, "Apr 24"=>44720, "Apr 25"=>38561, "Apr 26"=>37407, "Apr 27"=>42400, "Apr 28"=>42998, "Apr 29"=>44114, "Apr 30"=>35361}, "this_period"=> {"Apr 01"=>20555, "Apr 02"=>29722, "Apr 03"=>120738, "Apr 04"=>76805, "Apr 05"=>68729, "Apr 06"=>80283, "Apr 07"=>82264, "Apr 08"=>80273, "Apr 09"=>71902, "Apr 10"=>36759, "Apr 11"=>31104, "Apr 12"=>29423, "Apr 13"=>95888, "Apr 14"=>80782, "Apr 15"=>99182, "Apr 16"=>92247, "Apr 17"=>77122, "Apr 18"=>69747, "Apr 19"=>36367, "Apr 20"=>82588, "Apr 21"=>57739, "Apr 22"=>65039, "Apr 23"=>92715, "Apr 24"=>67310, "Apr 25"=>156063, "Apr 26"=>69908, "Apr 27"=>58076, "Apr 28"=>58582, "Apr 29"=>60140, "Apr 30"=>55994}}
demographics  = {"71.8% male"=>{"13-17"=>5.7, "18-24"=>14.0, "25-34"=>25.6, "35-44"=>13.8, "45-54"=>8.6, "55-64"=>2.6, "65-"=>1.5}, "28.3% female"=>{"13-17"=>4.5, "18-24"=>6.3, "25-34"=>7.4, "35-44"=>4.2, "45-54"=>3.3, "55-64"=>1.6, "65-"=>1.0}}

Prawn::Document.generate(name) do
  # double_graph
  chart viewership, type: :two_axis, legend: {x_offset: -65}, ticks: true, categories: {every: 4}
  stroke_horizontal_rule
  move_down 40

  chart monthly_views, type: :column, legend: false, categories: {mark_last: true}
  stroke_horizontal_rule
  start_new_page

  # double_bar_graph
  chart demographics, format: :percentage, legend: {x_offset: -65}
  stroke_horizontal_rule
  move_down 40

  # double_graph
  chart year_on_year, type: :line, height: 124, ticks: true, categories: {every: 4}
  stroke_horizontal_rule

end

`open #{name}`
