import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/widget/webview.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  
  const LocalNav({Key key, @required this.localNavList}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6)
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if(localNavList == null) return null;
    List<Widget> items = [];

    localNavList.forEach((model) {
      items.add(_item(context, model));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Webview(url: model.url, statusBarColor: model.stateBarColor, hideAppBar: model.hideAppBar,))
          );
        },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              width: 32,
              height: 32,
            ),
            Text(
              model.title,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );
    }

}