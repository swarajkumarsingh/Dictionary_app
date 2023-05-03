import 'package:animate_do/animate_do.dart';
import 'package:dictionary/home/services/home_services_impl.dart';
import 'package:dictionary/pdf_viewer/screens/pdf_screen.dart';
import 'package:dictionary/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../dictionary/screens/dictionary_screen.dart';
import '../../utils/navigator.dart';
import '../services/home_services.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/news_tree_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void _pushToDictionaryScreen() async {
  appRouter.push(const DictionaryScreen());
}

Future<void> pushToPDfScreen() async {
  try {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    // Get Pdf path
    final pathString = result.files.first.path.toString();

    appRouter.push(PdfScreen(path: pathString));
  } catch (e) {
    showSnackBar(msg: "Unable to select file");
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeServicesImpl client = HomeServicesImpl();
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
              onPressed: () async => await pushToPDfScreen(),
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
