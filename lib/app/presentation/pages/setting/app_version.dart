import 'package:flutter/material.dart';
import 'package:kreplemployee/classes/language_constrants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionWidget extends StatefulWidget {
  const AppVersionWidget({Key? key}) : super(key: key);

  @override
  _AppVersionWidgetState createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  late Future<String> _appVersion;

  @override
  void initState() {
    super.initState();
    _appVersion = getAppVersion();
  }

  @override
  void dispose() {
    getAppVersion();
    super.dispose();
  }

  Future<String> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      print('app version: ${packageInfo.version}');
      return packageInfo.version;
    } catch (e) {
      print('Error getting app version: $e');
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _appVersion,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text(translation(context).error_getting_version);
        } else {
          return Text(snapshot.data ?? translation(context).unknown);
        }
      },
    );
  }
}
