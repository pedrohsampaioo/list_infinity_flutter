part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  Stream<PostState> execute(PostRepository repository, PostState state);
}

class PostFetch extends PostEvent {
  final int initial, amount;

  const PostFetch({
    @required this.initial,
    @required this.amount,
  });

  @override
  List<Object> get props => [initial, amount];

  @override
  Stream<PostState> execute(PostRepository repository, PostState state) async* {
    yield PostLoading();
    try {
      final posts = await repository.fetch(initial, amount);
      if (state is PostInitial) {
        yield PostLoaded(listPost: posts);
      } else if (state is PostLoaded) {
        yield PostLoaded(listPost: posts);
      }
    } catch (e) {
      yield PostError(message: e.toString());
    }
  }
}
