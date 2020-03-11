import 'package:flutter/material.dart';
import 'package:nbastats/api.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NBA Times'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Team>> futureAlbum;

  Future<List<Team>> fetchAlbum() async {
    List<Team> list;
    http.Response response =
        await http.get('https://www.balldontlie.io/api/v1/teams');
    var responseJson = json.decode(response.body);
    var rest = responseJson["data"] as List;
    list = rest.map<Team>((json) => Team.fromJson(json)).toList();
    print("List Size: ${list.length}");
    return list;
  }

  Widget listViewWidget(List<Team> article) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/nba.png', width: 200.0),
            Text(
              'TEAMS STATS',
              style: new TextStyle(
                  color: Color(0xFF84A2AF),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
          ],
        ),
        Expanded(
            child: ListView.builder(
                itemCount: article.length,
                itemBuilder: (context, index) {
                  return (Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 220,
                      width: double.maxFinite,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset('images/nba.png',
                                      width: 50.0),
                                ),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 50, 0),
                                                  child: Icon(
                                                    Icons.perm_identity,
                                                    color: Colors.blue,
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      50, 20, 0, 0),
                                                  child: Text('${article[index].abbreviation} - ${article[index].fullName}'),
                                                ),
                                              ],
                                        )),
                                        Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 50, 0),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.blue,
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      50, 20, 0, 0),
                                                  child: Text('${article[index].city}'),
                                                ),
                                              ],
                                        )),
                                        Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 50, 0),
                                                  child: Icon(
                                                    Icons.dashboard,
                                                    color: Colors.blue,
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      50, 20, 0, 0),
                                                  child: Text('${article[index].division}'),
                                                ),
                                              ],
                                        ))
                                      ],
                                    ))
                              ],
                            )),
                      )));
                })),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
