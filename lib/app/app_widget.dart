import 'package:checkapp/app/core/dependencies/dependencies.dart';
import 'package:checkapp/app/core/l10n/app_localizations.dart';
import 'package:checkapp/app/core/l10n/l10n.dart';
import 'package:checkapp/app/core/themes/theme.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:checkapp/app/presenter/views/tasks_page.dart';
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
        home: Builder(
          builder: (context) {
            LocalizationService.initialize(AppLocalizations.of(context)!);
            final tasksViewModel = Provider.of<TasksViewModel>(context);
            return TasksPage(tasksViewModel: tasksViewModel);
          },
        ),
      ),
    );
  }
}
