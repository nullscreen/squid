Squid
=====

Squid helps you write Ruby code to draw graphs in PDF files.

The **source code** is available on [GitHub](https://github.com/Fullscreen/squid) and the **documentation** on [RubyDoc](http://www.rubydoc.info/github/Fullscreen/squid/master/Squid/Interface).

[![Build Status](http://img.shields.io/travis/Fullscreen/squid/master.svg)](https://travis-ci.org/Fullscreen/squid)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/squid/master.svg)](https://coveralls.io/r/Fullscreen/squid)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/squid.svg)](https://gemnasium.com/Fullscreen/squid)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/squid.svg)](https://codeclimate.com/github/Fullscreen/squid)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/github/Fullscreen/squid/master/Squid/Interface)
[![Gem Version](http://img.shields.io/gem/v/squid.svg)](http://rubygems.org/gems/squid)

[Prawn](http://prawnpdf.org) is a great Ruby library to generate PDF files
but lacks high-level components to draw graphs.

Squid adds a single method `chart(data = {}, options = {})` to Prawn.

Provide the `data` to plot as a hash, with each key/value representing a series.

For instance, the following code generates the graph below:

```ruby
data = {views: {2013 => 182, 2014 => 46, 2015 => 134}}
chart data
```

![01-basic](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_01.png "chart(data)")


Graph options
-------------

By providing `options` to the `chart` method, you can customize the format of the graph.

Multiple options can be combined. Here is a comprehensive list.

##### `:type` sets the type of graph. Can be `:column` (default), `:point`, or `:line`.

![02-type-point](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_02.png "chart(data, type: :point)")

##### `:line_width` changes the line width (default: `3`, only applies to line graphs).

![03-type-line](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_03.png "chart(data, type: :line, line_width: 10)")

##### `:color` changes the color of the chart (default: `'2e578c'`).

![04-colors](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_04.png "chart(data, colors: ['5d9648'])")

##### `:steps` changes the number of gridlines (default: `4`).

![05-gridlines](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_05.png "chart(data, steps: 6)")

##### `:ticks` shows/hides the ticks between the baseline and each category (default: `true`).

![06-ticks](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_06.png "chart(data, ticks: false)")

##### `:baseline` shows/hides the baseline (default: `true`).

![07-baseline](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_07.png "chart(data, baseline: false)")

##### `:every` specifies how often to show category labels on the baseline (default: `1`).

![08-every](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_08.png "chart(data, every: 2)")

##### `:legend` shows/hides the legend (default: `true`).

![09-legend](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_09.png "chart(data, legend: false)")

##### `:legend` can also set the right and bottom margins of the legend (default: `{right: 0, bottom: 15}`).

![10-legend-offset](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_10.png "chart(data, legend: {right: 50})")

##### `:format` changes the format of the axis labels. Can be `:integer` (default), `:float`, `:percentage`, `:currency`, or `:seconds`.

![11-format](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_11.png "chart(data, format: :percentage)")

##### `:label` shows/hides the value for each point in the graph (default: `false`).

![12-label](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_12.png "chart(data, label: true)")

##### `:border` shows/hides a border around the graph (default: `false`).

![13-border](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_13.png "chart(data, border: true)")

##### `:height` changes the height of the graph (default: `250`).

![14-height](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_14.png "chart(data, height: 150)")

Multiple series
---------------

By providing multiple key/values `data` to the `chart` method, you can plot multiple series on a graph.

For instance, the following code generates the graph below:

```ruby
data = {safari:  {2013 => 43.2, 2014 => 46.1, 2015 => 50.7},
       firefox:  {2013 => 56.8, 2014 => 53.9, 2015 => 49.3}}
chart data, labels: true, format: :percentage
```

![15-multiple-columns](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_15.png "chart(data, label: true, format: :percentage)")

When plotting multiple series, the option `type: :stack` can be set to display stacked columns:

![16-multiple-stacks](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_16.png "chart(data, type: :stack, format: :percentage)")

Any value set for the `:color`, `:format`, `:line_width` and `:label` options will be applied to the first series only:

![17-singular-options](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_17.png "chart data, type: :line, color: '6f3d79', format: :percentage, line_width: 0.5, label: true")

To customize each series, use the _plural_ options `:colors`, `:formats`, `:line_widths` and `:labels` instead:

![18-plural-options](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_18.png "chart data, type: :line, colors: ['6f3d79', '7d807f'], formats: [:percentage, :percentage], line_widths: [0.5, 6], labels: [true, true]")


Finally, the option `type: :two_axis` can be set to display two separate axes in your series belong to two different domains.

For instance, the following code generates the graph below:

```ruby
data = {views: {2013 => 182, 2014 => 46, 2015 => 88},
     earnings: {2013 => 104_323, 2014 => 27_234, 2015 => 14_123}}
chart data, type: :two_axis
```

![19-two-axis](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_19.png "chart(data, type: :two_axis)")

How to install
==============

Squid requires **Ruby 2.1 or higher**.
If used in a Rails project, requires **Rails 4.0 or higher**.

To include in your project, add `gem 'squid', github: 'fullscreen/squid'` to the `Gemfile` file of your Ruby project.

How to generate the manual
==========================

`rake manual`

How to contribute
=================

If you’ve made it this far in the README… thanks! :v:

I’m about to release version 1 of this gem.
Feel free to try it out and send issues or pull requests.

All pull requests will have to make Travis and Code Climate happy in order to be accepted. :kissing_smiling_eyes:

You can also run the tests locally with `bundle exec rspec`.

Happy hacking!