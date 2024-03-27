class UserDetailsResponse {
  final bool success;
  final String message;
  final UserDetails? data;

  UserDetailsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserDetails.fromJson(json['data']) : null,
    );
  }
}

class UserDetails {
  final int id;
  final String userType;
  final String userCode;
  final String companyCode;
  final String employeeCode;
  final String employeeName;
  final String accessType;
  final String validFrom;
  final String validTo;
  final String status;
  final String createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  UserDetails({
    required this.id,
    required this.userType,
    required this.userCode,
    required this.companyCode,
    required this.employeeCode,
    required this.employeeName,
    required this.accessType,
    required this.validFrom,
    required this.validTo,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.updatedBy,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? 0,
      userType: json['user_type'] ?? '',
      userCode: json['user_code'] ?? '',
      companyCode: json['company_code'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      employeeName: json['employee_name'] ?? '',
      accessType: json['access_type'] ?? '',
      validFrom: json['valid_from'] ?? '',
      validTo: json['valid_to'] ?? '',
      status: json['status'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
