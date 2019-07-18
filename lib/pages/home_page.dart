import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/home_dao.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/grid_nav_model.dart';
import 'package:flutter_demo/model/home_model.dart';
import 'package:flutter_demo/model/sale_box_model.dart';
import 'package:flutter_demo/widget/grid_nav.dart';
import 'package:flutter_demo/widget/loading_container.dart';
import 'package:flutter_demo/widget/local_nav.dart';
import 'package:flutter_demo/widget/sale_box.dart';
import 'package:flutter_demo/widget/sub_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List<CommonModel> bannerList = [];

  double appBarOpacity = 0;
  HomeModel model;
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList;
  SaleBoxModel saleBox;
  bool _loading = true;
  bool _cover = false;

  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<Null> loadData() async {
    try {
      model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList   = model.subNavList;
        saleBox      = model.saleBox; 
        bannerList   = model.bannerList;
        _loading     = false;
      });
    } catch (e) {
      print(e);
      _loading = false;
    }
    return null;
    
  }

  _onscroll(offset){
    loadData();
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

  Future<Null> _handleRefresh() async {
    _loading = true;
    _cover   = true;

    try {
      model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList   = model.subNavList;
        saleBox      = model.saleBox; 
        bannerList   = model.bannerList;
        _loading     = false;
        _cover    = false;
      });
    } catch (e) {
      print(e);
      _loading = false;
      _cover    = false;
    }
    return null; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        cover: _cover,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
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
                          itemCount: bannerList.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              bannerList[index].icon,
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        child: LocalNav(localNavList: localNavList),
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4)
                      ),
                      GridNav(gridNavModel: gridNavModel),
                      SubNav(subNavList: subNavList),
                      SaleBox(salesBox: saleBox)
                    ],
                  ),
                ),
              ),
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
        ),
      )
      
    );
  }
}