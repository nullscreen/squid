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


[Prawn](http://prawnpdf.org) is a great library to generate PDF files from Ruby,
but lacks some high-level components to draw graphs.

Squid integrates Prawn to support graph generation in a few lines of code.
The following snippet, for instance:

```ruby
chart downloads: {'2013': 82, '2014': 36, '2015': 102}
```

would generate in a PDF files the column chart illustrated below:

![Basic example](https://cloud.githubusercontent.com/assets/7408595/9027401/ff262118-3908-11e5-86e5-2dbe537865da.png "Basic example")

How to install
==============

Squid requires **Ruby 2.0 or higher**.
To include in your project, add `gem 'squid', '~> 0.1.0'` to the `Gemfile` file of your Ruby project.

How to use
==========

[...]

How to generate the manual
==========================

`rake manual`

How to contribute
=================

1. Run tests with `bundle exec rspec`
2. [...]
