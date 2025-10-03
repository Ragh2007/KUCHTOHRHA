import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Color _bgColor = Colors.black;
  Color _icon = Colors.white;
  Icon icon =  Icon(Icons.light_mode_outlined);

  void color() {
    setState(() {
      _bgColor = _bgColor == Colors.white ? Colors.black : Colors.white;
      _icon = _icon == Colors.black ? Colors.white : Colors.black;

      if (_bgColor == Colors.white) {
        icon =  Icon(Icons.dark_mode_outlined);
      } else {
        icon =  Icon(Icons.light_mode_outlined);
      }
    });
  }

  void login() async{
    try{
      await auth.signInWithEmailAndPassword(email: email.text.trim(), password: pass.text.trim()
      );
      if (mounted) {
        Navigator.pushNamed(context, '/video');
      }
    }
    on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: _icon),
        backgroundColor: _bgColor,
        elevation: 0,
        actions: [
          Container(
            width: 40,
            height: 40,
            margin:  EdgeInsets.all(6),
            child: IconButton(
              onPressed: color,
              icon: icon,
              color: _icon,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Welcome Back",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orange[600], fontSize: 40),
          ),
          Image.asset("assets/TrasnparentMonotone.png", height: 100, width: 120),

           SizedBox(height: 50),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    color: _icon,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(height: 10),
                TextField(
                  controller: email,
                  style: TextStyle(color: _icon),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: _icon),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: _icon.withOpacity(0.6)),
                    prefixIcon: Icon(Icons.email, color: _icon),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _icon),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Password",
                    style: TextStyle(
                        color: _icon,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                 SizedBox(height: 10),
                TextField(
                  controller: pass,
                  obscureText: true,
                  style: TextStyle(color: _icon),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: _icon),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: _icon.withOpacity(0.6)),
                    prefixIcon: Icon(Icons.lock, color: _icon),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _icon),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),

              ],
            ),
          ),
           SizedBox(height: 20),
          ElevatedButton(onPressed: (){login();},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
              ),
              child: Text("                       Login                       ",
                  style: TextStyle(
                      color: _icon,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              )
          ),
           SizedBox(height: 80),
        ],
      ),
    );
  }
}
