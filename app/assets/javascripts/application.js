// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require plugins/morris/raphael.min.js
//= require plugins/morris/morris.min.js
//= require plugins/morris/morris-data.js

google.charts.load('current', {'packages':['corechart']});

var chartData = [{

   "year": "08-22",
       "cars": 48.8,
       "motorcycles": 11.2, 
       "bicycles": 8.8
}, {
   "year": "08-23",
       "cars": 46.2,
       "motorcycles": 12.2,
       "bicycles": 8.8
}, {
   "year": "08-24",
       "cars": 43.4,
       "motorcycles": 11.0,
       "bicycles": 9.8
}, {
   "year": "08-25",
       "cars":36.8 ,
       "motorcycles": 10.8,
       "bicycles": 10.1
}, {
   "year": "08-26",
       "cars": 40.1,
       "motorcycles": 11.2,
       "bicycles": 10.0
}, {
   "year": "08-27",
       "cars": 42.3,
       "motorcycles": 13.2,
       "bicycles": 10.6
}, {
   "year": "08-28",
       "cars": 39.2,
       "motorcycles": 16.2,
       "bicycles": 10.6
}, {
   "year": "08-29",
       "cars": 37.2,
       "motorcycles": 16.2,
       "bicycles": 9.8
}, {
   "year": "08-30",
       "cars": 39.0,
       "motorcycles": 15.5,
       "bicycles": 11.2
},  ];

var chart =  AmCharts.makeChart("chartdiv", {
    "type": "serial",
		"theme": "dark",

    "fontFamily": "Lato",
    "autoMargins": true,
    "addClassNames": true,
    "zoomOutText": "",
    "defs": {
        "filter": [
            {
                "x": "-50%",
                "y": "-50%",
                "width": "200%",
                "height": "200%",
                "id": "blur",
                "feGaussianBlur": {
                    "in": "SourceGraphic",
                    "stdDeviation": "50"
                }
            },
            {
                "id": "shadow",
                "width": "150%",
                "height": "150%",
                "feOffset": {
                    "result": "offOut",
                    "in": "SourceAlpha",
                    "dx": "2",
                    "dy": "2"
                },
                "feGaussianBlur": {
                    "result": "blurOut",
                    "in": "offOut",
                    "stdDeviation": "10"
                },
                "feColorMatrix": {
                    "result": "blurOut",
                    "type": "matrix",
                    "values": "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 .2 0"
                },
                "feBlend": {
                    "in": "SourceGraphic",
                    "in2": "blurOut",
                    "mode": "normal"
                }
            }
        ]
    },
    "fontSize": 15,
    "pathToImages": "../amcharts/images/",
    "dataProvider": chartData,
    "dataDateFormat": "MM-DD",
    "marginTop": 0,
    "marginRight": 1,
    "marginLeft": 0,
    "autoMarginOffset": 5,
    "categoryField": "year",
    "categoryAxis": {
        "gridAlpha": 0.07,
        "axisColor": "#DADADA",
        "startOnAxis": true,
        "tickLength": 0,
        "parseDates": true,
        "minPeriod": "DD",
      
    },
    "valueAxes": [
        {
            
            "ignoreAxisWidth":true,
            "stackType": "regular",
            "gridAlpha": 0.07,
            "axisAlpha": 0,
            "inside": true


        }
    ],
    "graphs": [
        {
            "id": "g1",
            "type": "line",
            "title": "Cars",
            "valueField": "cars",
            "fillColors": [
                "#0066e3",
                "#802ea9"
            ],
            "lineAlpha": 0.7,
            "fillAlphas": 1,
            "lineColor": "#FFFFFF",
            "bullet": "round",
            "dashLength": 2,
            "bulletBorderAlpha": 1,
            "bulletAlpha": 1,
            "bulletSize": 10,
            "stackable": false,
            "bulletColor": "#5d7ad9",
            "bulletBorderColor": "#FFFFFF",
            "bulletBorderThickness": 1,
            "balloonText": "<div style='margin-bottom:30px;text-shadow: 2px 2px rgba(0, 0, 0, 0.1); font-weight:200;font-size:30px; color:#FF5733'>[[value]] acidlipsjpg</div>"
        },
        {
           "id": "g2",
            "title": "Motorcycles",
            "valueField": "motorcycles",
            "lineAlpha": 0.7,
            "lineColor": "#0EFF07",
            "bullet": "round",
            "dashLength": 2,
            "bulletBorderAlpha": 1,
            "bulletAlpha": 1,
            "bulletSize": 10,
            "stackable": false,
            "bulletColor": "#5d7ad9",
            "bulletBorderColor": "#FFFFFF",
            "bulletBorderThickness": 1,
            "balloonText": "<div style='margin-bottom:30px;text-shadow: 2px 2px rgba(0, 0, 0, 0.1); font-weight:200;font-size:30px; color:#0EFF07'>[[value]] QueenxJessica</div>"
        },
        {
            "id": "g3",
            "title": "Bicycles",
            "valueField": "bicycles",
            "lineAlpha": 0.7,
            "lineColor": "#0EFF07",
            "bullet": "round",
            "dashLength": 2,
            "bulletBorderAlpha": 1,
            "bulletAlpha": 1,
            "bulletSize": 10,
            "stackable": false,
            "bulletColor": "#5d7ad9",
            "bulletBorderColor": "#FFFFFF",
            "bulletBorderThickness": 1,
            "balloonText": "<div style='margin-bottom:30px;text-shadow: 2px 2px rgba(0, 0, 0, 0.1); font-weight:200;font-size:30px; color:#0EFF07'>[[value]] kordeilawley</div>"
        }
    ],
    "chartCursor": {
        "cursorAlpha": 1,
        "zoomable": false,
        "cursorColor": "#FFFFFF",
        "categoryBalloonColor": "#8d83c8",
        "fullWidth": true,
        "categoryBalloonDateFormat": "MM-DD",
        "balloonPointerOrientation": "vertical"
    },
    "balloon": {
        "borderAlpha": 0,
        "fillAlpha": 0,
        "shadowAlpha": 0,
        "offsetX": 40,
        "offsetY": -50
    }
});

// we zoom chart in order to have better blur (form side to side)
chart.addListener("dataUpdated", zoomChart);

function zoomChart(){
    chart.zoomToIndexes(1, chartData.length - 2);
}