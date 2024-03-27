import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  String _userType = '';
  String _userCode = '';
  String _employeeCode = '';
  String _employeeName = '';
  String _accessType = '';
  String _validFrom = '';
  String _validTo = '';
  String _status = '';

  String get userType => _userType;
  String get userCode => _userCode;
  String get employeeCode => _employeeCode;
  String get employeeName => _employeeName;
  String get accessType => _accessType;
  String get validFrom => _validFrom;
  String get validTo => _validTo;
  String get status => _status;

  Future<void> setToken(
    String newUserType,
    String newUserCode,
    String newEmployeeCode,
    String newEmployeeName,
    String newAccessType,
    String newValidFrom,
    String newValidTo,
    String newStatus,
  ) async {
    _userType = newUserType;
    _userCode = newUserCode;
    _employeeCode = newEmployeeCode;
    _employeeName = newEmployeeName;
    _accessType = newAccessType;
    _validFrom = newValidFrom;
    _validTo = newValidTo;
    _status = newStatus;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', _userType);
    await prefs.setString('userCode', _userCode);
    await prefs.setString('employeeCode', _employeeCode);
    await prefs.setString('employeeName', _employeeName);
    await prefs.setString('accessType', _accessType);
    await prefs.setString('validFrom', _validFrom);
    await prefs.setString('validTo', _validTo);
    await prefs.setString('status', _status);

    print('Token saved: $_userType');
    print('Customer Name saved: $_userCode');
    print('Region Code saved: $_employeeCode');
    print('Customer Number saved: $_employeeName');
    print('Company Codes saved: $_accessType');
    print('Company Codes saved: $_validFrom');
    print('Company Codes saved: $_validTo');
    print('Company Codes saved: $_status');

    notifyListeners();
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  Future<String?> getUserCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userCode');
  }

  Future<String?> getEmployeeCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('employeeCode');
  }

  Future<String?> getEmployeeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('employeeName');
  }

  Future<String?> getAccessType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessType');
  }

  Future<String?> getValidFrom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('validFrom');
  }

  Future<String?> getValidTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('validTo');
  }

  Future<String?> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('status');
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
    await prefs.remove('userCode');
    await prefs.remove('employeeCode');
    await prefs.remove('employeeName');
    await prefs.remove('accessType');
    await prefs.remove('validFrom');
    await prefs.remove('validTo');
    await prefs.remove('status');

    // Notify listeners after clearing data
    notifyListeners();
  }
}
