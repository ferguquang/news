import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/response/response_new.dart';

class APIClient {
  static APIClient? _instance;

  Dio? _dio;

  static APIClient? get instance {
    if (_instance == null) {
      _instance = APIClient();
    }
    return _instance;
  }

  APIClient() {
    _dio = Dio();
    _dio?.options.baseUrl = "https://newsapi.org/v2/";
    _dio?.options.connectTimeout = 5000; //5s
    _dio?.options.receiveTimeout = 3000;
    _dio?.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<dynamic> get() async {
    Map<String, dynamic> params = Map();
    params["apiKey"] = "d49ebfb0f18c4635adbc215cf70eead8";
    params["country"] = "us";
    var responseJson;
    Response response = await _dio!.get("top-headlines", queryParameters: params);
    responseJson = json.decode(response.toString());
    RepsonseNew repsonseNew = RepsonseNew.fromJson(responseJson);
    Fluttertoast.showToast(
        msg: "${repsonseNew.status} ${repsonseNew.totalResults}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return responseJson;
  }

  Future<dynamic> postFormData() async {
    Map<String, dynamic> params = Map();
    params["Username"] = "quang.ngoduc@cybereye.vn";
    params["Password"] = "123456";
    var responseJson;
    FormData formData = new FormData.fromMap(params);
    var response = await _dio!.post("http://api-gateway.lione.vn/api/account/login", data: formData);
    responseJson = json.decode(response.toString());
    Fluttertoast.showToast(
        msg: "${responseJson.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return responseJson;
  }
}