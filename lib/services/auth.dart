import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:app_money/models/user.dart';
import 'package:dio/dio.dart';
import 'package:app_money/services/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/compte.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _errorMessage;

  User? _user;
  String? _token;
  Compte? _compte;

  bool get authenticated => _isLoggedIn;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  final storage = new FlutterSecureStorage();

  get compte => null;

  void login({required Map credentials}) async {
    _errorMessage = null;
    try {
      print(credentials);
      Dio.Response response = await dio().post('/login', data: credentials);
      print(response.data.toString());

      String token = response.data['access_token'];
      int user_id = response.data['user_id'];
      this.tryToken(token: token, user_id: user_id);
      _isLoggedIn = true;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessage = 'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioErrorType.cancel) {
        _errorMessage = 'Request cancelled.';
      } else {
        _errorMessage = 'Invalid credentials. Please try again.';
      }
      notifyListeners();
    }
  }

  void logout() async {
    try {
      Dio.Response response = await dio().post('/logout',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));

      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void tryToken({String? token, int? user_id}) async {
    if (token == null) {
      return;
    } else {
      try {
        print(token);
        print(user_id);
        Dio.Response response = await dio().get(
          '/getClientInfos/$user_id',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}),
        );
        this._isLoggedIn = true;
        Map<String, dynamic> jsonData = response.data['client']['user'];
        print(jsonData);
        this._user = User.fromJson(jsonData);
        this._token = token;
        this.storeToken(token: token);
        print(this._user);
        notifyListeners();
      } catch (e) {
        print('failed on try token.');
      }
    }
  }

  void cleanUp() async {
    this._user = User(id: 0, firstName: '', lastName: '', email: '', phone: '', roleId: 0, photo: '', createdAt: DateTime.now(), updatedAt: DateTime.now());
    this._isLoggedIn = false;
    this._token = '';
    await storage.delete(key: 'token');
  }

  void storeToken({required String token}) async {
    this.storage.write(key: 'token', value: token);
  }
}