import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/repositories/auth_repository.dart';

import './home_page.dart';

class CadastrarPage extends StatefulWidget {
  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final AuthRepository _repo = AuthRepository();

  final TextEditingController user$ = TextEditingController();
  final TextEditingController pass$ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            controller: user$,
          ),
          TextField(
            controller: pass$,
          ),
          RaisedButton(
            child: Text("Criar conta"),
            onPressed: () async {
              FirebaseUser user =
                  await this._repo.emailPassSignIn(user$.text, pass$.text);
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
          )
        ],
      ),
    );
  }
}
