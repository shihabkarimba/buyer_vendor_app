import 'package:flutter/material.dart';

class AnimatedSearchContainer extends StatelessWidget {
  final VoidCallback onClose;

  AnimatedSearchContainer({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Add your search input and content widgets here
          Text('Search Container Content'),
          ElevatedButton(
            onPressed: onClose,
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
