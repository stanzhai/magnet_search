import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'search_item.dart';
import 'global_config.dart';

class SearchItemWidget extends StatelessWidget {
  final SearchItem item;
  SearchItemWidget(this.item);

  void _copyMagnetLink(String hashLink) {
    Clipboard.setData(ClipboardData(text: hashLink));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: GlobalConfig.cardBackgroundColor,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      margin: EdgeInsets.only(bottom: 2.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text(
                item.title,
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.3, color: GlobalConfig.dark == true ? Colors.white70 : Colors.black)
            ),
            margin: new EdgeInsets.only(top: 6.0),
            alignment: Alignment.topLeft
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Expanded(child: new Text(
                    '${item.fileCount}文件 · ${item.contentSize} · ${item.createdTime}',
                    style: new TextStyle(height: 1.3, color: GlobalConfig.fontColor)
                )),
                new IconButton(
                    icon: new Icon(Icons.content_copy, color: GlobalConfig.fontColor),
                    iconSize: 14.0,
                    tooltip: '复制磁力链接',
                    onPressed: () {
                      _copyMagnetLink(item.magnetLink);
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("已复制磁力链接", textAlign: TextAlign.center),
                      ));
                    }
                )
              ],
            ),
            alignment: Alignment.topLeft
          )
        ],
      ),
    );
  }
}