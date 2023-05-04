import 'package:dictionary/common/loader.dart';
import 'package:dictionary/onboard/services/onboarding_service_impl.dart';
import 'package:dictionary/onboard/widgets/onboarding_screen_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'A reader lives a thousand lives',
              body: 'The man who never reads lives only one.',
              image: Image.network(
                  "https://www.pyramidions.com/blog/wp-content/uploads/2020/04/technology-stack-for-web-application-main.jpg"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Featured Books',
              body: 'Available right at your fingerprints',
              image: Image.network(
                  "https://img.freepik.com/free-vector/business-team-brainstorm-idea-lightbulb-from-jigsaw-working-team-collaboration-enterprise-cooperation-colleagues-mutual-assistance-concept-pinkish-coral-bluevector-isolated-illustration_335657-1651.jpg?w=2000"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced reading experience',
              image: Image.network(
                  "https://media.istockphoto.com/vectors/happy-young-employees-giving-support-and-help-each-other-vector-id1218490893?k=20&m=1218490893&s=612x612&w=0&h=svJxkZEFiciFHufK4LNn13TpNip1cVPW9Ig0Ahuugqs="),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Today a reader, tomorrow a leader',
              // body: 'Start your journey',
              bodyWidget: Column(
                children: [
                  OnBoardingSCreenButtonWidget(
                    text: "Let's Start",
                    onClicked: () => onBoardingService.logNewUser(),
                  ),
                ],
              ),
              image: Image.network(
                "https://miro.medium.com/max/512/1*GaBtlHe240ZkwlcBrFczgQ.jpeg",
              ),
              decoration: getPageDecoration(),
            ),
          ],
          done: InkWell(
            onTap: () async => await onBoardingService.logNewUser(),
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          onDone: () {},
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => debugPrint('Page $index performance'),
          animationDuration: 600,
        ),
      ),
    );
  }

  Widget buildImage(String uri) {
    return const Center(
      child: Loader(),
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      color: const Color(0xFFBDBDBD),
      //activeColor: Colors.orange,
      size: const Size(8, 8),
      activeSize: const Size(20, 8),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(24),
    );
  }
}
