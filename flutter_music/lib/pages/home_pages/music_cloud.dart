import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/api.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class MusicCloud extends StatelessWidget {
  const MusicCloud({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[_Banner(), _NavigationLine()],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 30.0),
      height: ScreenUtil().setHeight(240),
      child: FutureBuilder(
        future: getBanner(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List bannerData = json.decode(snapshot.data.toString())['banners'];

          if (snapshot.hasData) {
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
