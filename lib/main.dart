import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/repositories/auth_repository.dart';
import 'cadastrar.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthRepository _repo = AuthRepository();

  final TextEditingController user$ = TextEditingController();
  final TextEditingController pass$ = TextEditingController();

  @override
  void initState() {
    this._repo.checkLoggedUser().then((value) async {
      if (value != null) {
        IdTokenResult tokenResult = await value.getIdToken(refresh: true);
        print(tokenResult.token);
        print(tokenResult.expirationTime);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(repo: this._repo)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
            ),
            TextField(
              controller: this.user$,
            ),
            TextField(
              controller: this.pass$,
            ),
            RaisedButton(
              child: Text("Entrar"),
              onPressed: () async {
                FirebaseUser user =
                    await this._repo.emailPassLogIn(user$.text, pass$.text);
                if (user != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                repo: this._repo,
                              )));
                } else {
                  print("erro");
                }
              },
            ),
            RaisedButton(
              child: Text("Google Login"),
              onPressed: () async {
                FirebaseUser user = await this._repo.googleLogIn();
                if (user != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                repo: this._repo,
                              )));
                } else {
                  print("erro");
                }
              },
            ),
            FlatButton(
              child: Text("Cadastrar"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastrarPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
