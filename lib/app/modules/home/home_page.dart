import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_infinita_conteudo/app/modules/home/bloc/post/post_bloc.dart';
import 'package:lista_infinita_conteudo/app/shared/models/post_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> _listPost = <Post>[];
  final PostBloc _blocInfinitePost = Modular.get<PostBloc>();
  final _scrollController = ScrollController();
  double maxHeight;

  @override
  void initState() {
    super.initState();
    _blocInfinitePost.add(PostFetch(initial: 0, amount: 10));
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _blocInfinitePost.close();
    super.dispose();
  }

  _handleScroll() async {
    print("scroll: " + _scrollController.offset.toString());
    print("max: " + _scrollController.position.maxScrollExtent.toString());
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        _blocInfinitePost.state is PostLoaded) {
      _blocInfinitePost.add(PostFetch(initial: 0, amount: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinity posts"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<PostBloc, PostState>(
        bloc: _blocInfinitePost,
        builder: (_, state) {
          bool _handleLoading = false;
          if (state is PostLoaded) {
            state.listPost.forEach((post) => _listPost.add(post));
          } else if (state is PostLoading) {
            _handleLoading = true;
          }
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (_, index) {
              maxHeight = MediaQuery.of(context).size.height;
              if (_handleLoading && index == _listPost.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListTile(
                  title: Text(_listPost[index].title),
                  subtitle: Text(_listPost[index].body),
                );
              }
            },
            itemCount: _handleLoading ? _listPost.length + 1 : _listPost.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _blocInfinitePost.add(PostFetch(initial: 0, amount: 5));
        },
      ),
    );
  }
}
