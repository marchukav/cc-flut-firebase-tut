import 'package:firebasetut1/api/food_api.dart';
import 'package:firebasetut1/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building feed screen');
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(authNotifier.user != null
            ? authNotifier.user!.displayName!
            : 'Feed'),
        actions: [
          TextButton(
              onPressed: () => signOut(authNotifier),
              child: Text(
                'logOut',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Text(
          'Feed',
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
