import '../../home/screens/home_screen.dart';

import '../../common/check_internet_screen.dart';
import '../navigator.dart';
import '../snackbar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final networkUtils = _NetworkUtils();
bool _isLoggedIn = true;

class _NetworkUtils {
  Future<void> checkNetOnClick() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      showSnackBar(msg: "Please check your internet");
      return;
    } else if (_isLoggedIn == true) {
      appRouter.push(const HomeScreen());
    } else if (_isLoggedIn == false) {
      // appRouter.push(const OnBoardingScreen());
    } else {
      // appRouter.push(const OnBoardingScreen());
    }
  }

  Future<void> checkNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.disconnected) {
        appRouter.push(const NoInterNetScreen());
      }
    });
  }
}
