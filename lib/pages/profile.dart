import 'package:dokan/pages/signin.dart';
import 'package:dokan/utils/storage/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefs.setBool("authenticated", false);
              SharedPrefs.setString("token", "");
              SharedPrefs.setString("username", "");
              SharedPrefs.setString("email", "");
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Logged Out.")));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => SigninPage()),
                  (val) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
