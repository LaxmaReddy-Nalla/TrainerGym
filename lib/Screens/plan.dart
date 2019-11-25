import 'package:flutter/material.dart';
import 'Today.dart';

// var i;
// if(i=1)
// {
//   print('Today');
// }
// else{
//   while(i>1){
//     print('Today'+$i);
//     i=i+1;
//   }
// }

class Plan extends StatefulWidget {
  Plan({Key key}) : super(key: key);

  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: 4,
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
                    child: Text("Today",
                        style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height / 35.0)),
                  ),
                  Tab(
                    child: Text(
                      " 13Nov",
                      style: TextStyle(
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 35.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      " 14Nov",
                      style: TextStyle(
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          fontSize: MediaQuery.of(context).size.height / 35.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      " 15Nov",
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
            children: <Widget>[Today(), Nxt(), Nxt1(), Nxt2()],
          ),
        ),
      ),
    );
  }
}

// class Today extends StatefulWidget {
//   Today({Key key}) : super(key: key);

//   _TodayState createState() => _TodayState();
// }

// class _TodayState extends State<Today> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class Nxt extends StatefulWidget {
  Nxt({Key key}) : super(key: key);

  _NxtState createState() => _NxtState();
}

class _NxtState extends State<Nxt> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Nxt1 extends StatefulWidget {
  Nxt1({Key key}) : super(key: key);

  _Nxt1State createState() => _Nxt1State();
}

class _Nxt1State extends State<Nxt1> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Nxt2 extends StatefulWidget {
  Nxt2({Key key}) : super(key: key);

  _Nxt2State createState() => _Nxt2State();
}

class _Nxt2State extends State<Nxt2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
