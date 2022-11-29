import 'package:firebase/firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase_auth/sign%20up%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInscreen extends StatefulWidget {
  const SignInscreen({Key? key}) : super(key: key);

  @override
  State<SignInscreen> createState() => _SignInscreenState();
}

class _SignInscreenState extends State<SignInscreen> {
  bool obscuretext = true;
TextEditingController password =TextEditingController();
TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.green,
            height: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "UserName"
                  ),
                ),
                TextField(
                  obscureText: obscuretext,
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: (){
                          obscuretext = !obscuretext;
                          setState(() {});
                        },
                        icon: Icon(obscuretext ? Icons.visibility_off : Icons.visibility)
                  ),

                ),
                ),
                 MaterialButton(
                   color: Colors.blue,
                     onPressed: (){
                     Authintication.signInWithEmail(email:email.text ,password:password.text ).then((user) => Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) =>SignUpScreen(email:user!.displayName!,password:user.email!, name: '', id: '', image: '' ,) )
                     ));
                     },
                 child: Text("Login",style: TextStyle(color: Colors.white)),
                 ),
                 Center(
                   child: SignInButton(
                    Buttons.Google,
                   onPressed: (){
                    Authintication.signinInWithGoogle1().then((user) =>  Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpScreen(name: user!.displayName!,image: user.photoURL!, id: user.email!, password: '', email: '',))
                    ));
                  },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
