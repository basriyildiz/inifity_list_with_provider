import 'package:flutter/material.dart';
import 'package:inifity_list_with_provider/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Material(
        child: ListTile(
      leading: Text(post.id.toString(), style: _textTheme.caption),
      title: Text(
        post.title,
        style: _textTheme.headline6,
      ),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    ));
  }
}
