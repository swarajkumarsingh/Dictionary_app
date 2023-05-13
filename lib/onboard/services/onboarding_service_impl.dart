import '../../home/screens/home_screen.dart';
import '../../utils/navigator.dart';
import '../../utils/sf.dart';
import 'onboarding_service.dart';

final onBoardingService = OnBoardingServiceImpl();

class OnBoardingServiceImpl extends OnBoardingService {
  @override
  Future<void> logNewUser() async {
    await sf.registerNewUser();
    appRouter.push(const HomeScreen());
  }
}
