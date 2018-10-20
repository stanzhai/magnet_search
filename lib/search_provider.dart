import 'dart:convert';
import 'http_util.dart';
import 'search_result.dart';
import 'search_item.dart';

abstract class SearchProvider {
  void getResource(String keyword, int page, Function callback, {Function errorCallbak});
}

class CilimaoProvider extends SearchProvider {

  @override
  void getResource(String keyword, int page, Function callback, {Function errorCallbak}) {
    Map<String, String> params = new Map();
    params["size"] = "10";
    params["word"] = keyword;
    params["resourceSource"] = "0";
    params["sortDirections"] = "desc";
    params["page"] = page.toString();

    HttpUtil.get("https://www.cilimao.me/api/search", (data) {
      if (callback == null) {
        return;
      }
      if (data == null) {
        callback(null);
        return;
      }
      Map jsonResult = json.decode(data.toString())['data']['result'];
      SearchResult result = fromJson(jsonResult);
      callback(result);
    }, params: params, errorCallback: errorCallbak);
  }

  SearchResult fromJson(Map<String, dynamic> json) {
    List<SearchItem> items = new List();
    for (var i in json['content']) {
      try {
        int countSize = i['content_size'];
        String fixedCountSize = byteUnitConvert(countSize);
        String magnetLink = 'magnet:?xt=urn:btih:${i['infohash']}';
        items.add(SearchItem(i['title'], magnetLink, i['created_time'],
            i['file_count'].toString(), fixedCountSize));
      } catch (e) {
        print('$e : data: $i');
      }
    }

    return new SearchResult(json['number_of_elements'], json['total_pages'], json['total_elements'], items);
  }

  String byteUnitConvert(int countSize) {
    var t = 1048576;
    var n = 1073741824;
    return countSize < 1024
        ? '${countSize}b'
        : countSize >= 1024 && countSize < t
        ? (countSize / 1024).toStringAsFixed(2) + "KB"
        : countSize >= t && countSize < n
        ? (countSize / t).toStringAsFixed(2) + "MB"
        : countSize >= n
        ? (countSize / n).toStringAsFixed(2) + "GB"
        : 0;
  }
}