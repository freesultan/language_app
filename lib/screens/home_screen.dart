import 'package:flutter/material.dart';
import 'package:language_app/screens/auth_screen.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:language_app/states/user_state.dart'; // Import the UserState class
import 'package:provider/provider.dart';
 

import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
    

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      drawer: _buildLeftDrawer(context),
      endDrawer: _buildRightDrawer(context),
      body: Center(
        child: userState.email != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO: add a widget based on the current user
                     const SizedBox(height: 20),
                    const Spacer(),
                    const BottomNavBar(),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/flesh.json',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome to Language Learning App, please sign in',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                ],
              ),
      ),
    );
  }
}

PreferredSizeWidget? _buildAppBar(BuildContext context) {
   final colorScheme = Theme.of(context).colorScheme;
     final userState = Provider.of<UserState>(context);

  if ( userState.email != null) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Hello, ${userState!.username}'),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              userState.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: colorScheme.primary,
      elevation: 10,
    );
  } else {
    return AppBar(
      title: const Text('LangStar'),
      backgroundColor: colorScheme.secondary,
      elevation: 10,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.ads_click),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Information'),
                  content: Card(
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'This is a language learning app.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

}

 Drawer _buildLeftDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Sign up'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              // Handle support action
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Handle about us action
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Preferences'),
            onTap: () {
              // Handle preferences action
            },
          ),
        ],
      ),
    );
  }

  Drawer _buildRightDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Add more items to the right drawer if needed
        ],
      ),
    );
  }
