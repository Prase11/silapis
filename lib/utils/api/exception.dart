import 'dart:io';
import 'package:dio/dio.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/configs/config.dart';

const String ErrorInternalTitle = 'Server Error';
const String ErrorApplicationTitle = 'Aplikasi Error';
const String ErrorFormat = 'Format Server Tidak Valid';
const String ErrorHttp =
    'Tidak terhubung ke jaringan, coba hidupkan internet / wifi anda';
const String Error404 = 'Halaman Tidak Ditemukan';
const String Error500 = 'Server Error 500';
const String Error401 = 'redirect';
const String ErrorSocket =
    'Tidak terhubung ke jaringan, coba hidupkan internet / wifi anda';

const String Warning = 'assets/svg/warning.svg';

class MyException {
  static ApiModel getException(DioError e) {
    UtilLogger.log('EXCEPTION ERROR', e.error.runtimeType);
    switch (e.error.runtimeType) {
      case SocketException:
        {
          return ApiModel.fromJson({
            'code': 500,
            "message": <String, dynamic>{
              'title': ErrorApplicationTitle,
              'content': ErrorSocket,
              "image": Images.Monitor
            },
          });
        }
        break;

      case FormatException:
        {
          return ApiModel.fromJson({
            'code': 500,
            "message": <String, dynamic>{
              'title': ErrorApplicationTitle,
              'content': ErrorFormat,
              "image": Images.LocationSearch
            },
          });
        }
        break;

      case HttpException:
        {
          return ApiModel.fromJson({
            'code': 500,
            "message": <String, dynamic>{
              'title': ErrorApplicationTitle,
              'content': ErrorHttp,
              "image": Images.Monitor
            },
          });
        }
        break;

      default:
        {
          if (e.response == null) {
            return ApiModel.fromJson({
              'code': 500,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': e.message.toString(),
                "image": Images.ServerStatus
              },
            });
          } else if (e.response.statusCode == 500) {
            return ApiModel.fromJson({
              'code': 500,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': e.response.data.isEmpty
                    ? e.message
                    : e.response.data['message'],
                "image": Images.BugFixing
              },
            });
          } else if (e.response.statusCode == 401) {
            return ApiModel.fromJson({
              'code': 401,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': Error401,
                "image": Images.BugFixing
              },
            });
          } else if (e.response.statusCode == 403) {
            return ApiModel.fromJson({
              'code': 401,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': Error401,
                "image": Images.BugFixing
              },
            });
          } else if (e.response.statusCode == 404) {
            return ApiModel.fromJson({
              'code': 404,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': Error404,
                "image": Images.PageNotFound
              },
            });
          } else {
            return ApiModel.fromJson({
              'code': 500,
              "message": <String, dynamic>{
                'title': ErrorInternalTitle,
                'content': e.message.toString(),
                "image": Images.ServerStatus
              },
            });
          }
        }
        break;
    }
  }
}
