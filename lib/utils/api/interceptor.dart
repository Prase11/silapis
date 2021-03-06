import 'package:dio/dio.dart';
import 'consumer.dart';
import 'multipart_file_extended.dart';
import 'package:http_parser/http_parser.dart';
import '../utils.dart';

class DioLoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final bool withHeader = true;
  final bool withRefreshToken;
  // final JsonEncoder encoder = new JsonEncoder.withIndent('\t');

  DioLoggingInterceptors(this._dio, this.withRefreshToken);

  @override
  Future onRequest(RequestOptions options) async {
    print('\n');
    print(
        "┌ ${UtilLogger.color(" [ Begin Request ] ", ColorsHeader.PURPLE)} ───────────────────────────────────────────────────────────────────────");
    print(
        "| Method : ${UtilLogger.color(options.method != null ? options.method.toUpperCase() : 'METHOD', ColorsHeader.GREEN)}");
    print(
        "| URL : ${UtilLogger.color((options.baseUrl ?? "") + (options.path ?? ""), ColorsHeader.GREEN)}");

    _printHeader(options);

    if (options.queryParameters != null) {
      print("| queryParameters: ");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("| Body: ${options.data.toString()}");
    }

    print(
        "└——————————————————————————————————————————————————————————————————————————${UtilLogger.color(" End Request >>> ", ColorsHeader.PURPLE)}\n\n");

    return options;
  }

  @override
  Future onResponse(Response response) async {
    print('\n');
    print(
        "┌${UtilLogger.color(" [ Begin Response ] ", ColorsHeader.GREEN)} ────────────────────────────────────────────────────────────────────────");
    print(
        "| Status Code : ${UtilLogger.color(response.statusCode.toString(), ColorsHeader.GREEN)}");
    print(
        "| URL : ${UtilLogger.color(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL', ColorsHeader.GREEN)}");
    // _printHeader(response);
    print(
        "|${UtilLogger.color("Response Message", ColorsHeader.YELLOW)} : \n ${UtilLogger.convert(response.data)}");
    print(
        "└——————————————————————————————————————————————————————————————————————————${UtilLogger.color(" End Response >>> ", ColorsHeader.GREEN)}\n\n");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    // UtilLogger.log('DIO ERROR', dioError.error);
    print('\n');
    print(
        "┌${UtilLogger.color(" [ Begin Error ] ", ColorsHeader.RED)}────────────────────────────────────────────────────────────────────────");
    print(
        "| Status Code : ${UtilLogger.color("${dioError.response?.statusCode}", ColorsHeader.RED)}");
    print(
        "| URL :  ${UtilLogger.color((dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL'), ColorsHeader.RED)}");
    print("| Message : ${dioError.message}");
    print(
        "|${UtilLogger.color(" Response Message", ColorsHeader.YELLOW)} : \n ${UtilLogger.convert(dioError.response != null ? dioError.response.data : 'Unknown Error')}");
    print(
        "└——————————————————————————————————————————————————————————————————————————${UtilLogger.color(" End Eerror >>> ", ColorsHeader.RED)}\n\n");

    super.onError(dioError);
  }

  _printHeader(var response) {
    if (withHeader) {
      print("| Headers:");
      response.headers?.forEach((k, v) =>
          print(UtilLogger.color(" ├── $k: $v", ColorsHeader.PURPLE)));
      print("| \n");
    }
  }
}
