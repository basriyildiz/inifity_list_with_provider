import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inifity_list_with_provider/posts/bloc/post_bloc.dart';
import 'package:inifity_list_with_provider/posts/widgets/bottom_loader.dart';
import 'package:inifity_list_with_provider/posts/widgets/post_list_item.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text("failed to fetch posts"));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text("no posts"));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostListItem(post: state.posts[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollController,
              );
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * .9);
  }
}
