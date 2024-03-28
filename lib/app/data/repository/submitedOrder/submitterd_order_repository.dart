import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kreplemployee/app/data/constants/api_base_url.dart';
import 'package:kreplemployee/app/data/helper/Internet/connectivity_services.dart';

class SubmittedOrderRepository {
  final Dio _dio = Dio();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<Map<String, dynamic>> fetchSubmittedOrders(String customerNumber) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}myorders',
        data: {'customer_number': customerNumber},
      );

      return response.data;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching submitted orders: $error');
      }
      rethrow;
    }
  }
}
