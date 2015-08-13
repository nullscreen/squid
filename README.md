Squid
=====

Squid helps you write Ruby code to draw graphs in PDF files.

The **source code** is available on [GitHub](https://github.com/Fullscreen/squid) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/squid/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/squid/master.svg)](https://travis-ci.org/Fullscreen/squid)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/squid/master.svg)](https://coveralls.io/r/Fullscreen/squid)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/squid.svg)](https://gemnasium.com/Fullscreen/squid)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/squid.svg)](https://codeclimate.com/github/Fullscreen/squid)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/squid/frames)
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

![04-color](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_04.png "chart(data, color: '5d9648')")

##### `:steps` changes the number of gridlines (default: `4`).

![05-gridlines](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_05.png "chart(data, steps: 6)")

##### `:ticks` shows/hides the ticks between the baseline and each category (default: `true`).

![06-ticks](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_06.png "chart(data, ticks: false)")

##### `:baseline` shows/hides the baseline (default: `true`).

![07-baseline](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_07.png "chart(data, baseline: false)")

##### `:legend` shows/hides the legend (default: `true`).

![08-legend](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_08.png "chart(data, legend: false)")

##### `:format` changes the format of the label values. Can be `:integer` (default), `:float`, `:percentage`, `:currency`, or `:seconds`.

![09-format](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_09.png "chart(data, format: :percentage)")

##### `:value_labels` shows/hides the value for each point in the graph (default: `false`).

![10-labels](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_10.png "chart(data, value_labels: true)")

##### `:border` shows/hides a border around the graph (default: `false`).

![11-border](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_11.png "chart(data, border: true)")

##### `:height` changes the height of the graph (default: `250`).

![12-height](https://raw.githubusercontent.com/fullscreen/squid/master/examples/screenshots/readme_12.png "chart(data, height: 150)")


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

I’m still in the process of extracting Squid from a private project, so
I’m probably adding new features to the `chart` method as you are reading.

Feel free to try it out and send issues or pull requests regarding what
Squid includes so far.

All pull requests will have to make Travis and Code Climate happy in order to be accepted. :kissing_smiling_eyes:
You can also run the tests locally with `bundle exec rspec`.
Happy hacking!