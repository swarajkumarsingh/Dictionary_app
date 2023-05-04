// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dictionary/dictionary/screens/dictionary_screen.dart';
import 'package:dictionary/home/screens/home_screen.dart';
import 'package:dictionary/utils/navigator.dart';
import 'package:flutter/material.dart';

import '../../assets.dart';

List<String> carouselImage = [
  assets.dictionaryBannerImage,
  assets.pdfBanner,
  assets.newBanner,
];

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: CarouselSlider.builder(
        itemCount: carouselImage.length,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3),
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return GestureDetector(
            onTap: () async {
              if (carouselImage[itemIndex] == assets.dictionaryBannerImage) {
                appRouter.push(const DictionaryScreen());
                return;
              }
              if (carouselImage[itemIndex] == assets.pdfBanner) {
                await pushToPDfScreen();
                return;
              }
              if (carouselImage[itemIndex] == assets.newBanner) {
                return;
              }
            },
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
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
