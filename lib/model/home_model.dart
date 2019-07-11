import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/config_model.dart';
import 'package:flutter_demo/model/grid_nav_model.dart';
import 'package:flutter_demo/model/sale_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SaleBoxModel saleBox;

  HomeModel({this.config, this.bannerList, this.gridNav, this.localNavList, this.saleBox, this.subNavList});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    var bannerListJson = json['bannerList'] as List;
    var subNavListJson = json['bannerList'] as List;
    return HomeModel(
      localNavList: localNavListJson.map((i) => CommonModel.fromJson(i)).toList(),
      bannerList: bannerListJson.map((i) => CommonModel.fromJson(i)).toList(),
      subNavList: subNavListJson.map((i) => CommonModel.fromJson(i)).toList(),
      config: ConfigModel.formJson(json['config']),
      gridNav: GridNavModel.formJson(json['gridNav']),
      saleBox: SaleBoxModel.fromJson(json['salesBox'])
    );
  }
}