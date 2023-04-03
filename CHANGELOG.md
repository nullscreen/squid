# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check
[Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## Unreleased

* [REMOVED] Remove support for Ruby < 2.4

## 1.4.1 - 2017.09.05

* [ENHANCEMENT] Require Ruby >= 2.2 (since support for 2.1 has ended)

## 1.4.0 - 2017.03.15

* [ENHANCEMENT] Require Prawn ~> 2.2.0
* [ENHANCEMENT] Remove a 'puts' statement left over from development

## 1.3.0 - 2016.03.01

* [ENHANCEMENT] When axis values are integer, ensure they are not truncated (see issue #48)

## 1.2.0 - 2016.01.24

* [ENHANCEMENT] Do not titleize the chart labels (see issue #39)

## 1.1.0 - 2015.18.12

* [ENHANCEMENT] Support ActiveSupport/Rails >= 5.0.0.beta1

## 1.0.1 - 2015.10.01

* [BUGFIX] Don’t try to draw an axis if the data is empty.

## 1.0.0 - 2015.08.31

* [FEATURE] Add `chart` method to Prawn::Document to draw graphs.
