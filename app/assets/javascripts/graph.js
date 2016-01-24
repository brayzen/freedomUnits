function graphIt(symbol){
  $.ajax({
        url: "/compile_graph_data",
        type: "GET",
        data: {"symbol": symbol},
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
  console.log('HERE');
  $('#sbutton').on('click', function(){
    var symbol = $('#text').val().toUpperCase();
    graphIt(symbol);
  });
})
