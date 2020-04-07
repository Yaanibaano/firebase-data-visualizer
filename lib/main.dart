import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "package:charts_flutter/flutter.dart" as charts;
import "package:cloud_firestore/cloud_firestore.dart";
import "package:fl_chart/fl_chart.dart";
import 'package:flutter/services.dart';


var numaxis = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.yellowAccent[100]))));

var domaxis = charts.OrdinalAxisSpec(
    renderSpec: charts.SmallTickRendererSpec(
        labelRotation: -30,
        // minimumPaddingBetweenLabelsPx: 4,
        labelOffsetFromAxisPx: 25,
        labelOffsetFromTickPx: 0,
        labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.yellowAccent[100]))));

class Help {
  final String team;
  final int t20;
  final int champions;
  final int worldcup;
  final Color color;

  Help({this.t20, this.champions, this.color, this.team, this.worldcup});

  Help.frommap(Map<String, dynamic> map)
      : assert(map["name"] != null),
        assert(map["t20"] != null),
        assert(map["champions"] != null),
        assert(map["worldcup"] != null),
        team = map["name"],
        t20 = map["t20"],
        champions = map["champions"],
        worldcup = map["worldcup"],
        color = colors[map["color"]];
}

class Line {
  final int hours;
  final int eating;
  final String day;
  final int no;

  Line.fromMap(Map<String,dynamic>map):
  hours = map["hours"],
  day = map["day"],
  no = map["no"],
  eating = map["eating"];

}

class Support {
  final String domain;
  final int measure;
  final color;
  final int club;
  final int inter;


  Support.frommap(Map<String, dynamic> map)
      : assert(map["name"] != null),
        assert(map["goals"] != null),
        domain = map["name"],
        measure = map["goals"],
        club = map["club"],
        inter = map["inter"],
        color = charts.ColorUtil.fromDartColor(Colors.pinkAccent[100]);
}

Map colors = {
  "brown": Colors.brown,
  "black": Colors.black,
  "green": Colors.green,
  "blue": Colors.blue,
  "yellow": Colors.yellow,
  "palegreen": Colors.lightGreen,
  "darkgreen": Colors.greenAccent,
  "red": Colors.red,
  "lightblue": Colors.lightBlue,
  "darkblue": Colors.deepPurpleAccent,
};

void main() {
  runApp(MaterialApp(
    title: "Chart App",
    home: Material(
      child: ChartApp(),
    ),
  ));
}

class ChartApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChartApp();
  }
}

int pieMainIndex = 0;
int barIndex = 0;
int lineIndex = 0;

class _ChartApp extends State<ChartApp> {



  String mostGoals =
      "Cristiano Ronaldo and Lionel Messi score at an unprecedented rate in today’s game, but there are those from history whose rate of scoring was even more impressive.";
  String lineText =
      "The quality of your sleep and eating hours affects your mental and physical health and the quality of your life, including your productivity,brain and heart health and creativity";
  String pieText =
      "Here is a Pie chart representing the all ICC tournaments winners including ICC Champions Trophy , ICC T20 World cup and ICC World Cup";

  var instance = Firestore.instance.collection("sports");
  PageController pageController = PageController();
  int pageNo = 0;

  TextDecoration dec1 = TextDecoration.underline;
  TextDecoration dec2 = TextDecoration.none;
  TextDecoration dec3 = TextDecoration.none;

  Color c1 = Colors.pinkAccent[100];
  Color c2 = Colors.white;
  Color c3 = Colors.white;

  List<List<String>> buttonsList = [
    ["All", "Club", "International"],
    ["Sleeping", "Eating", ""],
    ["T20", "World Cup", "Champions Trophy"]
  ];

  Widget controllerOfPage3(List<String> textList, List<dynamic> action) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                setState(() {
                  pieMainIndex = 0;
                    barIndex=0;
                   lineIndex=0;
                   c1 = Colors.pinkAccent[100];
                   c2 = Colors.white;
                   c3 = Colors.white;
                   dec1 = TextDecoration.underline;
                   dec2 = TextDecoration.none;
                   dec3 = TextDecoration.none;   

                });
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 7.0, left: 7.0),
                child: AnimatedDefaultTextStyle(
                  child:Text(textList[0]),
                  duration: Duration(milliseconds:500),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                      color: c1,
                      decoration: dec1
                    )),
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  pieMainIndex = 1;
                    barIndex=1;
                   lineIndex=1;
                   c2 = Colors.pinkAccent[100];
                   c1= Colors.white;
                   c3 = Colors.white;
                   dec2 = TextDecoration.underline;
                   dec1 = TextDecoration.none;
                   dec3 = TextDecoration.none;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 7.0, left: 7.0),
                child: Text(textList[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0,
                        decoration: dec2,
                        color: c2)),
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  pieMainIndex = 2;
                    barIndex=2;
                  c3 = Colors.pinkAccent[100];
                  c2 = Colors.white;
                  c1 = Colors.white;
                   dec3 = TextDecoration.underline;
                   dec2 = TextDecoration.none;
                   dec1 = TextDecoration.none;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 7.0, left: 7.0),
                child: Text(textList[2],
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                      color: c3,
                      decoration: dec3
                    )),
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff333333),
      body: Center(
          child: Column(
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Container(
              width: size.width,
              height: size.height * 0.33,
              decoration: BoxDecoration(
                  color: Color(0xff333333),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(0))),
              child: Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Positioned(
                    top: size.height*0.076,//65
                    left: size.height*0.017,//15
                    right:  size.height*0.008,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                            "Hello!! Im Chandru,Hope you like this app!",
                            style: TextStyle(
                                fontSize: size.height*0.041,//35
                                fontFamily: "Suez_One",
                                fontWeight: FontWeight.w900,
                                color: Colors.lightBlueAccent[100]),
                          )),
                          // Container(child: Text("Hope you like this app!!",style: TextStyle(fontSize: 35.0,fontFamily:"Suez_One",fontWeight: FontWeight.w900,color: Color(0xff333333)),)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: size.height*0.017,
                    left: size.height*0.017,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff333333),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100.0),
                              bottomLeft: Radius.circular(100.0),
                              topRight: Radius.circular(100.0),
                              bottomRight: Radius.circular(100.0))),
                      height: size.height*0.076,
                      child: controllerOfPage3(buttonsList[pageNo], [1, 2, 3]),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 10,
            child: PageView(
                onPageChanged: (int c) {
                  setState(() {
                    pageNo = c;
                  });
                },
                controller: pageController,
                children: <Widget>[
                  Center(
                    child: Card(
                      margin: EdgeInsets.only(top: size.width*0.011, bottom:size.width*0.011),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(size.width*0.011*3),
                      ),
                      color: Color(0xff222222),
                      elevation: 6.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff333333),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        width: size.width * 0.95,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(height: size.height*0.340, child: Cricket()),
                            Divider(
                              thickness: 3,
                              color: Colors.white,
                            ),
                            Container(
                              height: size.height*0.234,
                              width: size.width * 0.95,
                              color: Color(0xff333333),
                              child: Center(
                                  child: Text(mostGoals,
                                      style: TextStyle(
                                        color: Colors.yellowAccent[100],
                                        fontSize: 20,
                                        fontFamily: "Suez_One",
                                        fontWeight: FontWeight.w100,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff222222),
                      elevation: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff333333),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        // color: Color(0xff333333),
                        width: size.width * 0.95,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(height: size.height*0.340, child: LineData()),
                            Divider(
                              thickness: 3,
                              color: Colors.white,
                            ),
                            Container(
                              height: size.height*0.234,
                              width: size.width * 0.95,
                              color: Color(0xff333333),
                              child: Center(
                                  child: Text(lineText,
                                      style: TextStyle(
                                        color: Colors.greenAccent[100],
                                        fontSize: 20,
                                        fontFamily: "Suez_One",
                                        fontWeight: FontWeight.w100,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff222222),
                      elevation: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff333333),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        // color: Color(0xff333333),
                        width: size.width * 0.95,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(height:size.height*0.340, child: Football()),
                            Divider(
                              indent: size.width * 0.1,
                              endIndent: size.width * 0.1,
                              thickness: 3,
                              color: Colors.white,
                            ),
                            Container(
                              height: size.height*0.234,
                              width: size.width * 0.95,
                              color: Color(0xff333333),
                              child: Center(
                                  child: Text(pieText,
                                      style: TextStyle(
                                        color: Colors.pinkAccent[100],
                                        fontSize: 20,
                                        fontFamily: "Suez_One",
                                        fontWeight: FontWeight.w100,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      )),
    );
  }
}

class Cricket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Cricket();
  }
}

class _Cricket extends State<Cricket> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("sports")
          .document("footballl")
          .collection("most_goals")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Support> d = [];
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            DocumentSnapshot sn = snapshot.data.documents[i];
            d.add(Support.frommap(sn.data));
          }
          var series = List<charts.Series<Support, String>>();
          series.add(charts.Series(
              domainFn: (Support s, _) => s.domain.split(" ").toList()[0],
              measureFn: (Support s, _) {
                var c = [s.measure,s.club,s.inter];
                return c[barIndex];
              },
              colorFn: (Support s, _) => s.color,
              labelAccessorFn: (Support s,_) {
                var c = [s.measure,s.club,s.inter];
                return c[barIndex].toString();
              },
              id: "data",
              data: d));
          return barchart(context, series);
        }
      },
    );
  }

  Widget barchart(context, var data) {
    // data = goaldata;
    // getseries(data);
    return Container(
      child: charts.BarChart(
        data,
        animate: true,
        animationDuration: Duration(milliseconds: 800),
        domainAxis: domaxis,
        primaryMeasureAxis: numaxis,
        defaultInteractions: true,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
      ),
    );
  }
}

class Football extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Football();
  }
}

class _Football extends State<Football> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("sports")
            .document("cricket")
            .collection("wins")
            .snapshots(),
        builder: (context, snapshots) {
          List<Help> data = [];
          if (!snapshots.hasData) {
            return LinearProgressIndicator();
          } else {
            for (int i = 0; i < snapshots.data.documents.length; i++) {
              var c = snapshots.data.documents[i];
              data.add(Help.frommap(c.data));
            }
          }
          List<charts.Series<Help, dynamic>> series = [];
          series.add(charts.Series(
              data: data,
              id: "data",
              domainFn: (Help h, _) => h.team,
              measureFn: (Help h, _) {
                var indexList = [h.t20, h.worldcup,h.champions];
                return indexList[pieMainIndex];
              },
              colorFn: (Help h, _) => charts.ColorUtil.fromDartColor(h.color),
              labelAccessorFn: (Help h, _) {
                var indexList = [h.t20, h.worldcup,h.champions];
                return indexList[pieMainIndex].toString();
              },));
          return pieChart(context, series);
        });
  }

  Widget pieChart(context, series) {
    return charts.PieChart(series,
        animate: true,
        animationDuration: Duration(milliseconds: 700),
        behaviors: [
          new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 2,
            cellPadding: new EdgeInsets.only(right: 6.0, bottom: 6.0),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.white),
                fontFamily: 'Georgia',
                fontSize: 13),
          )
        ],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 50,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ]));
  }
}



class LineData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LineData();
  }
}

class _LineData extends State<LineData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("line").orderBy("no")
          .snapshots(),
      builder: (context, snapshots) {
        List<Line> data = [];
        List<charts.Series<Line, int>> series = [];

        if (!snapshots.hasData) {
          return LinearProgressIndicator();
        } 
        else {
          print(snapshots.data.documents.length);
          for (int i = 0; i < snapshots.data.documents.length; i++) {
            var sn = snapshots.data.documents[i];
            data.add(Line.fromMap(sn.data));
          }
        }
        series.add(charts.Series(
            data: data,
            id: "data",
            domainFn: (Line h, _) => h.no,
            measureFn: (Line h, _) {
              var c =[h.hours,h.eating];
              return c[lineIndex];
            }
            // colorFn: (Help h, _) => charts.ColorUtil.fromDartColor(h.color),labelAccessorFn: (Help h, _) => h.t20.toString()
            ));
        return lineChart(context, series);
      },
    );
  }

  Widget lineChart(context, series) {
    return Container(
      child: charts.LineChart(
        series,
        animate: true,
        animationDuration: Duration(milliseconds: 500),
      ),
    );
  }
}
