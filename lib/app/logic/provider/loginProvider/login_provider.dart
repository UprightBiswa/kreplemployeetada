import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/model/otp_request_model.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/data/model/verify_otp_response.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/data/repository/login/login_repository.dart';
import 'package:kreplemployee/app/logic/utils/flutter_tost/tost_service.dart';
import 'package:kreplemployee/app/presentation/widgets/loading/custom_loading_widget.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  VerifyOTPResponse? _loginResponse;
  VerifyOTPResponse? get loginResponse => _loginResponse;
  OTPRequest? _otpRequest;
  OTPRequest? get otpRequest => _otpRequest;

  UserDetailsResponse? _userDetailsResponse;
  UserDetailsResponse? get userDetailsResponse => _userDetailsResponse;

  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;
  Future<void> requestOTP(String username, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      showCustomLoadingDialog(context, 'Requesting OTP...');

      final response = await _loginRepository.requestOTP(username);
      _otpRequest = OTPRequest.fromJson(response);

      _isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      if (_otpRequest!.success) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'OTP requested successfully',
            isSuccess: true);
      } else {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Error: ${_otpRequest!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error requesting OTP: $error');
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error requesting OTP: $error');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future<void> verifyOTP(
    String username,
    String otp,
    BuildContext context,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      showCustomLoadingDialog(context, 'Verifying OTP...');

      final response = await _loginRepository.verifyOTP(username, otp);
      _loginResponse = VerifyOTPResponse.fromJson(response);

      _isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      if (_loginResponse!.success) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'OTP verified successfully',
            isSuccess: true);
      } else {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Error: ${_loginResponse!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error verifying OTP: $error');
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error verifying OTP: $error');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future<void> getUserInfo(String username, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      //showCustomLoadingDialog(context, 'Fetching Data...');

      final response = await _loginRepository.getUserInfo(username);
      _userDetailsResponse = UserDetailsResponse.fromJson(response);

      _isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      //Navigator.of(context).pop();

      if (_userDetailsResponse!.success) {
        _userDetails = _userDetailsResponse!.data!;
        AuthState().setToken(
          _userDetails!.userType,
          _userDetails!.userCode,
          _userDetails!.employeeCode,
          _userDetails!.employeeName,
          _userDetails!.accessType,
          _userDetails!.validFrom,
          _userDetails!.validTo,
          _userDetails!.status,
        );
      } else {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Error: ${_userDetailsResponse!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error fetching user info: $error');
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error fetching user info: $error');

      // ignore: use_build_context_synchronously
      //Navigator.of(context).pop();
    }
  }
}
