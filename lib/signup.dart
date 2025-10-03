import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Color _bgColor = Colors.black;
  Color _icon = Colors.white;
  Icon icon = const Icon(Icons.light_mode_outlined);

  void color() {
    setState(() {
      _bgColor = _bgColor == Colors.white ? Colors.black : Colors.white;
      _icon = _icon == Colors.black ? Colors.white : Colors.black;

      if (_bgColor == Colors.white) {
        icon = const Icon(Icons.dark_mode_outlined);
      } else {
        icon = const Icon(Icons.light_mode_outlined);
      }
    });
  }

  void signup() async {
    if(email.text.trim().isEmpty || pass.text.trim().isEmpty || confirmPass.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Empty Field Found")),
      );
      return;
    }
    if (pass.text.trim() != confirmPass.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    if(!pass.text.trim().contains(RegExp(r'[A-Z]'))||!pass.text.trim().contains(RegExp(r'[a-z]'))||!pass.text.trim().contains(RegExp(r'[1-9]'))){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords Must have 1 UpperCase, 1 LowerCase & 1 Number ＞﹏＜")),
      );
      return;
    }
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully!")),
      );
    } on FirebaseAuthException catch (e) {
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
            margin: const EdgeInsets.all(6),
            child: IconButton(
              onPressed: color,
              icon: icon,
              color: _icon,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "Welcome To",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orange[600], fontSize: 40),
          ),
          Image.asset("assets/TrasnparentMonotone.png", height: 100, width: 120),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",
                    style: TextStyle(
                        color: _icon,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
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
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Password",
                    style: TextStyle(
                        color: _icon,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          title: const Text("Password Requirements"),
                          content: const Text(
                            "• At least 1 uppercase letter\n"
                                "• At least 1 lowercase letter\n"
                                "• At least 1 number\n"
                                "• Minimum 8 characters",
                          ),
                        );
                      },
                    );
                  },
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
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Confirm Password",
                    style: TextStyle(
                        color: _icon,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  controller: confirmPass,
                  obscureText: true,
                  style: TextStyle(color: _icon),
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: _icon),
                    hintText: "Re-enter your password",
                    hintStyle: TextStyle(color: _icon.withOpacity(0.6)),
                    prefixIcon: Icon(Icons.lock_outline, color: _icon),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _icon),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: signup,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[600],
            ),
            child: Text(
              "                   Sign Up                   ",
              style: TextStyle(
                  color: _icon, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: (){Navigator.pushNamed(context, '/log');},
              child: Text("Already Signed UP !! \nLog In :)",textAlign: TextAlign.center,style: TextStyle(color: Colors.orange[600]),)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
