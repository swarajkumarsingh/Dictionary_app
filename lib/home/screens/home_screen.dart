import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../dictionary/screens/dictionary_screen.dart';
import '../../utils/navigator.dart';
import '../../utils/snackbar.dart';
import '../services/home_services.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/news_tree_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void _pushToDictionaryScreen() async {
  try {
    appRouter.push(const DictionaryScreen());
  } catch (e) {
    showSnackBar();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeServices client = HomeServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: const Text(
            "S Dictionary",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FadeInRight(
            child: IconButton(
              onPressed: () => _pushToDictionaryScreen(),
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
          FadeInUp(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.black,
              ),
            ),
          ),
          FadeInLeft(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomCarouselSlider(),
            NewsContainer(client: client)
          ],
        ),
      ),
    );
  }
}
