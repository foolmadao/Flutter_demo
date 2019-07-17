import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/sale_box_model.dart';
import 'package:flutter_demo/widget/webview.dart';

class SaleBox extends StatelessWidget {

  final SaleBoxModel salesBox;

  
  const SaleBox({Key key, @required this.salesBox}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context)
    );
  }

  _items(BuildContext context) {
    if(salesBox == null) return null;
    List<Widget> items = [];

    items.add(_doubleItems(context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItems(context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItems(context, salesBox.smallCard3, salesBox.smallCard4, false, true));

    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(salesBox.icon, height: 15, fit: BoxFit.fill,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          Webview(url: salesBox.moreUrl, title: '更多活动',)
                      )
                    );
                  },
                  child: Text('获取更多福利 >', style: TextStyle(color: Colors.white, fontSize: 12),),
                ),
              )
            ],
          ),
        ),
        Column(
          children: items,
        )
      ],
    );
  }

  Widget _doubleItems(BuildContext context, CommonModel leftCard, CommonModel rightCard, bool bigCard, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftCard, true, last, bigCard),
        _item(context, rightCard, false, last, bigCard)
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool left, bool last, bool isBig) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return  GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Webview(url: model.url, statusBarColor: model.stateBarColor, hideAppBar: model.hideAppBar))
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? borderSide : BorderSide.none,
          )
        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width/2 - 5,
          height: isBig ? 129 : 80,
        ),
      )
    );
  }

}