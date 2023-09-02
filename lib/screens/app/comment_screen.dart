import 'dart:io';

import 'package:app_api/api/controllers/comment_api_controller.dart';
import 'package:app_api/models/comment.dart';
import 'package:app_api/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Comments'),

      ),
      body: FutureBuilder<List<Comment>>(
        // future: UserApiController().getUsers(),
        future:  CommentApiController().getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return RefreshWidget(
              keyRefresh: keyRefresh,
              onRefresh: () => CommentApiController().getComments(),
              child: ListView.builder(
                shrinkWrap: true,
                primary: Platform.isAndroid ? true : false,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black,
                      // backgroundImage: NetworkImage(snapshot.data![index].name),
                      radius: 40,
                    ),
                    title: Text(snapshot.data![index].email),
                    subtitle: Text(snapshot.data![index].body),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
