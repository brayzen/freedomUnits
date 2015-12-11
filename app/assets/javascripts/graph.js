function graphIt(symbol){
  var curl = "/compile_graph_data?symbol=" + symbol;
  console.log(curl);

  $.ajax({
        url: curl,
        type: "GET",
        // data: {"symbol": "AAPL"},
        dataType: 'json',
        success: function(data, status, xhr){
          console.log('SUCCESS');
          console.log(data);
          console.log(status);
          console.log(xhr);
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
          chart = $.plot($("#placeholder"), dataForGraph, options);
        },
        error: function(data, status, xhr){
          console.log(data);
          console.log(status);
          console.log(xhr);
        },
  });
};

$(function(){
  console.log('HEWRE');
  $('#sbutton').on('click', function(){
    var symbol = $('#text').val().toUpperCase();
    graphIt(symbol);
  });
})
