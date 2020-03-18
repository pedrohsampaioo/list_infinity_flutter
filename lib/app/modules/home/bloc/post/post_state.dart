part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> listPost;

  const PostLoaded({
    @required this.listPost,
  });
  @override
  List<Object> get props => [listPost];
}

class PostError extends PostState {
  final String message;

  const PostError({
    @required this.message,
  });

  @override
  List<Object> get props => [];
}
