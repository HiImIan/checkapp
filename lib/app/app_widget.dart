import 'package:checkapp/app/core/dependencies/dependencies.dart';
import 'package:checkapp/app/core/l10n/app_localizations.dart';
import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/core/themes/theme.dart';
import 'package:checkapp/app/presenter/views/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.theme,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('pt'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          LocalizationService.initialize(AppLocalizations.of(context)!);
          return TasksPage();
        },
      ),
    );
  }
}
