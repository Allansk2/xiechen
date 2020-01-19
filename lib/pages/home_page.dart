import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiechen/dao/home_dao.dart';
import 'package:xiechen/model/common_model.dart';
import 'package:xiechen/model/grid_nav_model.dart';
import 'package:xiechen/model/home_model.dart';
import 'package:xiechen/widget/grid_nav.dart';
import 'package:xiechen/widget/local_nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> localNavList;
  GridNavModel gridNavModel;

  HomeModel model;

  static const APPBAR_SCROLL_OFFSET = 200;

  double appBarAlpha = 0;

  String resultString = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

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

  loadData() async {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        this.model = model;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
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
                            itemCount:
                                model != null ? model.bannerList.length : 0,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(model.bannerList[index].icon,
                                  fit: BoxFit.cover,
                                  alignment: AlignmentDirectional.bottomEnd);
                            },
                            pagination: SwiperPagination(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                          child: LocalNav(localNavList: localNavList),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: GridNav(gridNavModel: gridNavModel),
                        ),
                        Container(
                          height: 1800,
                          child: ListTile(title: Text(resultString)),
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
