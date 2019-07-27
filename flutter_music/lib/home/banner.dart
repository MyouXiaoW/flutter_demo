import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../mock//bannerData.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 30.0),
      height: 160,
      child: Swiper(
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
      ),
    );
  }
}
