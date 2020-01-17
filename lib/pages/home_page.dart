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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            itemCount: _imageUrls.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(_imageUrls[index], fit: BoxFit.fitWidth);
            },
            pagination: SwiperPagination(),
          ),
        )
      ],
    )));
  }
}
