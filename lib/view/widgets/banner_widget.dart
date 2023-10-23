import 'dart:async';
import 'package:buyer_vendor_app/cloud%20functions/get_banners.dart';
import 'package:buyer_vendor_app/view/widgets/skeleton_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final BuildContext context;
  const BannerWidget({Key? key, required this.context});
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<String>> bannerImagesFuture;
  final PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.8);
  int _currentPage = 1;
  Timer? _timer;
  List<String> bannerImages = [];

  @override
  void initState() {
    super.initState();
    bannerImagesFuture = getBanners(context);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stopAutoScroll();
    super.dispose();
  }
void _startAutoScroll() {
  _timer = Timer.periodic(Duration(seconds: 5), (_) {
    if (_pageController.hasClients) { 
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  });
}


  void _stopAutoScroll() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 180,
      child: FutureBuilder<List<String>>(
        future: bannerImagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              child: BannerSkeletonWidget(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No banner images available.');
          } else {
            bannerImages = snapshot.data!;
            return SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: 150,
                    child: GestureDetector(
                      onTap: _stopAutoScroll,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: bannerImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final imageUrl = bannerImages[index];
                          return Transform.scale(
                            scale: _currentPage == index ? 1.0 : 0.9,
                            child: Card(
                              elevation: _currentPage == index ? 4.0 : 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) =>
                                    const BannerSkeletonWidget(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildPageIndicator(bannerImages.length),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildPageIndicator(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
            color: _currentPage == index
                ? const Color.fromARGB(255, 255, 230, 0)
                : Color.fromARGB(24, 0, 0, 0),
          ),
        );
      }),
    );
  }
}