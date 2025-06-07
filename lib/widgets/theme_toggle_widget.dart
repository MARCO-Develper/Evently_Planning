import 'package:evently/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyProvider>(context);
    bool isLight = themeProvider.themeMode == ThemeMode.light;

    return GestureDetector(
      onTap: () {
        themeProvider.changeTheme();  // هينادي تغيير الثيم صح
      },
      child: Column(
        children: [
          Container(
            width: 90,
            height: 39,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.transparent,
              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircle(context, isLight, true, "assets/images/icons/Sun.png"),
                _buildCircle(context, isLight, false, "assets/images/icons/Moon.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(BuildContext context, bool isLight, bool circleIsLight, String iconPath) {
    bool isActive = isLight == circleIsLight;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 35,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
        border: Border.all(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(child: Image.asset(iconPath)),
    );
  }
}
