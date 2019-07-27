import 'package:flutter/material.dart';
import '../mock/songlistData.dart';

class SongList extends StatelessWidget {
  const SongList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SongListTitle(),
        Container(
          height: 280,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(), //去除滑动
            itemBuilder: (BuildContext context, int index) {
              Map listInfo = songListData[index];
              String picUrl = listInfo['picUrl'];
              String playCount = listInfo['playCount'].toString();
              String name = listInfo['name'];
              return SongListRadiusImg(picUrl, name, playCount);
            },
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0,
            ),
          ),
        )
      ],
    );
  }
}

class SongListRadiusImg extends StatelessWidget {
  final String picUrl;
  final String playCount;
  final String name;

  SongListRadiusImg(this.picUrl, this.name, this.playCount, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                  child: Image.network(
                    picUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 10.0,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_circle_outline,
                          size: 12.0,
                          color: Colors.white,
                        ),
                        Text(
                          playCount.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 2.0, 0, 0),
              child: Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11.0,
                    height: 0.8,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongListTitle extends StatelessWidget {
  const SongListTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(color: Colors.red, width: 15.0),
              //       left: BorderSide(color: Colors.red, width: 3.0),
              //     ),
              //   ),
              // ),
              Text(
                '推荐歌单',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          ButtonTheme(
            height: 20.0,
            minWidth: 20.0,
            child: OutlineButton(
              onPressed: () {},
              shape: StadiumBorder(),
              child: Text(
                '歌单广场',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyRect extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.amber //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 15.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(new Rect.fromLTWH(10, 50, 50, 50), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}
