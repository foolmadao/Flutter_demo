import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Webview extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
  Webview({Key key, this.backForbid, this.title, this.url, this.hideAppBar, this.statusBarColor}) : super(key: key);

  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChange;
  StreamSubscription<WebViewStateChanged> _onStateChange;
  StreamSubscription<WebViewHttpError> _onHttpErr;

  @override
  void initState() { 
    super.initState();
    webviewReference.close();
    _onUrlChange = webviewReference.onUrlChanged.listen((String url) {

    });
    _onStateChange = webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch(state.type) {
        case WebViewState.startLoad:
          break;
        default:
          break; 
      }
    });
    _onHttpErr = webviewReference.onHttpError.listen((WebViewHttpError err) {
      print(err);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChange.cancel();
    _onStateChange.cancel();
    _onHttpErr.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String stateBarColor = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor = stateBarColor == 'ffffff' ? Colors.black : Colors.white;
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+stateBarColor)), backButtonColor),
          Expanded(child: WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true, 
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Waiting....'
                ),
              ),
            ),
            ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if(widget.hideAppBar??false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}