
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../hive_boxes.dart';

class AuthApiService {
  // final String userUrl = "/auth/users/";
  final String loginUrl = "/token/";
  final String refreshUrl = "/token/refresh/";

  final Dio dio = GetIt.instance.get<Dio>();

  // Future<Response> createUser({String username, String email, String password}) async {
  //   try {
  //     var resp = await dio.post(userUrl, data: {"username": username, "email": email, "password": password});
  //     var data = Map<String, dynamic>.from(resp.data);
  //     return await login(username: data['username'], password: password);
  //   } on DioError catch (e) {
  //     return e.response;
  //   }
  // }

  Future<Response> login({String email, String password}) async {
    try {
      var login = {"email": email, "password": password};
      var resp = await dio.post(loginUrl, data: login);
      var data = Map<String,String>.from(resp.data);
      for(String key in data.keys) {
        GetIt.instance.get<HiveBoxes>().settings.put(key, data[key]);
      }
      return resp;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> refreshAccessToken() async {
    try{
      String token = await GetIt.instance.get<HiveBoxes>().settings.get('refresh');
      if (token == null) return null;//Checks for null in Landing page - otherwise token should not be null.
      Response resp = await dio.post(refreshUrl, data: {
        'refresh': token,
      });
      GetIt.instance.get<HiveBoxes>().settings.put('access', resp.data['access']);
      GetIt.instance.get<HiveBoxes>().settings.put('refresh', resp.data['refresh']);
      return resp;
    } on DioError catch (e){
      return e.response;
    }
  }

  Future<bool> checkForRefresh(DioError e) async {
    if(e.response?.statusCode == 401) {
      Response response = await refreshAccessToken();
      if(response.statusCode == 200) return true;
    }
    return false;
  }
}
