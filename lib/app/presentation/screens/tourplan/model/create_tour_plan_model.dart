import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_cutomer_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_others_visit_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_purpose_list.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/add_village_visit_list.dart';

class CreateTourPlanModel {
  final int selectedTourTypeIndex;
  final String tourType;
  final List<dynamic>? selectedObjects;
  final List<Purpose>? selectedPurpose;
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final String remarks;
  final String employeeName;
  final String employeeNumber;
  final TourStatus status;

  CreateTourPlanModel({
    required this.selectedTourTypeIndex,
    required this.tourType,
    required this.selectedObjects,
    required this.selectedPurpose,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.remarks,
    required this.employeeName,
    required this.employeeNumber,
    this.status = TourStatus.pending,
  });

  @override
  String toString() {
    return '''
    Selected Tour Type: $tourType
   Selected Objects: ${selectedObjects?.map((obj) => obj.toString()).toList()} // Change here
    Selected  Purpose: ${selectedPurpose?.map((purpose) => purpose.name).toList()}
    Selected Start Date: $selectedStartDate
    Selected End Date: $selectedEndDate
    Remarks: $remarks
    Employee Name: $employeeName
    Employee Number: $employeeNumber
    Status: $status
    ''';
  }
}

// Dummy data for customers
List<Customer> dummyCustomers = [
  Customer(
      name: 'John Doe',
      description: 'Customer description',
      image: AppAssets.kLogo),
  Customer(
      name: 'Jane Smith',
      description: 'Customer description',
      image: AppAssets.kLogo),
];

// Dummy data for villages
List<Village> dummyVillages = [
  Village(
      name: 'Village A',
      description: 'Village description',
      image: AppAssets.kLogo),
  Village(
      name: 'Village B',
      description: 'Village description',
      image: AppAssets.kLogo),
];

// Dummy data for other options
List<Other> dummyOthers = [
  Other(
      name: 'Option A',
      description: 'Option description',
      image: AppAssets.kLogo),
  Other(
      name: 'Option B',
      description: 'Option description',
      image: AppAssets.kLogo),
];

// Dummy data for purposes
List<Purpose> dummyPurposes = [
  Purpose(
    name: 'Purpose A',
    description: 'Purpose description',
    image: AppAssets.kLogo,
  ),
  Purpose(
    name: 'Purpose B',
    description: 'Purpose description',
    image: AppAssets.kLogo,
  ),
];

enum TourStatus { pending, approved, draft }

List<CreateTourPlanModel> dummyTourPlan = [
  CreateTourPlanModel(
    selectedTourTypeIndex: 0,
    tourType: 'Customer Visit',
    selectedObjects: dummyCustomers,
    selectedPurpose: [dummyPurposes[0]],
    selectedStartDate: DateTime.now(),
    selectedEndDate: DateTime.now(),
    selectedStartTime: DateTime.now(),
    selectedEndTime: DateTime.now(),
    remarks: 'Remarks',
    employeeName: 'Employee Name',
    employeeNumber: 'Employee Number',
    status: TourStatus.pending,
  ),
  CreateTourPlanModel(
    selectedTourTypeIndex: 1,
    tourType: 'Village Visit',
    selectedObjects: dummyVillages,
    selectedPurpose: [dummyPurposes[1]],
    selectedStartDate: DateTime.now().add(const Duration(days: 3)),
    selectedEndDate: DateTime.now().add(const Duration(days: 4)),
    selectedStartTime: DateTime.now().add(const Duration(hours: 3)),
    selectedEndTime: DateTime.now().add(const Duration(hours: 5)),
    remarks: 'Another Remarks',
    employeeName: 'Parag',
    employeeNumber: '1234',
    status: TourStatus.approved,
  ),
  CreateTourPlanModel(
    selectedTourTypeIndex: 2,
    tourType: 'Other Visit',
    selectedObjects: dummyOthers,
    selectedPurpose: [dummyPurposes[0]],
    selectedStartDate: DateTime.now().add(const Duration(days: 5)),
    selectedEndDate: DateTime.now().add(const Duration(days: 6)),
    selectedStartTime: DateTime.now().add(const Duration(hours: 6)),
    selectedEndTime: DateTime.now().add(const Duration(hours: 8)),
    remarks: 'Additional Remarks',
    employeeName: 'John',
    employeeNumber: '5678',
    status: TourStatus.draft,
  ),
];
