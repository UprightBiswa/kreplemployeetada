import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/model/submitted_order_model.dart';
import 'package:kreplemployee/app/data/repository/submitedOrder/submitterd_order_repository.dart';

import 'package:kreplemployee/app/logic/utils/flutter_tost/tost_service.dart';
import 'package:kreplemployee/app/presentation/widgets/loading/custom_loading_widget.dart';

class SubmittedOrderProvider extends ChangeNotifier {
  final SubmittedOrderRepository _submittedOrderRepository =
      SubmittedOrderRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SubmittedOrderResponse? _submittedOrderResponse;
  SubmittedOrderResponse? get submittedOrderResponse => _submittedOrderResponse;

  Future<void> fetchSubmittedOrders(String customerNumber, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      showCustomLoadingDialog(context, 'Fetching Submitted Orders...');

      final response =
          await _submittedOrderRepository.fetchSubmittedOrders(customerNumber);
      _submittedOrderResponse = SubmittedOrderResponse.fromJson(response);

      _isLoading = false;
      notifyListeners();

      Navigator.of(context).pop();

      if (_submittedOrderResponse!.success) {
        // Success handling logic here
      } else {
        ToastService.show(context, 'Error: ${_submittedOrderResponse!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error fetching submitted orders: $error');
      }
      ToastService.show(context, 'Error fetching submitted orders: $error');

      Navigator.of(context).pop();
    }
  }
}
