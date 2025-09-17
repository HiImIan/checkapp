import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @tasksManager.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciador de Tarefas'**
  String get tasksManager;

  /// No description provided for @loading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando tarefas'**
  String get loading;

  /// Erro ao carregar as tarefas
  /// ({error})
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar as tarefas\n{error}'**
  String errorList(String error);

  /// No description provided for @reload.
  ///
  /// In pt, this message translates to:
  /// **'Recarregar'**
  String get reload;

  /// No description provided for @total.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @pendent.
  ///
  /// In pt, this message translates to:
  /// **'Pendentes'**
  String get pendent;

  /// No description provided for @completed.
  ///
  /// In pt, this message translates to:
  /// **'Concluídas'**
  String get completed;

  /// No description provided for @searchTasks.
  ///
  /// In pt, this message translates to:
  /// **'Buscar tarefas...'**
  String get searchTasks;

  /// Todas ({value})
  ///
  /// In pt, this message translates to:
  /// **'Todas ({value})'**
  String allTasksValue(String value);

  /// No description provided for @pendentTasksValue.
  ///
  /// In pt, this message translates to:
  /// **'Pendentes ({value})'**
  String pendentTasksValue(Object value);

  /// Concluídas ({value})
  ///
  /// In pt, this message translates to:
  /// **'Concluídas ({value})'**
  String completedtTasksValue(String value);

  /// No description provided for @editTask.
  ///
  /// In pt, this message translates to:
  /// **'Editar Tarefa'**
  String get editTask;

  /// No description provided for @newTask.
  ///
  /// In pt, this message translates to:
  /// **'Nova Tarefa'**
  String get newTask;

  /// No description provided for @title.
  ///
  /// In pt, this message translates to:
  /// **'Título *'**
  String get title;

  /// No description provided for @enterTitle.
  ///
  /// In pt, this message translates to:
  /// **'Digite o título'**
  String get enterTitle;

  /// No description provided for @description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição (opcional)'**
  String get description;

  /// No description provided for @enterDescription.
  ///
  /// In pt, this message translates to:
  /// **'Digite a descrição'**
  String get enterDescription;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Criado em
  /// {createdAt}
  ///
  /// In pt, this message translates to:
  /// **'Criado em\n{createdAt}'**
  String createdAt(String createdAt);

  /// Editado em
  /// {editedAt}
  ///
  /// In pt, this message translates to:
  /// **'Editado em\n{editedAt}'**
  String editedAt(String editedAt);

  /// Concluído em
  /// {completedAt}
  ///
  /// In pt, this message translates to:
  /// **'Concluído em\n{completedAt}'**
  String completedAt(String completedAt);

  /// No description provided for @addFirstTask.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma tafera encontrada'**
  String get addFirstTask;

  /// No description provided for @failedToInicialize.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao iniciar'**
  String get failedToInicialize;

  /// No description provided for @failedToLoad.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao carregar tarefas'**
  String get failedToLoad;

  /// No description provided for @failedToUpdate.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao atualizar tarefa'**
  String get failedToUpdate;

  /// No description provided for @failedToAdd.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao adicionar tarefa'**
  String get failedToAdd;

  /// No description provided for @failedToDelete.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao remover tarefa'**
  String get failedToDelete;

  /// No description provided for @failedToToggleStatus.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao alterar status da tarefa'**
  String get failedToToggleStatus;

  /// No description provided for @failedToSearch.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao procurar tarefa'**
  String get failedToSearch;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
