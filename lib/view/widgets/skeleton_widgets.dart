import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerSkeletonWidget extends StatelessWidget {
  const BannerSkeletonWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 120,
                color: Colors.black,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.black,
                    width: 100,
                    height: 30,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    color: Colors.black,
                    width: 100,
                    height: 30,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    color: Colors.black,
                    width: 100,
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}