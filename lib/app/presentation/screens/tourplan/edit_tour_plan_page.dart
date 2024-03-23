import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/tour_type_model.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_custom_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_cutomer_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_others_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_purpose_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_village_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/date_time_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/plan_type_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/selected_type_view.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class EditTourPlanPage extends StatefulWidget {
  final CreateTourPlanModel tourPlan;

  const EditTourPlanPage({Key? key, required this.tourPlan}) : super(key: key);

  @override
  State<EditTourPlanPage> createState() => _EditTourPlanPageState();
}

class _EditTourPlanPageState extends State<EditTourPlanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _selectedTourTypeIndex;
  late String _tourType;
  List<Customer>? _selectedCustomers;
  List<Village>? _selectedVillages;
  List<Other>? _selectedOthers;
  List<Purpose>? _selectedPurpose;
  late DateTime _selectedStartDate;
  late DateTime _selectedStartTime;
  late DateTime _selectedEndDate;
  late DateTime _selectedEndTime;
  final TextEditingController _remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTourTypeIndex = widget.tourPlan.selectedTourTypeIndex;
    _tourType = widget.tourPlan.tourType;
    // Initialize selected objects based on the tour type index
    switch (_selectedTourTypeIndex) {
      case 0:
        _selectedCustomers = widget.tourPlan.selectedObjects as List<Customer>?;
        break;
      case 1:
        _selectedVillages = widget.tourPlan.selectedObjects as List<Village>?;
        break;
      case 2:
        _selectedOthers = widget.tourPlan.selectedObjects as List<Other>?;
        break;
      default:
        break;
    }
    _selectedPurpose = widget.tourPlan.selectedPurpose;
    _selectedStartDate = widget.tourPlan.selectedStartDate;
    _selectedEndDate = widget.tourPlan.selectedEndDate;
    _selectedStartTime = widget.tourPlan.selectedStartTime;
    _selectedEndTime = widget.tourPlan.selectedEndTime;
    _remarksController.text = widget.tourPlan.remarks;
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: CustomHeaderText(
          text: 'Edit Tour Plan',
          fontColor: isDarkMode(context) ? AppColors.kWhite : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              PrimaryContainer(
                child: Column(
                  children: [
                    CustomHeaderText(text: 'Type of plan', fontSize: 18.sp),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (index) => PlanTypeCard(
                          tourtype: tourTypes[index],
                          onTap: () {
                            setState(() {
                              _selectedTourTypeIndex = index;
                              _tourType = tourTypes[index].name;
                              clearSelectedData();
                              print('Selected Tour Type: $_tourType');
                            });
                          },
                          isSelected: _selectedTourTypeIndex == index,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedTourTypeIndex == 0) // Customer Visit
                      CheckoutCustomCard(
                        text: 'List Of Customers',
                        onTap: () async {
                          final selectedCustomers =
                              await Get.to<List<Customer>?>(
                            () => const CustomerListPage(),
                          );
                          if (selectedCustomers != null &&
                              selectedCustomers.isNotEmpty) {
                            setState(() {
                              _selectedCustomers = selectedCustomers;
                            });
                          }
                        },
                      ),
                    if (_selectedTourTypeIndex == 1) // Village Visit
                      CheckoutCustomCard(
                        text: 'List Of Villages',
                        onTap: () async {
                          final selectedVillage = await Get.to<List<Village>?>(
                            () => const VillageListPage(),
                          );
                          if (selectedVillage != null &&
                              selectedVillage.isNotEmpty) {
                            setState(() {
                              _selectedVillages = selectedVillage;
                            });
                          }
                        },
                      ),
                    if (_selectedTourTypeIndex == 2) // Others
                      CheckoutCustomCard(
                        text: 'Other Options',
                        onTap: () async {
                          final selectedOther = await Get.to<List<Other>?>(
                            () => const OthersListPage(),
                          );
                          if (selectedOther != null &&
                              selectedOther.isNotEmpty) {
                            setState(() {
                              _selectedOthers = selectedOther;
                            });
                          }
                        },
                      ),
                    SizedBox(height: 5.h),
                    if (_selectedCustomers != null)
                      SelectedItemView(
                        title: 'Customer',
                        selectedItems: _selectedCustomers!,
                      ),
                    if (_selectedVillages != null) // Display selected village
                      SelectedItemView(
                        title: 'Village',
                        selectedItems: _selectedVillages!,
                      ),
                    if (_selectedOthers != null) // Display selected other
                      SelectedItemView(
                        title: 'Option',
                        selectedItems: _selectedOthers!,
                      ),
                    //SizedBox(height: 5.h),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckoutCustomCard(
                      text: 'List Of Purposes',
                      onTap: () async {
                        final selectedPurpose = await Get.to<List<Purpose>?>(
                          () => const PurposeListPage(),
                        );
                        if (selectedPurpose != null) {
                          setState(() {
                            _selectedPurpose = selectedPurpose;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 5.h),
                    if (_selectedPurpose != null)
                      SelectedItemView(
                        title: 'Purpose',
                        selectedItems: _selectedPurpose!,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateTimeCard(
                      onStartDateTimeChanged: (DateTime date) {
                        setState(() {
                          _selectedStartDate = date;
                        });
                      },
                      onStartTimeChanged: (DateTime time) {
                        setState(() {
                          _selectedStartTime = time;
                        });
                      },
                      onEndDateTimeChanged: (DateTime date) {
                        setState(() {
                          _selectedEndDate = date;
                        });
                      },
                      onEndTimeChanged: (DateTime time) {
                        setState(() {
                          _selectedEndTime = time;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text('Remarks', style: AppTypography.kMedium15),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _remarksController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Remarks',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter remarks';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                updateTour();
              },
              text: 'Update Tour Plan',
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : AppColors.kWhite,
              isBorder: true,
            ),
          ],
        ),
      ),
    );
  }

  CreateTourPlanModel _collectFormData() {
    List<dynamic>? selectedObjects;
    // Helper function to get selected objects based on the selected tour type index
    List<dynamic>? getSelectedObjects() {
      switch (_selectedTourTypeIndex) {
        case 0:
          return _selectedCustomers;
        case 1:
          return _selectedVillages;
        case 2:
          return _selectedOthers;
        default:
          return null;
      }
    }

    selectedObjects = getSelectedObjects();
    return CreateTourPlanModel(
      selectedTourTypeIndex: _selectedTourTypeIndex,
      tourType: _tourType,
      selectedObjects: selectedObjects,
      selectedPurpose: _selectedPurpose,
      selectedStartDate: _selectedStartDate,
      selectedEndDate: _selectedEndDate,
      selectedStartTime: _selectedStartTime,
      selectedEndTime: _selectedEndTime,
      remarks: _remarksController.text,
      employeeName: widget.tourPlan.employeeName,
      employeeNumber: widget.tourPlan.employeeNumber,
    );
  }

// Clear selected data
  void clearSelectedData() {
    setState(() {
      _selectedCustomers = null;
      _selectedVillages = null;
      _selectedOthers = null;
    });
  }

  void updateTour() {
    if (_formKey.currentState!.validate()) {
      // Check if user has selected options based on the type of plan
      if (_selectedTourTypeIndex == 0 && _selectedCustomers == null) {
        // Show validation error message for not selecting a customer
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a customer.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_selectedTourTypeIndex == 1 && _selectedVillages == null) {
        // Show validation error message for not selecting a village
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a village.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_selectedTourTypeIndex == 2 && _selectedOthers == null) {
        // Show validation error message for not selecting an option
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an option.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      if (_selectedPurpose == null) {
        // Show validation error message for not selecting a customer
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a purpose.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // Validation passed, print field values and save tour
      print('Selected Tour Type: $_tourType');
      if (_selectedCustomers != null) {
        for (var customer in _selectedCustomers!) {
          print('Selected Customer: ${customer.name}');
        }
      }
      if (_selectedVillages != null) {
        for (var village in _selectedVillages!) {
          print('Selected Village: ${village.name}');
        }
      }
      if (_selectedOthers != null) {
        for (var other in _selectedOthers!) {
          print('Selected Other: ${other.name}');
        }
      }
      if (_selectedPurpose != null) {
        for (var purpose in _selectedPurpose!) {
          print('Selected Purpose: ${purpose.name}');
        }
      }
      print('Selected Start Date: $_selectedStartDate');
      print('Selected End Date: $_selectedEndDate');
      print('Remarks: ${_remarksController.text}');
      CreateTourPlanModel tourPlan = _collectFormData();
      print('Biswajit${tourPlan}');
      print('Tour Saved');
      dummyTourPlan.add(tourPlan);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }
  }
}
