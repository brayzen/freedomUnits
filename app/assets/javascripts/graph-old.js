function graphIt(symbol){
  $.ajax({
        url: "/kazoo",
        type: "GET",
        data: {"symbol": symbol},
        dataType: 'json',
        success: function(data, status, xhr){
          dataPlots = data;
          dataForGraph =  [{
                            data: dataPlots["sma50"],
                            label: "sma50",
                            color: "#F0F",
                            // bars: {show:true},
                            lines: {show:true},
                            points: {show:false}
                           },
                           {
                            data: dataPlots["price"],
                            label: "price",
                            color: "#096",
                            // bars: {show:true},
                            lines: {show:true},
                            points: {show:false}
                           }];
          options = {
                     legend: {position:"nw"}
                     };
          chart = $.plot($("#kazoo_graph"), dataForGraph, options);
        },
        error: function(data, status, xhr){
          console.log(data);
          console.log(status);
          console.log(xhr);
        },
  });
};

$(document).ready( function(){
  console.log('document ready');
  $('.get_kazoo').on('click', function(){
    console.log('kazoo controller');
    var symbol = $('.text').val().toUpperCase();
    if(symbol.length < 0)
      return false;
    graphIt(symbol);
  });
});
