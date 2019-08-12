import 'dart:io';
import 'package:dio/dio.dart';
import './service_url.dart';
import 'dart:convert';

Future request(String method, String url, [Map params]) async {
  Dio dio = Dio();
  Response response;
  dio.options.contentType =
      ContentType.parse('application/x-www-form-urlencoded');
  String path = service_url + url;
  switch (method) {
    case ('GET'):
      response = await dio.get(path, queryParameters: params);
      break;
    case ('POST'):
      response = await dio.post(path, data: params);
      break;
  }
  return json.decode(response.toString());
}

requestCreator(String method) {
  return (String url) {
    return ([Map params]) {
      return request(method, url, params);
    };
  };
}

final Function methodGet = requestCreator('GET');
final Function methodPost = requestCreator('POST');
