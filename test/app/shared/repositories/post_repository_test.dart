import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_infinita_conteudo/app/shared/repositories/post_repository.dart';

main() {
  Dio client;
  PostRepository repository;

  setUp(() {
    client = Dio();
    repository = PostRepositoryIMPL(client: client);
  });

  group("Teste unitário do post_repository", (){
    test("Verifica se o primeiro post está vindo corretamente", ()async{
      final result = await repository.fetch(0,10);
      final post = result[0];
      expect(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit");
    });
  });
}
