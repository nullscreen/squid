require 'prawn'
require 'squid/graph'

module Squid
  # Provides the `chart` method to use in Prawn::Document
  # @see http://prawnpdf.org/api-docs/2.0/Prawn/Document.html
  module Interface
    # Plots a graph the current document.
    #
    # @param [Hash<#to_s, [Hash<#to_s, Numeric>]>] data the series to plot in
    #   the graph. Each key is the name of the series, and each value contains
    #   the values for the series. Values are also a hash, where each key is
    #   a category, and each value the numerical value for that category.
    # @param [Hash] settings the option to customize the graph.
    # @option settings [Boolean] :baseline (true) whether to plot the baseline.
    # @option settings [Boolean] :border (false) whether to plot the border.
    # @option settings [Boolean] :chart (true) whether to plot the chart.
    # @option settings [Array<String>] :colors (true) the color of each series.
    # @option settings [Integer] :every (1) how often to plot the categories.
    # @option settings [Symbol] :format (:integer) the format of axis values.
    # @option settings [Numeric] :height (250) the full height of the graph.
    # @option settings [Boolean] :labels (false) whether to plot value labels.
    # @option settings [<Boolean, Hash>] :legend (true) whether to plot the
    #   legend. If a Hash is provided, the `:right` and `:bottom` options can be
    #   set to specify the right and bottom margin of the legend.
    # @option settings [Numeric] :line_width (3) the line width for line graphs.
    # @option settings [Numeric] :steps (4) the number of gridlines.
    # @option settings [Boolean] :ticks (true) whether to plot the ticks.
    # @option settings [Symbol] :type (:column) the type of graph.
    # @option settings [Numeric] :min
    # @option settings [Numeric] :max
    def chart(data =  {}, settings = {})
      Graph.new(self, data, settings).draw
    end
  end
end

# Extends Prawn::Document to include the `chart` methods
Prawn::Document.extensions << Squid::Interface
