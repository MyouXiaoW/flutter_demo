import 'dart:convert';
import 'dart:io';

class Request {
  String baseUrl = 'http://localhost:9000';
}

// void _getBanber() async {
//   String url = 'http://localhost:9000/banner';
//   var httpClient = new HttpClient();

//   List result;

//   var request = await httpClient.getUrl(Uri.parse(url));
//   var response = await request.close();
//   if (response.statusCode == HttpStatus.OK) {
//     var json = await response.transform(utf8.decoder).join();
//     var data = jsonDecode(json);
//     result = data['banners'];
//     print(result);
//   }
// }
