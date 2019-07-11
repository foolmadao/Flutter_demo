import 'package:flutter_demo/model/common_model.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel({
    this.flight, this.hotel, this.travel
  });

  factory GridNavModel.formJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItem.fromJson(json['hotel']),
      flight: GridNavItem.fromJson(json['flight']),
      travel: GridNavItem.fromJson(json['travel'])
    );
  }

}

class GridNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(
    {this.endColor, this.item1, this.item2, this.item3, this.item4, this.mainItem, this.startColor}
  );

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      endColor: json['endColor'],
      startColor: json['startColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4'])
    );
  }


}