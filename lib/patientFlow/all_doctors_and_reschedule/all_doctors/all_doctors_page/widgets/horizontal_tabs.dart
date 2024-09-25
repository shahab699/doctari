import 'package:flutter/material.dart';

class HorizontalScrollableTabs extends StatefulWidget {
  final List<String> tabTitles;

  const HorizontalScrollableTabs({Key? key, required this.tabTitles})
      : super(key: key);

  @override
  _HorizontalScrollableTabsState createState() =>
      _HorizontalScrollableTabsState();
}

class _HorizontalScrollableTabsState extends State<HorizontalScrollableTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.tabTitles.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? Colors.blue
                    : const Color.fromARGB(255, 225, 123, 123),
                border: Border.all(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.tabTitles[index],
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.white : Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
