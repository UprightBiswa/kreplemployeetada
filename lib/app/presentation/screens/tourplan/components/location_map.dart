import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/address_model.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/selected_type_view.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_google_maps_webservices/places.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({super.key});

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  int? _selectedAddressIndex;
  int? _selectedCurrentAddressIndex;

  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA9jSDwr00hpL_pxHJ48gYfXWLT8-kxlJA');
  List<PlacesSearchResult> _searchResults = [];
  String? fullAddress;
  String? name;
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _checkLocationPermission();
    await _checkInternetConnection();
    await _getCurrentLocation();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showSnackbar('No internet connection');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      _showSnackbar('Please enable location services on your device');
      return;
    }

    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Check if the widget is still mounted before updating the state
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(position.latitude, position.longitude);
          });
        }

        try {
          // Reverse geocode the selected coordinates
          final addresses = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          if (addresses.isNotEmpty) {
            final place = addresses.first;
            // Check if the widget is still mounted before updating the state
            if (mounted) {
              setState(() {
                fullAddress =
                    "${place.name}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}";
                name = "${place.name}";
                locations = addresses.map((result) {
                  return Location(
                    name: place.name ?? 'Unnamed',
                    description: fullAddress ?? 'No address provided',
                    image: AppAssets.kLogo,
                  );
                }).toList();
              });
            }
          } else {
            _showAddressNotFoundSnackbar();
          }
        } catch (error) {
          print("Geocoding error: $error");
          _showGeocodingErrorSnackbar();
        }
        if (_currentLocation != null) {
          _animateToUserLocation();
        }
      } catch (e) {
        print('Error getting location: $e');
        _showSnackbar('Error getting location. Please try again.');
      }
    } else {
      _showSnackbar('Location permission not granted');
    }
  }

  void _animateToUserLocation() async {
    try {
      if (_currentLocation != null) {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            _currentLocation!,
            14.0,
          ),
        );
      }
    } catch (e) {
      print('Error animating to user location: $e');
    }
  }

  Future<void> _searchPlaces(String query) async {
    try {
      await _checkLocationPermission();
      await _checkInternetConnection();

      PlacesSearchResponse response = await places.searchByText(
        query,
        language: 'en',
      );

      if (response.isOkay && response.results.isNotEmpty) {
        setState(() {
          _searchResults = response.results;
          // Initialize locations list with search results
          locations = _searchResults.map((result) {
            return Location(
              name: result.name ?? 'Unnamed',
              description: result.formattedAddress ?? 'No address provided',
              image: AppAssets.kLogo,
            );
          }).toList();
        });
      } else {
        _showSnackbar('No places found matching your query');
      }
    } on SocketException catch (e) {
      _showSnackbar('Failed to connect to the server error: $e');
    } catch (e) {
      _showSnackbar('An error occurred');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showAddressNotFoundSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address not found'),
      ),
    );
  }

  void _showGeocodingErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error fetching address'),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of resources when the page closes
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Column(
                children: [
                  CustomHeaderText(text: 'Search Location', fontSize: 18.sp),
                  SizedBox(height: 16.h),
                  SearchField(
                    controller: _searchController,
                    hintText: 'Search for a location...',
                    buttonText: 'Search',
                    isSearchField: false,
                    onSearchPress: () {
                      _searchPlaces(_searchController.text);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryContainer(
                child: Column(
              children: [
                PrimaryContainer(
                    child: Row(
                  children: [
                    CustomHeaderText(
                        text: 'At my Current Location', fontSize: 18.sp),
                    const Spacer(),
                    SvgPicture.asset(AppAssets.kCurrentLocation)
                  ],
                )),
                if (_currentLocation != null &&
                    fullAddress != null &&
                    name != null)
                  LocationCard(
                    onTap: () {
                      // Handle selection here
                      setState(() {
                        _selectedCurrentAddressIndex =
                            _selectedCurrentAddressIndex == null ? 0 : null;
                        _selectedAddressIndex = null;
                      });
                    },
                    isSelected: _selectedCurrentAddressIndex != null,
                    location: Location(
                      name: name!,
                      description: fullAddress!,
                      image: AppAssets.kLogo,
                    ),
                  ),
              ],
            )),
            SizedBox(height: 20.h),
            Row(
              children: [
                const CustomHeaderText(text: 'Address'),
                const Spacer(),
                CustomButton(
                  onTap: () {},
                  icon: AppAssets.kAddRounded,
                  text: 'Add New',
                ),
                const SizedBox()
              ],
            ),
            SizedBox(height: 20.h),
            PrimaryContainer(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return LocationCard(
                        onTap: () {
                          setState(() {
                            _selectedAddressIndex = index;
                            _selectedCurrentAddressIndex = null;
                          });
                        },
                        isSelected: _selectedAddressIndex == index,
                        location: locations[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 20.h),
                    itemCount: _searchResults.length))
          ],
        ),
      ),
      bottomSheet: Container(
        color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                if (_selectedAddressIndex != null ||
                    _selectedCurrentAddressIndex != null) {
                  Location selectedLocation;
                  if (_selectedAddressIndex != null) {
                    selectedLocation = locations[_selectedAddressIndex!];
                  } else {
                    selectedLocation = Location(
                      name: name!,
                      description: fullAddress!,
                      image: AppAssets.kLogo,
                    );
                  }
                  print('Selected Location name: ${selectedLocation.name}');
                  Navigator.pop(context, selectedLocation);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a Location.'),
                    ),
                  );
                }
              },
              text: 'Select',
              color: (_selectedAddressIndex != null ||
                      _selectedCurrentAddressIndex != null)
                  ? AppColors.kPrimary
                  : isDarkMode(context)
                      ? AppColors.kContentColor
                      : AppColors.kWhite,
              isBorder: true,
            ),
          ],
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Location location;

  const LocationCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(location.image),
            radius: 25.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location.name, style: AppTypography.kMedium16),
                SizedBox(height: 5.h),
                Text(
                  location.description,
                  style: AppTypography.kLight13
                      .copyWith(color: AppColors.kNeutral),
                ),
              ],
            ),
          ),
          Container(
            height: 20.h,
            width: 20.w,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kPrimary, width: 2.w),
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                        color: AppColors.kPrimary, shape: BoxShape.circle),
                  )
                : null,
          )
        ],
      ),
    );
  }
}

class Location {
  final String name;
  final String description;
  final String image;

  const Location({
    required this.name,
    required this.description,
    required this.image,
  });
}
