class SubmittedOrderResponse {
  final bool success;
  final String message;
  final List<SubmittedOrderData> data;

  SubmittedOrderResponse({required this.success, required this.message, required this.data});

  factory SubmittedOrderResponse.fromJson(Map<String, dynamic> json) {
    return SubmittedOrderResponse(
      success: json['success'],
      message: json['message'],
      data: List<SubmittedOrderData>.from(
        json['data'].map(
          (submittedOrderData) => SubmittedOrderData.fromJson(submittedOrderData),
        ),
      ),
    );
  }
}

class SubmittedOrderData {
  final int id;
  final String orderNo;
  final String customerNumber;
  final String company;
  final String? subTotal;
  final String? discount;
  final String total;
  final String? status;
  final String? sapOrderNo;
  final String createdAt;
  final String updatedAt;

  SubmittedOrderData({
    required this.id,
    required this.orderNo,
    required this.customerNumber,
    required this.company,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.status,
    required this.sapOrderNo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubmittedOrderData.fromJson(Map<String, dynamic> json) {
    return SubmittedOrderData(
      id: json['id'],
      orderNo: json['order_no'].toString(),
      customerNumber: json['customer_number'].toString(),
      company: json['company'].toString(),
      subTotal: json['sub_total'].toString(),
      discount: json['discount'].toString(),
      total: json['total'].toString(),
      status: json['status'].toString(),
      sapOrderNo: json['sap_order_no'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}
class SubmittedOrderDetails {
  final bool success;
  final String message;
  final List<OrderDetailData> data;

  SubmittedOrderDetails({required this.success, required this.message, required this.data});

  factory SubmittedOrderDetails.fromJson(Map<String, dynamic> json) {
    return SubmittedOrderDetails(
      success: json['success'],
      message: json['message'],
      data: List<OrderDetailData>.from(
        json['data'].map(
          (orderDetailData) => OrderDetailData.fromJson(orderDetailData),
        ),
      ),
    );
  }
}

class OrderDetailData {
  final int id;
  final String orderNo;
  final String productNumber;
  final String? productName;
  final String quantity;
  final String price;


  OrderDetailData({
    required this.id,
    required this.orderNo,
    required this.productNumber,
    required this.productName,
    required this.quantity,
    required this.price,

  });

  factory OrderDetailData.fromJson(Map<String, dynamic> json) {
    return OrderDetailData(
      id: json['id'],
      orderNo: json['order_no'],
      productNumber: json['product_number'],
      productName: json['product_name'],
      quantity: json['quantity'].toString(),
      price: json['price'].toString(),
    );
  }
}
