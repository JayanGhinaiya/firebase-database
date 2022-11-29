import 'package:firebase/Registarion/sign%20in%20screen.dart';
import 'package:firebase/firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final String name;
  final String image;
  final String id;
  final String email;
  final String password;
  const SignUpScreen({Key? key, required this.name, required this.image, required this.id, required this.email, required this.password,}) : super(key: key);


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ClipOval(
              child: Image.network(widget.image)),
            Text(widget.email),
            Text(widget.password),
            Text(widget.name),
            Text(widget.id),
            MaterialButton(
              child: Text("LogOut"),
                onPressed: (){
                showDialog(context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("LogOut"),
                      content: Text("Are You Soure Logout ? "),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Cancle")),
                        TextButton(
                            onPressed: (){
                              Navigator.of(ctx).push(
                                  MaterialPageRoute(builder: (context) => SignInscreen()));
                            },
                            child: Text("Ok"))
                      ],
                    ));
                Authintication.signOut();
                }
            ),
          ],
        ),
      ),
    );
  }
}
