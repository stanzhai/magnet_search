import 'package:flutter/material.dart';
import 'search_provider.dart';
import 'search_result_widget.dart';
import 'global_config.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, SearchProvider> _providers = {
    "磁力猫" : new CilimaoProvider(),
    "mao" : new CilimaoProvider(),
  };
  String _currentProvider = "磁力猫";
  String _keyword;

  SearchResultWidget _searchResultWidget = new SearchResultWidget();

  void _search(String text) {
    _keyword = text;
    _searchResultWidget.getResult(_providers[_currentProvider], text);
  }

  void _changeProvider(String providerName) {
    setState(() {
      _currentProvider = providerName;
    });
    _searchResultWidget.getResult(_providers[_currentProvider], _keyword);
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: _buildSearchBar(),
          ),
          body: _searchResultWidget
        )
    );
  }

  Widget _buildSearchBar() {
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

    Widget split = new Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              start: new BorderSide(color: GlobalConfig.fontColor, width: 1.0)
          )
      ),
      width: 1.0,
      height: 20.0
    );

    Widget changeProviderBtn = new Container(
      child: new PopupMenuButton(
        onSelected: _changeProvider,
        child: new Text(
          _currentProvider,
          style: new TextStyle(color: GlobalConfig.fontColor, fontSize: 14.0),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(value: '磁力猫', child: Text('磁力猫')),
          const PopupMenuItem<String>(value: 'mao', child: Text('mao')),
        ]
      ),
      height: 20.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0)
    );

    return new Container(
      child: new Row(
        children: <Widget>[
          searchIcon,
          new Expanded(child: searchTextField),
          split,
          changeProviderBtn
        ],
      ),
      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        color: GlobalConfig.searchBackgroundColor
      ),
      height: 35.0,
    );
  }
}
