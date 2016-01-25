$ ->
  $('.get_kazoo').on 'click', ->
    symbol = $('.text').val().toUpperCase()
    return false if symbol.length < 0
    $.get "/kazoo?symbol=#{symbol}"
      .success (data)->
        console.log data
