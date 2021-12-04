import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:examenfinal/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:examenfinal/models/token.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEB3B),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                _showGoogleLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }





  Widget _showGoogleLoginButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _loginGoogle(),
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            label: Text('Iniciar sesión con Google'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black
            )
          )
        )
      ],
    );
  }

  void _loginGoogle() async {

    var googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    var user = await googleSignIn.signIn();

    Map<String, dynamic> request = {
      'email': user?.email,
      'id': user?.id,
      'loginType': 1,
      'fullname': user?.displayName,
      'photoURL': user?.photoUrl,
    };

    if (user == null) {
 
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: 'Hubo un problema al obtener el usuario de Google, por favor intenta más tarde.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    await _socialLogin(request);
  }



  Future _socialLogin(Map<String, dynamic> request) async {
    var url = Uri.parse('https://vehicleszulu.azurewebsites.net/api/account/SocialLogin');
    var response = await http.post(
      url,
      headers: {
        'content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(request)
    );


    if (response.statusCode >= 400) {
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: 'El usuario ya inició sesión previamente por email o por otra red social',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar')
        ]
      );
      return;
    }

    var body = response.body;


    var decodedJson = jsonDecode(body);
    var token = Token.fromJson(decodedJson);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(token: token)
      )
    );
  }
}