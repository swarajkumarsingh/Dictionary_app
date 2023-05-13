import '../sf.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../common/check_internet_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../onboard/screens/onboarding_screen.dart';
import '../navigator.dart';
import '../snackbar.dart';

final networkUtils = _NetworkUtils();

class _NetworkUtils {
  Future<void> checkNetOnClick() async {
    bool isNewUser = await sf.isNewUser();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      showSnackBar(msg: "Please check your internet");
      return;
    } else if (isNewUser == false) {
      appRouter.push(const HomeScreen());
      return;
    } else if (isNewUser == true) {
      appRouter.push(const OnBoardingScreen());
      return;
    } else {
      appRouter.push(const OnBoardingScreen());
      return;
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
