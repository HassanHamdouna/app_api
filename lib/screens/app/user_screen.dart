import 'dart:io';

import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/api/controllers/users_api_controller.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/user.dart';
import 'package:app_api/pref/shared_pref_controller.dart';
import 'package:app_api/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users'),
        actions: [
          IconButton(onPressed: () async{
            ApiRespones respones = await AuthApiController().logOut();
            if(respones.status){
              SharedPrfController().clear();
              Navigator.pushReplacementNamed(context, '/login_screen');
            }
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UserApiController().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return RefreshWidget(
              keyRefresh: keyRefresh,
              onRefresh: ()=> UserApiController().getUsers(),
              child: ListView.builder(
                shrinkWrap: true,
                primary: Platform.isAndroid? true: false,
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
    );
  }
}
