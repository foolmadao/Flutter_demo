import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List _imgList = [
    'https://cn.bing.com/th?id=OIP.mWHSE3Q9KJnI-G8QEXXfsAHaH-&pid=Api&rs=1&p=0',
    'https://cn.bing.com/th?id=OIP.RV5hLPYeCtEQMm1YvgregwHaFv&pid=Api&w=1024&h=794&rs=1&p=0',
    'https://cn.bing.com/th?id=OIP.biWUP1BpIAvGl51_6xQ6TgHaLI&pid=Api&rs=1&p=0'
  ];

  double appBarOpacity = 0;

  _onscroll(offset){
    double alpha = offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if(alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarOpacity = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification){
                if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                  _onscroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imgList.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imgList[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(title: Text('haha'),)
                  )
                ],
              ),
            )
          ),
          Opacity(
            opacity: appBarOpacity,
            child: Container( 
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      )
      
    );
  }
}