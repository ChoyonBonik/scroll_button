import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = ScrollController();
  int index = 0;

  var isVisible = false;

  @override
  void initState(){
    super.initState();
    controller.addListener(() {
      if(controller.position.atEdge)
        {
          if(controller.position.pixels > 0)
            if(!isVisible)
              setState(() {
                isVisible = true;
              });
        }
      else {
        if(!isVisible)
          setState(() {
            isVisible = false;
          });
      }
    });
  }
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Scrolling'),
          centerTitle: true,
        ),
        body: buildList(),
        floatingActionButton:
        Visibility(visible: isVisible,
          child: FloatingActionButton(

          child: Icon(Icons.arrow_upward,),
          //onPressed: scrollUp,
          tooltip: 'increment', onPressed: scrollUp,
        ),)
      );

  Widget buildList() => ListView.builder(
        controller: controller,
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      );

  void scrollUp() {
    final double start = 0;
    controller.jumpTo(start);
  }
}
