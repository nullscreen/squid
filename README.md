Squid
=====

Squid helps you write Ruby code to draw graphs in PDF files.

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

