import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/user_service.dart';
import 'package:invapp/widgets/list_tile_widget.dart';

class UserListScreen extends StatelessWidget {
  final _userSvc = new UserService();
  final textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userSvc.getUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: SingleChildScrollView(
        child: listUsers(),
      ),
    );
  }

  StreamBuilder<List<User>> listUsers() {
    return StreamBuilder<List<User>>(
        stream: _userSvc.userStream,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) return Center(child: CircularProgressIndicator());

          List listStream = snapshot.data;
          List<Widget> listUsers = [];

          for (final data in listStream) {
            listUsers.add(_groupTile(context, data));
          }
          return Wrap(alignment: WrapAlignment.start, children: listUsers);
        });
  }

  _groupTile(context, User user) {
    return ListTileCustom(
        // iconName: 'FAcode',
        title: Text(user.name),
        // subtitle: Text( user.action ),
        onTap: () => Navigator.pushNamed(context, 'user-detail', arguments: user));
  }
}
