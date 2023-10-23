import 'package:buyer_vendor_app/cloud%20functions/add_wishlist.dart';
import 'package:buyer_vendor_app/cloud%20functions/remove_wishlist_item.dart';
import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLikeButton extends StatefulWidget {
  final String productName;
  final String price;
  final String imageSrc;
  final String productUnit;
  final BuildContext context;
  final dynamic isInWishlist;
  final double? size;
  final String categoryName;
  final String productDescription;
  const CustomLikeButton({
    super.key,
    required this.context,
    required this.categoryName,
    required this.price,
    required this.imageSrc,
    required this.productDescription,
    required this.productUnit,
    required this.productName,
    required this.isInWishlist,
    this.size,
  });

  @override
  State<CustomLikeButton> createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isAnimatingForward = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _isAnimatingForward = widget.isInWishlist ?? false;
    if (_isAnimatingForward) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_isAnimatingForward) {
          _animationController.reverse();
          await deleteWishlistItemByName(
            productName: widget.productName,
          );
        } else {
          _animationController.forward();
          addToWishList(
            categoryName: widget.categoryName,
            productDescription: widget.productDescription,
            productName: widget.productName,
            price: widget.price,
            imageSrc: widget.imageSrc,
            productUnit: widget.productUnit,
            context: context,
            isLiked: true,
          );
        }
        _isAnimatingForward = !_isAnimatingForward;
      },
      child: SizedBox(
        height: widget.size ?? 50,
        width: widget.size ?? 50,
        child: Lottie.asset(
          likeAnimation,
          fit: BoxFit.fill,
          repeat: false,
          controller: _animationController,
        ),
      ),
    );
  }
}
