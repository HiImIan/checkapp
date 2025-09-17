// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get tasksManager => 'Gerenciador de Tarefas';

  @override
  String get loading => 'Carregando tarefas';

  @override
  String errorList(String error) {
    return 'Erro ao carregar as tarefas\n$error';
  }

  @override
  String get reload => 'Recarregar';

  @override
  String get total => 'Total';

  @override
  String get pendent => 'Pendentes';

  @override
  String get completed => 'Concluídas';

  @override
  String get searchTasks => 'Buscar tarefas...';

  @override
  String allTasksValue(String value) {
    return 'Todas ($value)';
  }

  @override
  String pendentTasksValue(Object value) {
    return 'Pendentes ($value)';
  }

  @override
  String completedtTasksValue(String value) {
    return 'Concluídas ($value)';
  }

  @override
  String get editTask => 'Editar Tarefa';

  @override
  String get newTask => 'Nova Tarefa';

  @override
  String get title => 'Título *';

  @override
  String get enterTitle => 'Digite o título';

  @override
  String get description => 'Descrição (opcional)';

  @override
  String get enterDescription => 'Digite a descrição';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String createdAt(String createdAt) {
    return 'Criado em\n$createdAt';
  }

  @override
  String editedAt(String editedAt) {
    return 'Editado em\n$editedAt';
  }

  @override
  String completedAt(String completedAt) {
    return 'Concluído em\n$completedAt';
  }

  @override
  String get addFirstTask => 'Nenhuma tafera encontrada';

  @override
  String get failedToInicialize => 'Falha ao iniciar';

  @override
  String get failedToLoad => 'Falha ao carregar tarefas';

  @override
  String get failedToUpdate => 'Falha ao atualizar tarefa';

  @override
  String get failedToAdd => 'Falha ao adicionar tarefa';

  @override
  String get failedToDelete => 'Falha ao remover tarefa';

  @override
  String get failedToToggleStatus => 'Falha ao alterar status da tarefa';

  @override
  String get failedToSearch => 'Falha ao procurar tarefa';
}
