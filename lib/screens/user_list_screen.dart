import 'package:flutter/material.dart';
import 'package:language_app/core/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:language_app/core/models/user.dart';
import 'package:language_app/widgets/decklist_widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late AuthService authservice;

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    authservice = Provider.of<AuthService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
     List<User> users = authservice.userBox.values
        .where((user) => user.username.contains(_searchText))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(  
              title: Text(users[index].username),
              onTap: () {
                  print('Selected User: ${users[index].username}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeckListWidget(user: users[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
