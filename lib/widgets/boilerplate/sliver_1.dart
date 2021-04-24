import 'package:flutter/material.dart';

class Sliver1 extends StatefulWidget {
  Sliver1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Sliver1State createState() => _Sliver1State();
}

class _Sliver1State extends State<Sliver1> {
  //Variables needed to adapt FlexibleSpaceBar text color (title)
  ScrollController _scrollController;
  bool lastStatus = true;
  double height = 100;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: BackButton(),
              expandedHeight: height,
              brightness: Theme.of(context).brightness,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xff303030)
                  : Colors.white,
              floating: true,
              pinned: true,
              elevation: 2,
              actionsIconTheme: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xff303030)
                      : Colors.white),
              iconTheme: IconThemeData(
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xff303030)
                    : Colors.white, //change your color here
              ),
              shadowColor: Colors.grey[50],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            width: 30,
                            height: 30,
                            color: Colors.yellow),
                        Text(
                          'A little long title',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff303030)
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              child: Text(index.toString()),
            );
          },
        ),
      ),
    );
  }
}
