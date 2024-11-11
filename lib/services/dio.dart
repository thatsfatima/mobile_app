import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = "http://localhost:8000/api";
  //dio.options.baseUrl = "http://10.0.0.2:8000/api";
  dio.options.headers['accept'] = 'Application/json';

  return dio;
}