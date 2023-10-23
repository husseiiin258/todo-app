import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/settings/selected_theme.dart';
import 'package:todo/settings/unselected_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<ListProvider>(context);
    var locale = AppLocalizations.of(context)!;
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
                appProvider.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: appProvider.isDark()
                  ? SelectedTheme(selectedTitle: locale.dark)
                  : UnSelectedTheme(unSelectedtitle: locale.dark)),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: () {
                appProvider.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: appProvider.isDark()
                  ? UnSelectedTheme(unSelectedtitle: locale.light)
                  : SelectedTheme(selectedTitle: locale.light))
        ],
      ),
    );
  }
}
