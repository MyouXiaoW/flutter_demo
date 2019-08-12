import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/api.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MusicCloud extends StatefulWidget {
  MusicCloud({Key key}) : super(key: key);

  _MusicCloudState createState() => _MusicCloudState();
}

class _MusicCloudState extends State<MusicCloud>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _Banner(),
        _NavigationLine(),
        _SongPlayList(),
        _SectionNewSongs()
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _Banner extends StatelessWidget {
  _Banner({Key key}) : super(key: key);

  final Future _banner = getBanner();

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 30.0),
      height: ScreenUtil().setHeight(280),
      child: FutureBuilder(
        future: _banner,
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List bannerData = snapshot.data['banners'];

            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ClipRRect(
                    child: Image.network(
                      bannerData[index]['imageUrl'],
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              },
              itemCount: bannerData.length,
            );
          }
          if (snapshot.hasError) {
            return Text('网络出现问题');
          }
          return Text('this is banner ');
        },
      ),
    );
  }
}

class _NavigationLine extends StatelessWidget {
  const _NavigationLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _ItemNavigator(Icons.radio, "私人FM", () {}),
        _ItemNavigator(Icons.today, "每日推荐", () {}),
        _ItemNavigator(Icons.show_chart, "排行榜", () {}),
      ],
    );
  }
}

class _ItemNavigator extends StatelessWidget {
  final _icon;
  final _text;
  final _onTap;

  const _ItemNavigator(this._icon, this._text, this._onTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 40.0,
                height: 40.0,
                child: Icon(
                  _icon,
                  color: Colors.white,
                ),
                color: Colors.red,
              ),
            ),
            Text(_text)
          ],
        ));
  }
}

class _SongPlayList extends StatefulWidget {
  _SongPlayList({Key key}) : super(key: key);

  __SongPlayListState createState() => __SongPlayListState();
}

class __SongPlayListState extends State<_SongPlayList> {
  Future _songList;

  @override
  void initState() {
    super.initState();
    _songList = getSongList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            _SectionTitle('推荐歌单'),
            FutureBuilder(
              future: _songList,
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List _songPlaylist = snapshot.data['result'];
                    _songPlaylist.length = 6;

                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 10 / 12,
                      children: _songPlaylist.map((v) {
                        return _buildPlaylistItem(
                            context, v['name'], v['picUrl']);
                      }).toList(),
                    );
                  }
                }

                return Container(
                  child: Text('no pic'),
                );
              },
            ),
          ],
        ));
  }

  Widget _buildPlaylistItem(
      BuildContext context, String name, String imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: AspectRatio(
              aspectRatio: 1.0,
              // child: FadeInImage(
              //   placeholder: AssetImage("assets/playlist_playlist.9.png"),
              //   image: NetworkImage(imageUrl),
              //   fit: BoxFit.cover,
              // ),
              child: Image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  _SectionTitle(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[Text(title), Icon(Icons.chevron_right)],
      ),
    );
  }
}

class _SectionNewSongs extends StatelessWidget {
  _SectionNewSongs({Key key}) : super(key: key);

  final Future _topSong = getTopSong({"type": 96});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Column(
        children: <Widget>[
          _SectionTitle('最新音乐'),
          FutureBuilder(
            future: _topSong,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List _newSongsList = snapshot.data['data'];
                _newSongsList.length = 5;
                return Column(
                  children: _newSongsList.map((v) {
                    return _buildNewSongsItem(
                        context,
                        v['name'],
                        v['artists'][0]['name'],
                        v['album']['picUrl'],
                        'ssssadasd');
                  }).toList(),
                );
              }
              return Text('no new songs');
            },
          )
        ],
      ),
    );
  }

  Widget _buildNewSongsItem(
      BuildContext context, String name, String songer, String picUrl,
      [String alias]) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(100),
            padding: EdgeInsets.only(top: 10.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: FadeInImage(
                image: NetworkImage(picUrl),
                placeholder: AssetImage("assets/playlist_playlist.9.png"),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: 200.0,
                child: Text(
                  songer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
// const createPetAssetMap = async (petname, assetname) => {
//   let asset = {};
//   const fs = await require('fs');
//   console.log(window.__PUBLIC_URL__);
//   // console.log(fs);
//   let appDirectory = fs.realpathSync(process.cwd());

//   console.log(appDirectory);

//   for (let i = 1; i <= 3; i++) {
//     let spinePath = `Assets/spine/pets/${petname}/${petname}_${4 -
//       i}/${petname}_${4 - i}.json`;
//     let spritePath = `Assets/texture/pet/pets/${petname}/${petname}_${i}.png.meta?subMeta=${petname}_${i}`;

//     asset[petname + `_${i}`] = require(assetname === 'sprite'
//       ? spritePath
//       : spinePath);
//   }

//   console.log(asset);
//   return asset;
// };

// let a = Reflect.ownKeys(Pet_map).reduce((res, v) => {
//   console.log(createPetAssetMap(Pet_map[v], 'spine'));
//   // return Object.assign(res, createPetAssetMap(Pet_map[v], 'spine'));
// }, {});

// console.log(a);
