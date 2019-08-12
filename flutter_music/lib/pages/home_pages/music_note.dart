import 'package:flutter/material.dart';

class MusicNote extends StatefulWidget {
  MusicNote({Key key}) : super(key: key);

  _MusicNoteState createState() => _MusicNoteState();
}

class _MusicNoteState extends State<MusicNote>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[_PinnedHeader()],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _PinnedHeader extends StatelessWidget {
  const _PinnedHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DividerWrapper(
            child: ListTile(
              leading: Icon(
                Icons.schedule,
                color: Colors.red,
              ),
              title: Text('播放记录'),
            ),
          ),
          DividerWrapper(
            child: ListTile(
              leading: Icon(
                Icons.cast,
                color: Colors.red,
              ),
              title: Text('我的电台'),
            ),
          ),
          DividerWrapper(
            child: ListTile(
              leading: Icon(
                Icons.library_music,
                color: Colors.red,
              ),
              title: Text('我的收藏'),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWrapper extends StatelessWidget {
  DividerWrapper({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          child,
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 10.0,
            indent: 10.0,
          )
        ],
      ),
    );
  }
}
