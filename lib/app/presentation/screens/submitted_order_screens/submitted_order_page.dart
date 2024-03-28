import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/customer_model.dart';
import 'package:kreplemployee/app/data/model/submitted_order_model.dart';
import 'package:kreplemployee/app/logic/provider/submittedOrderProvider/submitted_order_provider.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_custom_card.dart';
import 'package:kreplemployee/app/presentation/screens/submitted_order_screens/filter_date.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_cutomer_visit_list.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:provider/provider.dart';

class SubmittedOrderPage extends StatefulWidget {
  const SubmittedOrderPage({Key? key}) : super(key: key);

  @override
  State<SubmittedOrderPage> createState() => _SubmittedOrderPageState();
}

class _SubmittedOrderPageState extends State<SubmittedOrderPage> {
  List<Customer>? _selectedCustomers;
  final List<SubmittedOrderData> _submittedOrders = [];
  List<SubmittedOrderData> _filteredSubmittedOrders = [];
  DateTime? _fromDate;
  DateTime? _toDate;
  late SubmittedOrderProvider submittedOrderProvider;

  @override
  void initState() {
    super.initState();
    submittedOrderProvider =
        Provider.of<SubmittedOrderProvider>(context, listen: false);
    _updateSubmittedOrdersList();
  }

  @override
  void dispose() {
    super.dispose();
    _submittedOrders.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submitted Order',
          style: AppTypography.kMedium15,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckoutCustomCard(
                      text: 'Select Customer',
                      onTap: () async {
                        final selectedCustomers = await Get.to<List<Customer>?>(
                          () => const CustomerListPage(
                            isMultiSelection: false,
                          ),
                        );
                        if (selectedCustomers != null &&
                            selectedCustomers.isNotEmpty) {
                          setState(() {
                            _selectedCustomers = selectedCustomers;
                          });
                          submittedOrderProvider.fetchSubmittedOrders(
                              selectedCustomers.first.customerNumber,
                              // ignore: use_build_context_synchronously
                              context);
                          _updateSubmittedOrdersList();
                        }
                      },
                    ),
                    if (_selectedCustomers != null &&
                        _selectedCustomers!.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _selectedCustomers!.length,
                        itemBuilder: (context, index) {
                          final customer = _selectedCustomers![index];
                          return Text(
                            'Name: ${customer.name}, ID: ${customer.customerNumber}',
                            style: AppTypography.kMedium14,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (submittedOrderProvider.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (submittedOrderProvider.submittedOrderResponse != null &&
                submittedOrderProvider.submittedOrderResponse!.data.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dataTableTheme: DataTableThemeData(
                          dataRowColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                // Return color for selected state
                                return isDarkMode(context)
                                    ? Colors.greenAccent
                                    : Colors.green;
                              }
                              return isDarkMode(context)
                                  ? AppColors.kGrey
                                  : Colors.white;
                            },
                          ),
                          dataTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0.h,
                          ),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => isDarkMode(context)
                                  ? Colors.grey
                                  : Colors.green),
                          headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0.h,
                          ),
                        ),
                      ),
                      child: DataTable(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isDarkMode(context)
                                  ? AppColors.kGrey
                                  : Colors.black),
                        ),
                        border: TableBorder.all(color: AppColors.kGrey),
                        dividerThickness: 1.0,
                        horizontalMargin: 10,
                        columnSpacing: 10,
                        headingRowHeight: 30,
                        dataRowMinHeight: 30,
                        dataRowMaxHeight: 30,
                        columns: const [
                          DataColumn(label: Text('Sl No')),
                          DataColumn(label: Text('App Order No')),
                          DataColumn(label: Text('Sap Order No')),
                          DataColumn(label: Text('Order Date')),
                          DataColumn(label: Text('Company Code')),
                          DataColumn(label: Text('Total Price')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: List.generate(
                          submittedOrderProvider
                              .submittedOrderResponse!.data.length,
                          (index) {
                            final order = submittedOrderProvider
                                .submittedOrderResponse!.data[index];
                            _submittedOrders.add(order);
                            _filteredSubmittedOrders.add(order); //
                            return DataRow(
                              color: MaterialStateColor.resolveWith((states) =>
                                  index.isOdd
                                      ? Colors.grey[200]!
                                      : Colors.white),
                              cells: [
                                DataCell(Text((index + 1).toString())),
                                DataCell(Text(
                                    _filteredSubmittedOrders[index].orderNo)),
                                DataCell(Text(_filteredSubmittedOrders[index]
                                        .sapOrderNo ??
                                    '')),
                                DataCell(Text(formatDate(
                                    _filteredSubmittedOrders[index]
                                        .createdAt))),
                                DataCell(Text(
                                    _filteredSubmittedOrders[index].company)),
                                DataCell(Text(
                                    _filteredSubmittedOrders[index].total)),
                                DataCell(Text(
                                    _filteredSubmittedOrders[index].status ??
                                        '')),
                                DataCell(Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      // Implement delete action
                                    },
                                  ),
                                )),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (submittedOrderProvider.submittedOrderResponse != null &&
                submittedOrderProvider.submittedOrderResponse!.data.isEmpty)
              const Center(child: Text('No data found')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _openFilterBottomSheet();
        },
        backgroundColor: Colors.green,
        tooltip: 'Filter Orders',
        child: Icon(
          Icons.filter_alt,
          color: isDarkMode(context) ? AppColors.kDarkBackground : Colors.white,
        ),
      ),
    );
  }

  String formatDate(dynamic originalDate) {
    String originalDateString = originalDate.toString();
    List<String> parts = originalDateString.split('T');
    List<String> dateParts = parts[0].split('-');
    String formattedDate = '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
    return formattedDate;
  }

  int extractNumericPart(String orderNo) {
    int startIndex = orderNo.indexOf(RegExp(r'\d'));
    String numericPart = orderNo.substring(startIndex);
    return int.tryParse(numericPart) ?? 0;
  }

  String filterdateformate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day/$month/$year';
  }

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Orders',
                        style: TextStyle(
                          fontSize: 18.0.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 16.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: DateField(
                          hintText: _fromDate != null
                              ? 'From: ${filterdateformate(_fromDate!)}'
                              : 'From: DD/MM/YYYY',
                          controller: TextEditingController(),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _fromDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              setState(() {
                                _fromDate = picked;
                                print(_fromDate);
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DateField(
                          hintText: _toDate != null
                              ? 'To: ${filterdateformate(_toDate!)}'
                              : 'To: DD/MM/YYYY',
                          controller: TextEditingController(),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _toDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              setState(() {
                                _toDate = picked;
                                print(_toDate);
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _fromDate = null;
                            _toDate = null;
                            if (_fromDate == null && _toDate == null) {
                              _applyDateFilter();
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 16.h,
                            ),
                            SizedBox(width: 4.0.w),
                            Text(
                              'Clear Filter',
                              style: TextStyle(
                                fontSize: 12.h,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0.w),
                      ElevatedButton(
                        onPressed: () {
                          _applyDateFilter();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.h,
                            ),
                            SizedBox(width: 4.0.w),
                            Text(
                              'Apply Filter',
                              style: TextStyle(
                                fontSize: 12.h,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updateSubmittedOrdersList() {
    _submittedOrders.clear();
    _filteredSubmittedOrders.clear();
    if (submittedOrderProvider.submittedOrderResponse != null &&
        submittedOrderProvider.submittedOrderResponse!.data.isNotEmpty) {
      // Add orders to the lists
      _submittedOrders
          .addAll(submittedOrderProvider.submittedOrderResponse!.data);
      _filteredSubmittedOrders
          .addAll(submittedOrderProvider.submittedOrderResponse!.data);
    }
  }

  void _applyDateFilter() {
    if (_fromDate != null && _toDate != null) {
      _filteredSubmittedOrders = _submittedOrders.where((order) {
        DateTime orderDate = DateTime.parse(order.createdAt);
        return orderDate.isAfter(_fromDate!) && orderDate.isBefore(_toDate!);
      }).toList();
    } else {
      _filteredSubmittedOrders = List.from(_submittedOrders);
    }
    setState(() {});
  }
}
