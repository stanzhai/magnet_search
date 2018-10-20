import 'package:flutter/material.dart';
import 'search_provider.dart';
import 'search_item.dart';
import 'search_result.dart';
import 'search_item_widget.dart';
import 'global_config.dart';

class SearchResultWidget extends StatefulWidget {
  final SearchProvider searchProvider;
  final _SearchResultState state = new _SearchResultState();

  SearchResultWidget(this.searchProvider);

  void getResult(String keyword) {
    state.search(keyword);
  }

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _SearchResultState extends State<SearchResultWidget> {
  String _keyword = "";
  int _totalCount = 0;
  int _currentPage = 0;
  List<SearchItem> items = new List();

  bool _firstLoad = true;
  bool _searching = false;

  void search(String keyword) {
    _keyword = keyword;
    _firstLoad = false;
    _searching = true;
    items.clear();
    setState(() {});

    widget.searchProvider.getResource(keyword, 0, (SearchResult result) {
      _searching = false;
      if (result == null) {
        return;
      }
      _totalCount = result.totalCount;
      _currentPage = 0;
      items = result.items;
      setState(() {});
    });
  }

  void _loadNextPage() {
    widget.searchProvider.getResource(_keyword, _currentPage + 1, (SearchResult result) {
      if (result == null) {
        return;
      }
      _totalCount = result.totalCount;
      _currentPage += 1;
      items.addAll(result.items);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(index);
      }
    );
  }

  Widget _buildListItem(int index) {
    int searchItemCount = items.length;

    if (_firstLoad) {
      return new Text('请输入关键字进行搜索');
    }

    // 使用文本框进行搜索
    if (searchItemCount == 0 && _searching) {
      return _buildLoading();
    }

    if (index < searchItemCount) {
      return new SearchItemWidget(items[index]);
    }

    if (_totalCount == searchItemCount) {
      return new Text('加载完毕 (共 $searchItemCount 条结果)！',
          textAlign: TextAlign.center);
    }

    _loadNextPage();
    return _buildLoading();
  }

  Widget _buildLoading() {
    return new Center(
      child: new Container(
          alignment: Alignment.center,
          child: new CircularProgressIndicator(value: null, valueColor: AlwaysStoppedAnimation(GlobalConfig.searchBackgroundColor))
      ),
    );
  }
}