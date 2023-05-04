import 'package:dictionary/home/screens/home_screen.dart';
import 'package:dictionary/onboard/services/onboarding_service.dart';
import 'package:dictionary/utils/navigator.dart';
import 'package:dictionary/utils/sf.dart';

final onBoardingService = OnBoardingServiceImpl();

class OnBoardingServiceImpl extends OnBoardingService {
  @override
  Future<void> logNewUser() async {
    await sf.registerNewUser();
    appRouter.push(const HomeScreen());
  }
}
