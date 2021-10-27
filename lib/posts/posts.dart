import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inifity_list_with_provider/posts/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:inifity_list_with_provider/posts/view/post_list.dart';
import 'package:inifity_list_with_provider/posts/widgets/post_list_item.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: PostsList(),
      ),
    );
  }
}
