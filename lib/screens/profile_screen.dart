import 'package:flutter/material.dart';
import 'package:language_app/states/user_state.dart'; // Import the UserState class

import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userState.avatarUrl),
            ),
            SizedBox(height: 20),
            
            Text(
              userState.username!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10),
            Text(
              userState.email!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Edit profile'),
            ),
          ],
        ),
      ),
    );
  }
}
