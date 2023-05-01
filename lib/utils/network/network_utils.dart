import 'package:dictionary/common/check_internet_screen.dart';
import 'package:dictionary/utils/navigator.dart';
import 'package:dictionary/utils/snackbar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final networkUtils = _NetworkUtils();
bool _isLoggedIn = true;

class _NetworkUtils{
  Future<void> checkNetOnClick() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      showSnackBar(msg: "Please check your internet");
      return;
    } else if (_isLoggedIn == true) {
      // Get.offAll(() => const HomeScreen());
    } else if (_isLoggedIn == false) {
      // Get.offAll(() => const OnBoardingScreen());
    } else {
      // Get.offAll(() => const OnBoardingScreen());
    }
  }

  Future<void> checkNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.disconnected) {
        appRouter.pushNamed(NoInterNetScreen.routeName);
      }
    });
  }
}