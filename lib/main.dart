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

class _MyHomePageState extends State<MyHomePage>  {

  double screenWidth;
  double screenHeight;

  MyOvalClipper _myOvalClipper;

  ScrollController _scrollController;
  double threshold = 300;
  double ratio = 0;
  double currentPosition = 0;
  bool scrollUp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _myOvalClipper = MyOvalClipper(0);

    _scrollController = ScrollController();
    _scrollController.addListener((){
      print("scroll offset :  ${_scrollController.offset}");
      if(_scrollController.offset > currentPosition){
        //scroll down
        scrollUp = false;
        currentPosition = _scrollController.offset;
      }else{
        scrollUp = true;
        currentPosition = _scrollController.offset;
      }
      if(currentPosition > threshold){
        ratio = 1;
      }else{
        ratio = currentPosition / threshold;
      }
      setState(() {
        print("ratio : $ratio");
        _myOvalClipper = MyOvalClipper(ratio);
      });
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
        controller: _scrollController,
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
            Stack(
              children: <Widget>[
                Image.asset("assets/below.png",width: screenWidth,fit: BoxFit.fill,),
                ClipPath(
                  clipper: _myOvalClipper,
                  child: Image.asset("assets/above.png",width: screenWidth,fit: BoxFit.fill,),
                ),
              ],
            ),



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

class MyOvalClipper extends CustomClipper<Path>{
  final double ratio;


  MyOvalClipper(this.ratio);

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    print("size info : ${size.width}     ${size.height}");
    double width = size.width;
    double height = size.height;

    double radius = width * ratio;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius,0),clockwise: false,radius: Radius.circular(radius));
    path.close();

//    path.lineTo(width, 0);
//    path.lineTo(width, height);
//    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return ratio != (oldClipper as MyOvalClipper).ratio;
  }

}
