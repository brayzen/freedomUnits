require 'date'

class GraphController < ApplicationController

  def index
    @data = params[:symbol] ? compile_graph_data : "Hit submit"
  end
end
