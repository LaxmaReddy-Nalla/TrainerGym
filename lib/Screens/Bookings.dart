import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trainer/Arrangements/ShowImage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Info/variables.dart' as global;
import 'package:http/http.dart' as http;

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  var jsonResponse;
  @override
  void initState() {
    super.initState();
    getUpcoming();
  }

  getUpcoming() async {
    var response = await http.get(
        "http://34.93.104.9:3000/api/workplace/upcomingsessions",
        headers: {
          "token": global.token,
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          global.upcomingsessions = jsonResponse['sessions'];
          print(global.upcomingsessions);
          print(global.upcomingsessions.length);
          print(global.upcomingsessions[0]['account']['name']);
          print(global.upcomingsessions[0]['trainer_allotted']['name']);
        });
        getPast();
      }
    } else {
      print('error');
    }
  }

  getPast() async {
    var response = await http
        .get("http://34.93.104.9:3000/api/workplace/pastsessions", headers: {
      "token": global.token,
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          global.pastsessions = jsonResponse['sessions'];
          print(global.pastsessions);
          print(global.pastsessions.length);
          print(global.pastsessions[0]['account']['name']);
          print(global.pastsessions[0]['workplace']['address']);
          getAccountDetails();
        });
      }
    } else {
      print('error');
    }
  }

  getAccountDetails() async {
    var response = await http.get(
        "http://34.93.104.9:3000/api/workplace/getaccountdetails",
        headers: {
          "token": global.token,
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          global.AccountDetails = jsonResponse;
          print(global.AccountDetails);
          global.referralCode = global.AccountDetails['workplace']['uid'];
          print(global.referralCode);
        });
      }
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    textStyle() {
      return new TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: MediaQuery.of(context).size.height / 32.0);
    }

    return WillPopScope(
        onWillPop: () {},
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Montserrat', accentColor: Colors.red),
          routes: <String, WidgetBuilder>{},
          home: new DefaultTabController(
            length: 2,
            child: new Scaffold(
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height / 6.5),
                child: AppBar(
                  elevation: 0.0,
                  actions: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 35.0,
                          left: MediaQuery.of(context).size.width / 20,
                          right: MediaQuery.of(context).size.width / 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.width / 20.3333,
                              width: MediaQuery.of(context).size.width / 3.3333,
                              child: ShowImage("2ndscreenlogo"),
                            ),
                            SizedBox(
                              child: Text("Center Code: " + global.referralCode,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            InkWell(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.205,
                                width: MediaQuery.of(context).size.width / 7.0,
                                child: ShowImage("userimg"),
                              ),
                              onTap: () {
                                print(global.referralCode);
                                print("pressed");
                                Navigator.pushNamed(context, "AccountPage");
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text("Plan", style: textStyle()),
                      ),
                      Tab(
                        child: Text("Bookings", style: textStyle()),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Plan(),
                  Bookings(),
                ],
              ),
            ),
          ),
        ));
  }
}

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height /
                12.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text("Upcoming",
                        style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height / 35.0)),
                  ),
                  Tab(
                    child: Text(
                      "Past",
                      style: TextStyle(
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 35.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Upcoming(),
              Past(),
            ],
          ),
        ),
      ),
    );
  }
}

class Upcoming extends StatefulWidget {
  // Upcoming({Key key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Column(children: <Widget>[
        SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: global.upcomingsessions.length == 0
                ? Center(child: Text("no data"))
                : ListView.builder(
                    itemCount: global.upcomingsessions.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: ShowImage('gym_pic2'),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Gold Trainer 5 Sessions',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        'Fusion Gym',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        "Client: " +
                                            global.upcomingsessions[index]
                                                ['account']['name'],
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Trainer: " +
                                                global.upcomingsessions[index]
                                                        ['trainer_allotted']
                                                    ['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0),
                                          ),
                                          IconButton(
                                            iconSize: 30.0,
                                            icon: Icon(Icons.phone_in_talk),
                                            onPressed: () {
                                              print("Clicked");
                                              print("launching");
                                              launch(
                                                  "tel:+91${global.trainers[index]['phone']}");
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }))
      ])
    ]);
  }
}

class Past extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 0.95,
          child: global.pastsessions.length == 0
              ? Center(child: Text("no data"))
              : ListView.builder(
                  itemCount: global.pastsessions.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: ShowImage('gym_pic2'),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Gold Trainer Sessions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      global.pastsessions[index]['slot']
                                              ['date_time'] +
                                          global.pastsessions[index]
                                              ['workplace']['address'],
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      'Client: ' +
                                          global.pastsessions[index]['account']
                                              ['name'],
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        )
      ]),
    ]);
  }
}

class Plan extends StatefulWidget {
  Plan({Key key}) : super(key: key);

  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
