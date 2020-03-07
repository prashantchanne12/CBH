import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatefulWidget {
  final int s, b, t;
  Chart({Key key, this.s, this.b, this.t}) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('technical', widget.t, Colors.red),
      ClicksPerYear('bussiness', widget.s, Colors.yellow),
      ClicksPerYear('social', widget.b, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              'Statistical Analysis',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Lato',
                color: Colors.blue[700],
              ),
            ),
          ),
          chartWidget,
        ],
      ),
    );
  }
}
