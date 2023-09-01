import 'dart:io';

import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/api/controllers/users_api_controller.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/user.dart';
import 'package:app_api/pref/shared_pref_controller.dart';
import 'package:app_api/widgets/refresh_widget.dart';
import 'package:app_api/widgets/serach_app.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  late TextEditingController _textEditingController;
  late String textSearch;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users'),
        actions: [
          IconButton(onPressed: () async {
            ApiRespones respones = await AuthApiController().logOut();
            if (respones.status) {
              SharedPrfController().clear();
              Navigator.pushReplacementNamed(context, '/login_screen');
            }
          }, icon: Icon(Icons.logout)),
          IconButton(onPressed: ()  {
            Navigator.pushNamed(context, '/comment_screen');
          }, icon: Icon(Icons.comment)),
          IconButton(onPressed: ()  {
            Navigator.pushNamed(context, '/images_screen');
          }, icon: Icon(Icons.image)),
        ],
      ),
      body: Column(
        children: [
          SearchApp(controller: _textEditingController, hintText: 'search Name', onPressed: (){},onChange: (p0) {
            setState(() {
              textSearch = p0;
            });
          },),
          Expanded(
            child: FutureBuilder<List<User>>(
              // future: UserApiController().getUsers(),
              future: _textEditingController.text.isEmpty ? UserApiController().getUsers():UserApiController().getUsersSearch(firstName: _textEditingController.text, jobTitle: 'Medical'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return RefreshWidget(
                    keyRefresh: keyRefresh,
                    onRefresh: () => UserApiController().getUsers(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: Platform.isAndroid ? true : false,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(snapshot.data![index].image),
                            radius: 40,
                          ),
                          title: Text(snapshot.data![index].firstName),
                          subtitle: Text(snapshot.data![index].email),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
