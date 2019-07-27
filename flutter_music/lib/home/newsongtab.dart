import 'package:flutter/material.dart';
import '../mock/newdishData.dart';

class NewSongTab extends StatefulWidget {
  NewSongTab({Key key}) : super(key: key);

  _NewSongTabState createState() => _NewSongTabState();
}

class _NewSongTabState extends State<NewSongTab> {
  int _selectTab = 0;

  List _getNewSongList() {
    List<Widget> items = <Widget>[];
    for (int i = 0; i < 3; i++) {
      items.add(
        Expanded(
          child: NewSongItem(newdishData[i]['picUrl'], newdishData[i]['name'],
              newdishData[i]['artist']['name']),
          flex: 1,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectTab = 0;
                      });
                    },
                    child: SizedBox(
                      width: 35.0,
                      child: Text(
                        '新碟',
                        style: TextStyle(
                          fontSize: _selectTab == 0 ? 16.0 : 14.0,
                          fontWeight: FontWeight.w400,
                          color: _selectTab == 0 ? Colors.black : Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        top: BorderSide(width: 12.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectTab = 1;
                        });
                      },
                      child: SizedBox(
                        width: 35.0,
                        child: Text(
                          '新歌',
                          style: TextStyle(
                            fontSize: _selectTab != 0 ? 16.0 : 14.0,
                            fontWeight: FontWeight.w400,
                            color: _selectTab != 0 ? Colors.black : Colors.grey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
                ],
              ),
              ButtonTheme(
                height: 20.0,
                minWidth: 20.0,
                child: OutlineButton(
                  onPressed: () {},
                  shape: StadiumBorder(),
                  child: Text(
                    _selectTab == 0 ? '更多新碟' : '新歌推荐',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(children: _getNewSongList())
      ],
    );
  }
}

class NewSongItem extends StatelessWidget {
  final String _picUrl;
  final String _name;
  final String _artist;
  NewSongItem(this._picUrl, this._name, this._artist, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      height: 150.0,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            child: Image.network(
              _picUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            child: Text(
              _name,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10.0,
                height: 0.8,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
            height: 10.0,
            width: 100.0,
          ),
          SizedBox(
            height: 10.0,
            width: 100.0,
            child: Text(
              _artist,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10.0,
                height: 0.8,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
