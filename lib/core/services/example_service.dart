import 'package:dio/dio.dart';

class ExampleService {

  final dio = Dio();

  ///Singleton factory
  static final ExampleService _instance = ExampleService._internal();

  factory ExampleService() {
    return _instance;
  }

  ExampleService._internal();
}
