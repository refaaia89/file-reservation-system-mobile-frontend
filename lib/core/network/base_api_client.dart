import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_application/core/strings/api_end_point.dart';
import 'package:logger/logger.dart';

import 'dio_error_handler.dart';

class BaseApiClient {
  static Dio client = Dio();
  static const String _acceptHeader = 'application/json';

  static Map<String, dynamic> defaultHeaders = {
    'Content-Type': 'application/json',
    'accept': _acceptHeader,
  };

  BaseApiClient() {
    client = Dio();
    client.options.baseUrl = BASE_URL;
  }

  static Future<Either<String, T>> post<T>({
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseTypeValue,
    String? token,
    required Function(dynamic) converter,
    // dynamic returnOnError
  }) async {
    try {
      if (token != null) {
        client.options.headers.addAll({
          'Authorization': "Bearer $token",
        });
      }
      Logger().i(BASE_URL + url);
      Logger().i(client.options.headers);
      Logger().w(body);
      var response = await client.post(
        BASE_URL + url,
        queryParameters: queryParameters,
        data: body,
        onSendProgress: (int sent, int total) {},
        options: Options(
          headers: headers ?? defaultHeaders,
          responseType: responseTypeValue ?? ResponseType.json,
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        return right(converter(response.data));
      } else {
        return left(response.data['error']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      print(e.response);
      return left(
          // returnOnError ??
          e.response?.data['error'] ?? dioError['error']);
    } catch (e) {
      print(e);
      return left(e.toString());
    }
  }

  static Future<Either<String, T>> put<T>(
      {required String url,
      dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter,
      String? token,
      dynamic returnOnError}) async {
    try {
      if (token != null) {
        client.options.headers.addAll({
          'Authorization': "Bearer $token",
        });
      }
      var response = await client.put(
        BASE_URL + url,
        data: body,
        queryParameters: queryParameters,
        onSendProgress: (int sent, int total) {},
        options: Options(
          headers: headers ?? defaultHeaders,
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        return Right(converter(response.data));
      } else {
        print(response);
        return left(response.data['error']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      print(e.response);
      return left(
          // returnOnError ??
          e.response?.data['error'] ?? dioError['error']);
    } catch (e) {
      print(e);
      return left(e.toString());
    }
  }

  static Future<Either<String, T>> get<T>(
      {required String url,
      dynamic? body,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      ResponseType? responseTypeValue,
      void Function(int, int)? onReceiveProgress,
      String? token,
      required Function(dynamic) converter}) async {
    try {
      if (token != null) {
        client.options.headers.addAll({
          'Authorization': "Bearer $token",
        });
      }
      var response = await client.get(
        BASE_URL + url,
        data: body,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: headers ?? defaultHeaders,
          responseType: responseTypeValue ?? ResponseType.json,
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        Logger().i(response);
        return Right(converter(response.data));
      } else {
        print(response);
        return left(response.data['error']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      print(e.response);
      return left(
          // returnOnError ??
          e.response?.data['error'] ?? dioError['error']);
    } catch (e) {
      print(e);
      return left(e.toString());
    }
  }

  static Future<Either<String, String>> downloadFile(
      {required String url, String? token, required String savePath, void Function(int, int)? onReceiveProgress}) async {
    try {
      if (token != null) {
        client.options.headers.addAll({
          'Authorization': "Bearer $token",
        });
      }
      Response response = await client.download(
        BASE_URL + url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return const Right('done');
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, T>> delete<T>(
      {required String url, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, String? token, required Function(dynamic) converter}) async {
    try {
      if (token != null) {
        client.options.headers.addAll({
          'Authorization': "Bearer $token",
        });
      }
      var response = await client.delete(
        BASE_URL + url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? defaultHeaders,
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        return Right(converter(response.data));
      } else {
        return left(response.data['error']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      return left(e.response?.data['error'] ?? dioError['error']);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Response?> postMultiPartDio(String url,
      {required String key,
      Map<String, dynamic>? headers,
      dynamic body,
      Map<String, dynamic>? queryParameters,
      ResponseType? responseTypeValue,
      String? token,
      required Function(dynamic) converter,
      required PlatformFile file}) async {
    dynamic fullUrl = BASE_URL + url;
    Logger().i("full url $fullUrl\n file $file");

    Logger().w(file);
    final formData = FormData.fromMap({key: MultipartFile.fromBytes(file.bytes!, filename: file.name), "group_id": body["group_id"]});
    Response? response;
    Logger().w(formData);
    try {
      response = await client
          .post(
            BASE_URL + url,
            data: formData,
            options: Options(
              headers: defaultHeaders,
              followRedirects: false,
            ),
          )
          .timeout(
            const Duration(seconds: 45),
          );
      Logger().w(response);
    } on SocketException {
      Logger().e('No Internet connection');
      Logger().e('temp');

      rethrow;
    } catch (e) {
      Logger().e(e);
      Logger().f("Network Service post(): error ${e.toString()}");
    }

    // Logger().i(
    //   "Network Service Response Body: Status Code: ${response!.statusCode.toString()}\nRequest Method: ${response.statusMessage}\nIsRedirect: ${response.isRedirect}",
    // );
    return response;
  }
}
