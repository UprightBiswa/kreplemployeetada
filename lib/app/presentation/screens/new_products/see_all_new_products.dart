// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:kreplemployee/app/data/constants/constants.dart';
// import 'package:shimmer/shimmer.dart';

// TextStyle get kLargeTextStyle => const TextStyle(fontSize: 55);
// TextStyle get kLTextStyle => const TextStyle(fontSize: 24);
// TextStyle get kExtraVerySmallTextStyle => const TextStyle(fontSize: 6);
// TextStyle get kInputStyle => const TextStyle(fontSize: 17);
// TextStyle get kCityStyle => const TextStyle(fontSize: 20);
// TextStyle get kPrizeStyleDevice => const TextStyle(fontSize: 15);
// TextStyle get kTicketHead => const TextStyle(fontSize: 40);
// TextStyle get kMainHead => const TextStyle(fontSize: 16);

// const FontWeight kBoldFontWeight = FontWeight.bold;
// const FontWeight kRegularFontWeight = FontWeight.normal;
// const FontWeight kLightFontWeight = FontWeight.w400;
// const FontWeight kThinFontWeight = FontWeight.w100;
// List<BoxShadow> boxShadow = [
//   BoxShadow(
//     color: Colors.grey.withOpacity(0.3),
//     spreadRadius: 2,
//     blurRadius: 3,
//     offset: const Offset(1, 3),
//   )
// ];

// Color kWhiteBackground =
//     const Color.fromARGB(255, 211, 208, 208).withOpacity(0.1);
// const Color kWhitePrimary = Color(0xFFFFFFFF);
// Color kWhiteOpacity = Colors.white.withOpacity(0.8);
// const Color kBlack = Color.fromARGB(255, 3, 3, 3);
// Color kGreyOutlined = Colors.grey.withOpacity(0.2);

// const Color kGreyTextField = Color(0XFF7b7b7b);
// const Color kGreyBackground = Color.fromARGB(255, 175, 173, 173);
// const Color kPinkColor = Color(0XFFfb6e63);
// const Color kRedColor = Colors.red;

// double kContainerRadius = 24;
// double kFullRadius = 20;
// double kButtonRadius = 7;
// double kSignoutButRadius = 10;
// double kRadius = 40;

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   bool isLoading = false;
//   bool showSchems = false;
//   int selectedMonth = 01;
//   // NewProvider _newProductProvider = NewProvider();
//   // List<Product> _newProductdata = [];
//   String region = '';
//   @override
//   void initState() {
//     super.initState();
//     _loadCustomerNumber();
//   }

//   Future<void> _loadCustomerNumber() async {
//     AuthState authState = AuthState();
//     region = await authState.getRegionCode() ?? '';
//     print('region: $region');

//     setState(() {
//       _viewProductsalereportOrders();
//     });
//   }

//   void _viewProductsalereportOrders() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       ProductsResponse response = await _newProductProvider
//           .getNewProductResponse(context: context, region: region);

//       if (response.success) {
//         // Display the dispatch orders in the table
//         print('New  Product: ${response.message}');
//         setState(() {
//           showSchems = true;
//           _newProductdata = response.data;
//         });
//         // Add logic to update your table with the received data
//       } else {
//         // Handle failure response
//         print('API Error: ${response.message}');
//         setState(() {
//           _newProductdata = response.data;
//           showSchems = false;
//         });
//         // Show an error message to the user or handle it as needed
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception: $e');
//       // Show an error message to the user or handle it as needed
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "View All New Products",
//           style: kMainHead.copyWith(
//               color: AppColors.kSecondary, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: isLoading
//                 ? _buildLoadingIndicator()
//                 : showSchems
//                     ? GridView.custom(
//                         physics: const BouncingScrollPhysics(),
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         gridDelegate: SliverWovenGridDelegate.count(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 1,
//                           crossAxisSpacing: 2,
//                           pattern: [
//                             const WovenGridTile(1),
//                             const WovenGridTile(5 / 7,
//                                 crossAxisRatio: 0.9,
//                                 alignment: AlignmentDirectional.centerEnd),
//                           ],
//                         ),
//                         childrenDelegate: SliverChildBuilderDelegate(
//                             (context, index) => NewProductCard(
//                                   city: _newProductdata[index],
//                                 ),
//                             childCount: _newProductdata.length),
//                       )
//                     : Center(
//                         child: Text(
//                           'No new products available.',
//                           style:
//                               kLTextStyle.copyWith(color: AppColors.kSecondary),
//                         ),
//                       ),
//           )
//         ],
//       ),
//     );
//   }
// }

// Widget _buildLoadingIndicator() {
//   return Center(
//     child: CircularProgressIndicator(),
//   );
// }

// class NewProductCard extends StatelessWidget {
//   final Product city;
//   const NewProductCard({
//     Key? key,
//     required this.city,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         _showImagePopup(context, city.productAttachmentUrl);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           color: Colors.white, // White background color
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: CachedNetworkImage(
//             imageUrl: city.productAttachmentUrl,
//             fit: BoxFit.contain,
//             placeholder: (context, url) => _buildShimmerLoading(),
//             errorWidget: (context, url, error) => _buildErrorImage(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildShimmerLoading() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         color: Colors.white, // White background color
//       ),
//     );
//   }

//   Widget _buildErrorImage() {
//     return Image.asset(
//       'assets/images/logo.png', // Provide the path to your error image asset
//       fit: BoxFit.contain,
//     );
//   }

//   void _showImagePopup(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop(); // Close the dialog on tap
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: MediaQuery.of(context).size.height * 0.8,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                   image: CachedNetworkImageProvider(imageUrl),
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog on icon press
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
