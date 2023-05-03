// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../dictionary/screens/dictionary_screen.dart';
import '../../utils/navigator.dart';
import '../screens/home_screen.dart';

List<String> carouselImage = [
  assets.dictionaryBannerImage,
  assets.imageEditorBannerImage,
];

List<Widget> carouselFunctions = [
  const DictionaryScreen(),
  const HomeScreen(),
];

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: CarouselSlider.builder(
        itemCount: carouselFunctions.length,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3),
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return GestureDetector(
            onTap: () => appRouter.push(carouselFunctions[itemIndex]),
            child: CustomBanner(
              imageUrl: carouselImage[itemIndex],
            ),
          );
        },
      ),
    );
  }
}

class CustomBanner extends StatelessWidget {
  final String imageUrl;
  const CustomBanner({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Image.asset(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
