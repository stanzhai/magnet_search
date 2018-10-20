import 'search_item.dart';

class SearchResult {
  final int itemCount;
  final int pages;
  final int totalCount;
  List<SearchItem> items;

  SearchResult(this.itemCount, this.pages, this.totalCount, this.items);
}
