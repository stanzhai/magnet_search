import 'dart:convert';
import 'package:flutter/material.dart';
import 'http_util.dart';
import 'search_result.dart';
import 'search_provider.dart';
import 'search_item.dart';
import 'search_result_widget.dart';
import 'global_config.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SearchResultWidget> tabViews = [
    new SearchResultWidget(new CilimaoProvider()),
    new SearchResultWidget(new CilimaoProvider()),
  ];

  bool firstLoad = true;
  bool searching = false;

  void _search(String text) {
    tabViews[0].getResult(text);
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: _buildSearchInput(),
            bottom: new TabBar(
              labelColor: GlobalConfig.dark == true ? new Color(0xFF63FDD9) : Colors.blue,
              unselectedLabelColor: GlobalConfig.dark == true ? Colors.white : Colors.black,
              tabs: [
                new Tab(text: "磁力猫"),
                new Tab(text: "BTSOW"),
              ],
            ),
          ),
          body: new TabBarView(
              children: tabViews
          ),
        )
    );
  }

  Widget _buildSearchInput() {
    Widget searchIcon = new Container(
      child: new Icon(Icons.search, color: GlobalConfig.fontColor, size: 18.0),
      width: 30.0,
      height: 30.0,
    );

    Widget searchTextField = new TextField(
      onSubmitted: _search,
      decoration: new InputDecoration.collapsed(
          hintText: "搜索",
          hintStyle: new TextStyle(color: GlobalConfig.fontColor)
      ),
    );

    return new Container(
      child: new Row(
        children: <Widget>[
          searchIcon,
          new Expanded(child: searchTextField)
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: GlobalConfig.searchBackgroundColor
      ),
    );
  }
}
