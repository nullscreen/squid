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

![01-basic](https://raw.githubusercontent.com/fullscreen/squid/master/examples/readme.png "chart(data)")

A comprehensive guide to Squid options
======================================

All the settings available for the `chart` method are detailed on the [Squid homepage](http://fullscreen.github.io/squid):

[![Squid homepage](https://cloud.githubusercontent.com/assets/7408595/9561009/3a333b1c-4de8-11e5-9eeb-0c45649e41b7.png)](http://fullscreen.github.io/squid)

Please proceed to [http://fullscreen.github.io/squid](http://fullscreen.github.io/squid) for more details and examples.

How to install
==============

Squid requires **Ruby 2.2 or higher**.
If used in a Rails project, requires **Rails 4.0 or higher**.

To include in your project, add `gem 'squid', '~> 1.4'` to the `Gemfile` file of your Ruby project.

How to generate the manual
==========================

`rake manual`

How to contribute
=================

If you’ve made it this far in the README… thanks! :v:
Feel free to try it the gem, explore the code, and send issues or pull requests.

All pull requests will have to make Travis and Code Climate happy in order to be accepted. :kissing_smiling_eyes:

You can also run the tests locally with `bundle exec rspec`.

Happy hacking!
