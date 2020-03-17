import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Post extends Equatable {
  int id;
  String title;
  String body;

  Post({
    @required this.id,
    @required this.title,
    @required this.body,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  @override
  List<Object> get props => [id, title, body];
}
