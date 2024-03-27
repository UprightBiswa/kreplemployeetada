import 'package:dio/dio.dart';
import 'package:kreplemployee/app/data/constants/api_base_url.dart';
import 'package:kreplemployee/app/data/helper/Internet/connectivity_services.dart';

class LoginRepository {
  final Dio _dio = Dio();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<Map<String, dynamic>> requestOTP(String username) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}sf_request_otp',
        data: {'username': username},
      );
      return response.data;
    } catch (error) {
      print('Error requesting OTP: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> verifyOTP(String username, String otp) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}sf_verify_otp',
        data: {'username': username, 'otp': otp},
      );
      return response.data;
    } catch (error) {
      print('Error verifying OTP: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String username) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}sf_user_info', // Adjust the endpoint accordingly
        queryParameters: {'username': username},
      );
      return response.data;
    } catch (error) {
      print('Error fetching user info: $error');
      throw error;
    }
  }
}
