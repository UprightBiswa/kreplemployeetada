
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:krishajdealer/services/api/loginotp/verify_otp_responce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  String _token = '';
  String _customerName = '';
  String _regionCode = '';
  String _customerNumber = '';
  List<String> _companyCodes = [];
  //List<CompanyCode> _companyCodesdesc = [];

  String get token => _token;
  String get customerName => _customerName;
  String get regionCode => _regionCode;
  String get customerNumber => _customerNumber;
  List<String> get companyCodes => _companyCodes;
  //List<CompanyCode> get companyCodesdesc => _companyCodesdesc;

  Future<void> setToken(
    String newToken,
    String newCustomerName,
    String newRegionCode,
    String newCustomerNumber,
    List<String> newCompanyCodes,
  //  List<CompanyCode> newCompanyCodesdesc,
  ) async {
    _token = newToken;
    _customerName = newCustomerName;
    _regionCode = newRegionCode;
    _customerNumber = newCustomerNumber;
    _companyCodes = newCompanyCodes;
   // _companyCodesdesc = newCompanyCodesdesc;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
    await prefs.setString('customerName', _customerName);
    await prefs.setString('regionCode', _regionCode);
    await prefs.setString('customerNumber', _customerNumber);
    await prefs.setStringList('companyCodes', _companyCodes);

    // final companyCodesdescJson = _companyCodesdesc
    //     .map((companyCode) => json.encode(companyCode.toJson()))
    //     .toList();
    //await prefs.setStringList('companyCodesdesc', companyCodesdescJson);

    print('Token saved: $_token');
    print('Customer Name saved: $_customerName');
    print('Region Code saved: $_regionCode');
    print('Customer Number saved: $_customerNumber');
    print('Company Codes saved: $companyCodes');
   // print('Company Codesdesc saved: $companyCodesdescJson');
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getCustomerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customerName');
  }

  Future<String?> getRegionCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('regionCode');
  }

  Future<String?> getCustomerNumnber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customerNumber');
  }

  Future<List<String>?> getCompanyCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('companyCodes');
  }

  // Future<List<CompanyCode>> getCompanyCodesdesc() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final companyCodesdescJson = prefs.getStringList('companyCodesdesc');

  //   if (companyCodesdescJson != null) {
  //     print('Company Codesdesc saved: $companyCodesdescJson');

  //     try {
  //       // Convert JSON strings to CompanyCode objects
  //       List<CompanyCode> companyCodes = companyCodesdescJson
  //           .where((jsonString) => jsonString.isNotEmpty)
  //           .map((jsonString) {
  //         try {
  //           return CompanyCode.fromJson(jsonDecode(jsonString));
  //         } catch (e) {
  //           print('Error decoding JSON string: $e');
  //           return CompanyCode(companyCode: '', companyShortDescription: '');
  //         }
  //       }).toList();

  //       return companyCodes;
  //     } catch (e) {
  //       print('Error parsing JSON: $e');
  //       return [];
  //     }
  //   } else {
  //     return [];
  //   }
  // }
}
