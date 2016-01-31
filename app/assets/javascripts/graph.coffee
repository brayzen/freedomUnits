$ ->
  $('.get_kazoo').on 'click', ->
    symbol = $('.text').val().toUpperCase()
    if symbol.length < 1
      alert 'enter a symbol silly'
      return false
    $.get "/kazoo?symbol=#{symbol}"
      .success (data)->
        window.graph.graph_days data.days

class Graph
  constructor: ->
  graph_days: (days) ->
    smas = days.smas
    closes = days.closes
    dataForGraph =  [
      {
        data: smas
        label: "sma"
        color: "#F0F"
        #bars: {show:true}
        lines: {show: true}
        points: {show: false}
      }
      {
        data: closes
        label: "close"
        color: "#096"
        #bars: {show:true}
        lines: {show: true}
        points: {show: false}
      }
    ]
    options = { legend: {position:"nw"} }
    chart = $.plot($("#kazoo_graph"), dataForGraph, options)

$ ->
  window.graph = new Graph()
