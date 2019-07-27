// import 'dart:io';
// import 'dart:convert';//网络请求使用的模块

import 'package:flutter/material.dart';
import './banner.dart';
import './songlist.dart';
import './newsongtab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _selectIndex(int index) => setState(() => _currentIndex = index);

  List<BottomNavigationBarItem> _navigatorbarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.music_note),
      title: Text('发现'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.music_video),
      title: Text('视频'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.music_note),
      title: Text('我的'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text('朋友'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('账号'),
    )
  ];

  Widget _searchBar() => Container(
        width: 300.0,
        margin: EdgeInsets.all(13.0),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.amber, //边线颜色为黄色
                width: 1,
              ),
            ),
            // disabledBorder: InputBorder.none,
            // enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.grey, //边线颜色为黄色
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.mic,
            color: Colors.black38,
          ),
          title: _searchBar(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
          ],
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.red,
          currentIndex: _currentIndex,
          items: _navigatorbarItem,
          onTap: _selectIndex,
        ),
        body: HomePageBody());
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[HomePageBanner(), SongList(), NewSongTab()],
            ),
          ),
        );
      },
    );
  }
}

// Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[HomePageBanner(), SongList()],
//         ),
//       ),
