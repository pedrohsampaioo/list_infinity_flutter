import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_infinita_conteudo/app/modules/home/bloc/post/post_bloc.dart';
import 'package:lista_infinita_conteudo/app/modules/home/home_page.dart';
import 'package:lista_infinita_conteudo/app/shared/repositories/post_repository.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => PostRepositoryIMPL(client: i.get<Dio>())),
        Bind((i) => PostBloc(repository: i.get<PostRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];
}
