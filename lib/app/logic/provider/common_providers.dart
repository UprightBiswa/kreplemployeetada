// common_providers.dart
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:provider/provider.dart';

class CommonProviders {
  static ChangeNotifierProvider<AuthState> authStateProvider() {
    return ChangeNotifierProvider<AuthState>(
      create: (_) => AuthState(),
    );
  }

  
}
