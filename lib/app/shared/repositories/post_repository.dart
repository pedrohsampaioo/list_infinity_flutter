import 'package:dio/dio.dart';
import 'package:lista_infinita_conteudo/app/shared/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetch(int initial, int amount);
}

class PostRepositoryIMPL implements PostRepository {
  final Dio client;
  const PostRepositoryIMPL({
    this.client,
  });

  @override
  Future<List<Post>> fetch(int initial, int amount) async {
    try {
      final result = await client.get(
          "https://jsonplaceholder.typicode.com/posts?_start=$initial&_limit=$amount");
      List<Post> listPost = <Post>[];
      for (final post in result.data) {
        listPost.add(Post.fromJson(post));
      }
      return listPost;
    } catch (e) {
      throw e;
    }
  }
}
