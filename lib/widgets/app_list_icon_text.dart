import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:silapis/utils/utils.dart';

class AppListIconText extends StatelessWidget {
  final Function onTap;
  final Widget leading;
  final String content;
  const AppListIconText({Key key, this.content, this.leading, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).cardColor.withOpacity(1)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200], width: 0.2),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100], blurRadius: 1, offset: Offset(2, 2)),
        ],
      ),
      child: Material(
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                leading,
                SizedBox(width: 20),
                Expanded(
                  child: Html(
                      data: content,
                      defaultTextStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                      customTextAlign: (dom.Node node) {
                        return TextAlign.left;
                      },
                      onLinkTap: (url) {
                        launchExternal(url);
                      },
                      customTextStyle: (dom.Node node, TextStyle baseStyle) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                              return baseStyle.merge(TextStyle(height: 1.3));
                          }
                        }
                        return baseStyle;
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
