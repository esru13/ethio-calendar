import 'package:ethio_calend/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDropdown extends StatefulWidget {
  final VoidCallback? onLanguageChanged;

  const LanguageDropdown({Key? key, this.onLanguageChanged}) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: context.locale,
      onChanged: (locale) {
        if (locale != null) {
          setState(() {
            context.setLocale(locale);
            widget.onLanguageChanged?.call();

            Navigator.pushReplacement(
              context, MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );

          });
        }
      },
      items: context.supportedLocales.map((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(locale.languageCode),
        );
      }).toList(),
    );
  }
}
