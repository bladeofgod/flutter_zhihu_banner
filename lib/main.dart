import 'package:flutter/material.dart';

import 'zhihu_banner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  double screenWidth;
  double screenHeight;

  ScrollController _scrollController;
  double currentPosition = 0;
  bool scrollUp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if(_scrollController.offset > currentPosition){
        //scroll down
        scrollUp = false;
        currentPosition = _scrollController.offset;
      }else{
        scrollUp = true;
        currentPosition = _scrollController.offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //up content
            SizedBox(
              height: 500,
              width: screenWidth,
              child: Container(
                color: Colors.red,
              ),
            ),

            //switch banner
            //ZhiHuSwitchBanner(),
            Image.asset("assets/above.png",width: screenWidth,fit: BoxFit.fill,),

            //bottom content
            SizedBox(
              height: 500,
              width: screenWidth,
              child: Container(
                color: Colors.yellowAccent,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
