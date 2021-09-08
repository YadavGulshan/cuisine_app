import 'package:cuisine_app/provider/authstream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String name = "";
  String email = "";
  String picture = "";
  void loadData() async {
    final mem = await SharedPreferences.getInstance();
    setState(() {
      name = mem.getString("name").toString();
      // debugPrint(mem.getString("name"));
      email = mem.getString("email").toString();
      picture = mem.getString("picture").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    AuthState provider = Provider.of<AuthState>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(picture),
              // backgroundImage:
            ),
            Text(name),
            Text("Email:" + email),
            // Text(provider.username),
            Text("isLoggedIn: " + provider.isLoggedIn.toString()),
            Text("isbusy: " + provider.isbusy.toString()),
            TextButton(
                onPressed: () {
                  provider.logoutAction();
                },
                child: const Text("Logut"))
          ],
        ),
      ),
    );
  }
}
