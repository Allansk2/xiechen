import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    "http://personal.psu.edu/xqz5228/jpg.jpg",
    "https://previews.123rf.com/images/evryka23/evryka231207/evryka23120700021/14405918-blue-background-with-butterfly.jpg",
    "https://i.kym-cdn.com/photos/images/original/001/468/202/b02.jpg"
  ];

  static const APPBAR_SCROLL_OFFSET = 200;

  double appBarAlpha = 0;

  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
    print("alpha=$alpha");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(_imageUrls[index],
                              fit: BoxFit.fitWidth);
                        },
                        pagination: SwiperPagination(),
                      ),
                    ),
                    Container(
                      height: 1800,
                      child: ListTile(title: Text("haha")),
                    )
                  ],
                ))),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              )),
        ),
      ],
    ));
  }
}
