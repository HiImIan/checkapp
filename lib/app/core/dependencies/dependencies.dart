import 'package:checkapp/app/data/repositories/tasks_repository.dart';
import 'package:checkapp/app/presenter/view_models/tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(create: (context) => TasksRepository()),
    ChangeNotifierProvider(
      create: (ctx) => TasksViewModel(tasksRepository: ctx.read()),
    ),
  ];
}
