import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale.languageCode == 'en';
    final provider = Provider.of<LanguageProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => provider.toggleLanguage(context),
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
                _buildFlag(context, isEnglish, true, "assets/images/icons/EN.png"),
                _buildFlag(context, isEnglish, false, "assets/images/icons/EG.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlag(BuildContext context, bool isEnglish, bool flagIsEnglish, String iconPath) {
    bool isActive = isEnglish == flagIsEnglish;
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
