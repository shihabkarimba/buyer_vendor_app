
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants/icons.dart';

class SearchInputWidget extends StatelessWidget {
  final Function(String) onSearch;
  const SearchInputWidget({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenwidth*.08),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 10),
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
                hintText: 'Search for products',
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: SvgPicture.asset(
                  searchIcon,
                  colorFilter: const ColorFilter.mode(
                      Color.fromARGB(142, 0, 0, 0), BlendMode.srcIn),
                ),
                suffixIconConstraints:
                    BoxConstraints.loose(const Size(20, 20))),
          ),
        ),
      ),
    );
  }
}
