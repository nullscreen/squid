Squid
=====

[![Build Status](https://github.com/nullscreen/squid/actions/workflows/ci.yml/badge.svg)](https://github.com/nullscreen/squid/actions)
[![Coverage Status](https://codecov.io/gh/nullscreen/squid/branch/master/graph/badge.svg?token=QcwqA4eA4h)](https://codecov.io/gh/nullscreen/squid)
[![Codacy](https://app.codacy.com/project/badge/Grade/a36f326196474937a2821442930dbbf1)](https://app.codacy.com/gh/nullscreen/squid/dashboard)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/github/nullscreen/squid/master/Squid/Interface)
[![Gem Version](http://img.shields.io/gem/v/squid.svg)](http://rubygems.org/gems/squid)

Squid helps you write Ruby code to draw graphs in PDF files.

The **source code** is available on
[GitHub](https://github.com/nullscreen/squid) and the **documentation** on
[RubyDoc](http://www.rubydoc.info/github/nullscreen/squid/master/Squid/Interface).

Quickstart
----------

[Prawn](http://prawnpdf.org) is a great Ruby library to generate PDF files but
lacks high-level components to draw graphs.

Squid adds a single method `chart(data = {}, options = {})` to Prawn. Provide
the `data` to plot as a hash, with each key/value representing a series. For
instance, the following code generates the graph below:

```ruby
data = {views: {2013 => 182, 2014 => 46, 2015 => 134}}
chart data
```

![01-basic](https://raw.githubusercontent.com/nullscreen/squid/master/examples/readme.png "chart(data)")

A comprehensive guide to Squid options
--------------------------------------

All the settings available for the `chart` method are detailed on the [Squid homepage](http://nullscreen.github.io/squid):

[![Squid homepage](https://cloud.githubusercontent.com/assets/7408595/9561009/3a333b1c-4de8-11e5-9eeb-0c45649e41b7.png)](http://nullscreen.github.io/squid)

Please proceed to
[http://nullscreen.github.io/squid](http://nullscreen.github.io/squid) for more
details and examples.

How to install
--------------

Squid requires **Ruby 2.4 or higher**. If used in a Rails project, requires
**Rails 5.0 or higher**.

To include in your project, add `gem 'squid', '~> 1.4'` to the `Gemfile` file of
your Ruby project.

How to generate the manual
--------------------------

```sh
rake manual
```

How to contribute
-----------------

If you’ve made it this far in the README… thanks! :v:
Feel free to try it the gem, explore the code, and send issues or pull requests.

All pull requests will have to make GitHub Actions and Code Climate happy in
order to be accepted. :kissing_smiling_eyes:

You can also run the tests locally with `bundle exec rspec`.

Happy hacking!
