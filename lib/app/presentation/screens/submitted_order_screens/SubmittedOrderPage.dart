// import 'package:flutter/material.dart';

// class SubmittedOrderPage extends StatelessWidget {
//   const SubmittedOrderPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Submitted Order'),
//       ),
//       body: Center(
//         child: CustomerDropdownList(),
//       ),
//     );
//   }
// }

// class CustomerDropdownList extends StatefulWidget {
//   const CustomerDropdownList({Key? key}) : super(key: key);

//   @override
//   _CustomerDropdownListState createState() => _CustomerDropdownListState();
// }

// class _CustomerDropdownListState extends State<CustomerDropdownList> {
//   TextEditingController searchController = TextEditingController();
//   List<String> customerNames = [
//     'John Doe',
//     'Jane Smith',
//     'Alice Johnson',
//     'Bob Williams',
//     'Eve Brown',
//   ];

//   List<String> filteredCustomerNames = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredCustomerNames.addAll(customerNames);
//   }

//   void filterSearchResults(String query) {
//     List<String> searchResults = [];
//     searchResults.addAll(customerNames);
//     if (query.isNotEmpty) {
//       searchResults.retainWhere(
//           (customer) => customer.toLowerCase().contains(query.toLowerCase()));
//       setState(() {
//         filteredCustomerNames.clear();
//         filteredCustomerNames.addAll(searchResults);
//       });
//     } else {
//       setState(() {
//         filteredCustomerNames.clear();
//         filteredCustomerNames.addAll(customerNames);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: (value) {
//                     filterSearchResults(value);
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Search customer...',
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   filterSearchResults(searchController.text);
//                 },
//                 icon: Icon(Icons.search),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.0),
//         DropdownButton<String>(
//           items: filteredCustomerNames.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             // Handle dropdown value change
//           },
//           hint: Text('Select Customer'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class SubmittedOrderPage extends StatelessWidget {
  const SubmittedOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Order'),
      ),
      body: const CustomerDropdownList(),
    );
  }
}
class CustomerDropdownList extends StatefulWidget {
  const CustomerDropdownList({Key? key}) : super(key: key);

  @override
  _CustomerDropdownListState createState() => _CustomerDropdownListState();
}

class _CustomerDropdownListState extends State<CustomerDropdownList> {
  TextEditingController searchController = TextEditingController();
  List<String> customerNames = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Williams',
    'Eve Brown',
  ];

  List<String> filteredCustomerNames = [];

  @override
  void initState() {
    super.initState();
    filteredCustomerNames.addAll(customerNames);
  }

  void filterSearchResults(String query) {
    List<String> searchResults = [];
    searchResults.addAll(customerNames);
    if (query.isNotEmpty) {
      searchResults.retainWhere(
          (customer) => customer.toLowerCase().contains(query.toLowerCase()));
    }
    setState(() {
      filteredCustomerNames.clear();
      filteredCustomerNames.addAll(searchResults);
    });
  }

  void showCustomerDropdown() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search customer...',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCustomerNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(filteredCustomerNames[index]),
                        onTap: () {
                          Navigator.of(context).pop(filteredCustomerNames[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: showCustomerDropdown,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select Customer',
              ),
            ),
          ),
          IconButton(
            onPressed: showCustomerDropdown,
            icon: Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }
}
