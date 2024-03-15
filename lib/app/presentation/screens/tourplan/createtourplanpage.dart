import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/tour_type_model.dart';
import 'package:kreplemployee/app/presentation/pages/address/address_view.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/add_number.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/add_promo.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_custom_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_cutomer_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_others_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_purpose_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_village_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/date_time_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/location_map.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/plan_type_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/selected_type_view.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/tour_save_sheet.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class CreateTourPlanPage extends StatefulWidget {
  const CreateTourPlanPage({super.key});

  @override
  State<CreateTourPlanPage> createState() => _CreateTourPlanPageState();
}

class _CreateTourPlanPageState extends State<CreateTourPlanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _remarksController = TextEditingController();
  int _selectedTourTypeIndex = 0;
  String _tourType = "";
  Customer? _selectedCustomer;
  Village? _selectedVillage;
  Other? _selectedOther;
  Purpose? _selectedPurpose;
  Location? _selectedLocation;
  late DateTime _selectedDate;
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Tour Plan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomHeaderText(
                text: 'Create Tour Plan',
                fontColor:
                    isDarkMode(context) ? AppColors.kWhite : Colors.black,
              ),
              SizedBox(height: 20.h),
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
                          final selectedCustomer = await Get.to<Customer?>(
                            () => const CustomerListPage(),
                          );
                          if (selectedCustomer != null) {
                            setState(() {
                              _selectedCustomer = selectedCustomer;
                            });
                          }
                        },
                      ),
                    if (_selectedTourTypeIndex == 1) // Village Visit
                      CheckoutCustomCard(
                        text: 'List Of Villages',
                        onTap: () async {
                          final selectedVillage = await Get.to<Village?>(
                            () => const VillageListPage(),
                          );
                          if (selectedVillage != null) {
                            setState(() {
                              _selectedVillage = selectedVillage;
                            });
                          }
                        },
                      ),
                    if (_selectedTourTypeIndex == 2) // Others
                      CheckoutCustomCard(
                        text: 'Other Options',
                        onTap: () async {
                          final selectedOther = await Get.to<Other?>(
                            () => const OthersListPage(),
                          );
                          if (selectedOther != null) {
                            setState(() {
                              _selectedOther = selectedOther;
                            });
                          }
                        },
                      ),
                    SizedBox(height: 5.h),
                    if (_selectedCustomer != null)
                      SelectedItemView(
                        title: 'Customer',
                        name: _selectedCustomer!.name,
                        description: _selectedCustomer!.description,
                        image: _selectedCustomer!.image,
                      ),
                    if (_selectedVillage != null) // Display selected village
                      SelectedItemView(
                        title: 'Village',
                        name: _selectedVillage!.name,
                        description: _selectedVillage!.description,
                        image: _selectedVillage!.image,
                      ),
                    if (_selectedOther != null) // Display selected other
                      SelectedItemView(
                        title: 'Option',
                        name: _selectedOther!.name,
                        description: _selectedOther!.description,
                        image: _selectedOther!.image,
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
                        final selectedPurpose = await Get.to<Purpose?>(
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
                        name: _selectedPurpose!.name,
                        description: _selectedPurpose!.description,
                        image: _selectedPurpose!.image,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // PrimaryContainer(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       CheckoutCustomCard(
              //         text: 'Location',
              //         onTap: () async {
              //           final selectedLocation = await Get.to<Location?>(
              //             () => const LocationMap(),
              //           );
              //           if (selectedLocation != null) {
              //             setState(() {
              //               _selectedLocation = selectedLocation;
              //             });
              //           }
              //         },
              //       ),
              //       SizedBox(height: 5.h),
              //       if (_selectedLocation != null)
              //         SelectedItemView(
              //           title: 'Location',
              //           name: _selectedLocation!.name,
              //           description: _selectedLocation!.description,
              //           image: _selectedLocation!.image,
              //         ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateTimeCard(
                      onDateChanged: (DateTime date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      onTimeChanged: (DateTime time) {
                        // Update parent state with the new time
                        setState(() {
                          _selectedTime = time;
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
      bottomSheet: SaveTourSheet(
        bookText: 'Save Tour',
        saveCallback: () {
          saveTour();
        },
        draftCallback: () {
          saveAsDraft();
        },
      ),
    );
  }

// Clear selected data
  void clearSelectedData() {
    setState(() {
      _selectedCustomer = null;
      _selectedVillage = null;
      _selectedOther = null;
    });
  }

  void saveTour() {
    if (_formKey.currentState!.validate()) {
      // Check if user has selected options based on the type of plan
      if (_selectedTourTypeIndex == 0 && _selectedCustomer == null) {
        // Show validation error message for not selecting a customer
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a customer.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_selectedTourTypeIndex == 1 && _selectedVillage == null) {
        // Show validation error message for not selecting a village
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a village.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_selectedTourTypeIndex == 2 && _selectedOther == null) {
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
      if (_selectedCustomer != null) {
        print('Selected Customer: ${_selectedCustomer!.name}');
      }
      if (_selectedVillage != null) {
        print('Selected Village: ${_selectedVillage!.name}');
      }
      if (_selectedOther != null) {
        print('Selected Other: ${_selectedOther!.name}');
      }
      if (_selectedPurpose != null) {
        print('Selected Purpose: ${_selectedPurpose!.name}');
      }
      print('Selected Date: $_selectedDate');
      print('Selected Time: $_selectedTime');
      print('Remarks: ${_remarksController.text}');
      print('Tour Saved');
    }
  }

  void saveAsDraft() {
    if (_formKey.currentState!.validate()) {
      // Validation passed, print field values and save tour as draft
      print('Selected Tour Type: $_tourType');
      if (_selectedCustomer != null) {
        print('Selected Customer: ${_selectedCustomer!.name}');
      }
      if (_selectedVillage != null) {
        print('Selected Village: ${_selectedVillage!.name}');
      }
      if (_selectedOther != null) {
        print('Selected Other: ${_selectedOther!.name}');
      }
      if (_selectedPurpose != null) {
        print('Selected Purpose: ${_selectedPurpose!.name}');
      }
      print('Remarks: ${_remarksController.text}');

      print('Tour Saved as Draft');
    }
  }
}
