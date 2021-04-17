import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/models/server_error.dart';
import 'api.dart';

class HttpApi implements Api {
  Future<Either<ServerError, dynamic>> request(String endPoint,
      {body,
      BuildContext context,
      String serverPath = 'https://jsonplaceholder.typicode.com/',
      Function onSendProgress,
      Map<String, dynamic> headers,
      String type = RequestType.Get,
      Map<String, dynamic> queryParameters,
      String contentType = Headers.jsonContentType,
      bool retry = false,
      ResponseType responseType = ResponseType.json}) async {
    Response response;

    final dio = Dio(BaseOptions(
        baseUrl: serverPath, connectTimeout: 60000, receiveTimeout: 60000));

    final options = Options(
        headers: headers, contentType: contentType, responseType: responseType);

    if (onSendProgress == null) {
      onSendProgress = (int sent, int total) {
        print('$endPoint\n sent: $sent total: $total\n');
      };
    }

    try {
      switch (type) {
        case RequestType.Get:
          {
            response = await dio.get(serverPath + endPoint,
                queryParameters: queryParameters, options: options);
          }
          break;
        case RequestType.Post:
          {
            response = await dio.post(serverPath + endPoint,
                queryParameters: queryParameters,
                onSendProgress: onSendProgress,
                data: body,
                options: options);
          }
          break;
        case RequestType.Put:
          {
            response = await dio.put(endPoint,
                queryParameters: queryParameters, data: body, options: options);
          }
          break;
        case RequestType.Delete:
          {
            response = await dio.delete(endPoint,
                queryParameters: queryParameters, data: body, options: options);
          }
          break;
        default:
          break;
      }

      print('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data); //map of string dynamic...
      } else {
        return Left(ServerError(response.data['message']));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response.statusCode == 401 && !retry && context != null) {
          // sending Refresh token
          Logger().w('Try to send refresh token');
          await refreshToken(context);
          return await request(endPoint,
              body: body,
              queryParameters: queryParameters,
              headers: Header.userAuth,
              context: context,
              type: type,
              contentType: contentType,
              responseType: responseType,
              retry: true);
        } else if (e.response.statusCode == 401 && retry && context != null) {
          Logger().w("Checking session expired");
          await checkSessionExpired(context: context, response: e.response);
        }
      } else {
        return Left(ServerError(e.message));
      }
      return Left(ServerError(e.response.statusMessage));
    }
  }

  checkSessionExpired({Response response, BuildContext context}) async {
    if (context != null &&
        (response.statusCode == 401 || response.statusCode == 500)) {
      final expiredMsg = response.data['message'];
      final authExpired = expiredMsg != null && expiredMsg == 'Unauthorized';

      if (authExpired) {
        // await AuthenticationService.handleAuthExpired(context: context);
      }
      return true;
    }
  }

  Future<bool> refreshToken(BuildContext context) async {
    // String email = Provider.of<AuthenticationService>(context, listen: false)
    //     .user
    //     .user
    //     .email;

    // String oldToken =
    //     Provider.of<AuthenticationService>(context, listen: false).user.token;

    // final body = {"oldtoken": oldToken, "email": email};
    // print(body);
    // var tokenResponse;
    // tokenResponse = await request(EndPoint.REFRESH_TOKEN,
    //     type: RequestType.Put,
    //     body: body,
    //     headers: Header.clientAuth,
    //     context: context);

    // print(tokenResponse);

    // User user;

    // if (tokenResponse != null && tokenResponse['token'] != null) {
    //   user = User.fromJson(tokenResponse);
    //   Provider.of<AuthenticationService>(context, listen: false)
    //       .saveUser(user: user);
    // }

    // final token = tokenResponse["token"];

    // final tokenRefreshed = token != null;

    // if (tokenRefreshed) {
    //   await Preference.setString(PrefKeys.token, token);
    // }
    // return tokenRefreshed;
    return true;
  }

  // Future<Either<ServerError, dynamic>> getUserPosts() async {
  //   final res = await request(EndPoint.TODO, serverPath: "http://server.overrideeg.net:3002/v1/");
  //   return res;
  // }

  Future<Either<ServerError, dynamic>> getUserPosts() async {
    final res = await request(EndPoint.POST, type: RequestType.Get);
    return res;
  }

  //401
  Future<Either<ServerError, dynamic>> getError401() async {
    final res = await request("xsddddd",
        serverPath: "https://wendux.github.io/", type: RequestType.Get);
    return res;
  }

  //404
  Future<Either<ServerError, dynamic>> getError404() async {
    final res = await request("v1/Invoice/all",
        serverPath: "https://beauty.remabackend.com/", type: RequestType.Get);
    return res;
  }

  @override
  Future<List<Comment>> getCommentsForPost(int postId) async {
    await request(EndPoint.COMMENT);

    return null;
  }

  @override
  Future<List<Post>> getPostsForUser(int userId) async {
    await request(EndPoint.COMMENT);

    return null;
  }

  @override
  Future<User> getUser(int userId) async {
    await request(EndPoint.COMMENT);
    return null;
  }

  @override
  Future<LoginResponse> login({String username, String password}) async {
    await request(EndPoint.COMMENT);
    return LoginResponse(success: false, message: 'Username not found');
  }
}

//   Future<User> registerUser({@required User user}) async {
//     final response = await request(EndPoint.REGISTER, type: RequestType.Post, body: user.toJson());
//     return response != null ? User.fromJson(response) : null;
//   }

//   Future<String> refreshToken({@required String username, String password}) async {
//     print(username + " " + password);
//     try {
//       final body = {'username': username, 'password': password, 'grant_type': 'password'};
//       final response = await request(EndPoint.TOKEN, type: RequestType.Post, headers: Header.clientAuth, contentType: Headers.formUrlEncodedContentType, body: body);
//       return response != null ? response['access_token'] : null;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<String> uploadImage({@required File image}) async {
//     final formData = FormData.fromMap({'file': await MultipartFile.fromFile(image.path, filename: 'image.png')});
//     final response = await request('upload', type: RequestType.Post, contentType: Headers.contentTypeHeader, body: formData);
//     return response['fileURL'] ?? null;
//   }

//   Future<User> getUser({@required int id}) async {
//     final response = await request(EndPoint.USER + '/$id');

//     return response != null ? User.fromJson(response) : null;
//   }
