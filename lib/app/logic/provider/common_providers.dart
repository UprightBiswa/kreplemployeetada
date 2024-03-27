// common_providers.dart
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/logic/provider/loginProvider/login_provider.dart';
import 'package:provider/provider.dart';

class CommonProviders {
  static ChangeNotifierProvider<AuthState> authStateProvider() {
    return ChangeNotifierProvider<AuthState>(
      create: (context) => AuthState(),
    );
  }

  static ChangeNotifierProvider<LoginProvider> loginProvider() {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    );
  }
}
