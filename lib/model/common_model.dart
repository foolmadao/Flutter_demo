
class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String stateBarColor;
  final bool hideAppBar;

  CommonModel({this.icon, this.hideAppBar, this.stateBarColor, this.title, this.url});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      hideAppBar: json['hideAppBar'],
      stateBarColor: json['stateBarColor'],
      title: json['title'],
      url: json['url']
    );
  }
}