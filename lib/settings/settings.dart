import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/settings/settings_item.dart';
import 'package:todo/settings/theme_sheet.dart';

import 'language_sheet.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    var locale = AppLocalizations.of(context)!;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20 , top: 45 , right: 20),
            height: mediaQuery.height*0.23,
            color: theme.primaryColor,
            width:mediaQuery.width ,
            child: Text(locale.settings, style: theme.textTheme.bodyLarge,),),

          Padding(
            padding: const EdgeInsets.only(left: 20 ,right:20 ,top: 30),
            child: SettingsItems(
                settingsOptionTitle: locale.language,
                selectedOption: appProvider.currentLocale == "en" ? "English" : "العربية",
                onOptionTap: () {
                  showLanguageSheet(context);
                }),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20 , right: 20,),
            child: SettingsItems(
                settingsOptionTitle: locale.theme_mode,
                selectedOption: appProvider.isDark() ? locale.dark : locale.light,
                onOptionTap: () {
                  showThemeSheet(context);
                }),
          ),
        ],
      )
    ;
  }

  void showLanguageSheet(context) {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeSheet(context) {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
