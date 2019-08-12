import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music/pages/home_pages/music_cloud.dart';
import './music_cloud.dart';
import './music_note.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {}),
        title: Container(
          height: ScreenUtil().setHeight(148),
          width: ScreenUtil().setWidth(300),
          child: TabBar(
            controller: _tabController,
            indicator:
                UnderlineTabIndicator(insets: EdgeInsets.only(bottom: 4)),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.music_note)),
              Tab(icon: Icon(Icons.cloud))
            ],
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MusicCloud(),
          MusicNote(),
        ],
      ),
    );
  }
}
