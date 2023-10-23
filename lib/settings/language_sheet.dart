import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo/settings/selected_option.dart';
import 'package:todo/settings/unselected_option.dart';

import '../providers/list_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                appProvider.changeLanguage("en");
                Navigator.pop(context);
              },
              child: appProvider.currentLocale == "en"
                  ? SelectedOption(selectedTitle: "English")
                  : UnSelectedOption(unSelectedtitle: "English")),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: () {
                appProvider.changeLanguage("ar");
                Navigator.pop(context);
              },
              child: appProvider.currentLocale == "ar"
                  ? SelectedOption(selectedTitle: "العربية")
                  : UnSelectedOption(unSelectedtitle: "العربية"))
        ],
      ),
    );
  }
}
