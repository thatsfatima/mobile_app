import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:app_money/models/user.dart';
import 'package:dio/dio.dart';
import 'package:app_money/services/dio.dart';

class Register extends ChangeNotifier {
  bool _isVerified = false;
  String? _errorMessage;
  String? _phone;
  String? _code;
  Map<String, dynamic> client = {};

  bool get signedUp => _isVerified;
  String? get getPhone => _phone;
  String? get errorMessage => _errorMessage;

  void getClient({required Map<String, dynamic> datas}) {
    client = datas;
  }

  void register({required Map datas}) async {
    _errorMessage = null;
    try {
      print(datas);
      Dio.Response response = await dio().post('/register-client', data: datas);
      _phone = datas['phone'];
      _code = datas['password'];
      print(response.data.toString());
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

  void verifyOtp({required Map<String, dynamic> datas}) async {
    _errorMessage = null;
    try {
      print(datas);
      Dio.Response response = await dio().post('/OTP-veriefied', data: datas);
      print(response.toString());
      _isVerified = true;
      this.login({ 'phone': _phone, 'code': _code});
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

  void login(Map<String, dynamic> credentials) async {
      _errorMessage = null;
      try {
        print(credentials);
        Dio.Response response = await dio().post('/login', data: credentials);
        print(response.data.toString());
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

}