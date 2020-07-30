import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/repositories/auth_repository.dart';

class HomePage extends StatefulWidget {
  final AuthRepository repo;

  const HomePage({Key key, this.repo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await this.widget.repo.logoff();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(title: 'Back from Home Page'),
                  ));
            },
          )
        ],
      ),
      body: Center(
        child: Text("Hello, World!"),
      ),
    );
  }
}
