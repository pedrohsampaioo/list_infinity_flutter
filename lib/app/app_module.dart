import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_infinita_conteudo/app/app_widget.dart';
import 'package:lista_infinita_conteudo/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
      ];
}
