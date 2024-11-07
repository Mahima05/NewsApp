import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'news_screen.dart';

class LoginScreen extends StatefulWidget {
  final TextStyle emailLabelStyle;
  final TextStyle passwordLabelStyle;
  final TextStyle buttonTextStyle;
  final TextStyle titleTextStyle;

  LoginScreen({
    this.titleTextStyle = const TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Times New Roman', fontWeight: FontWeight.bold),
    this.emailLabelStyle = const TextStyle(fontSize: 20.0, color: Colors.red, fontFamily: 'Times New Roman', fontWeight: FontWeight.bold),
    this.passwordLabelStyle = const TextStyle(fontSize: 20.0, color: Colors.red, fontFamily: 'Times New Roman', fontWeight: FontWeight.bold),
    this.buttonTextStyle = const TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Times New Roman', fontWeight: FontWeight.bold),
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordLengthValid = false;
  bool isPasswordNumberValid = false;

  String? validateEmailOrPhone(String value) {
    if (value.isEmpty) {
      return "Please enter an email or phone number.";
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (phoneRegExp.hasMatch(value)) {
      return null;
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (emailRegExp.hasMatch(value)) {
      return null;
    }
    return "Please enter a valid email or 10-digit phone number.";
  }

  String? validatePassword(String value) {
    setState(() {
      isPasswordLengthValid = value.length >= 6;
      isPasswordNumberValid = RegExp(r'\d').hasMatch(value);
    });

    if (!isPasswordLengthValid) return "Password must be at least 6 characters long.";
    if (!isPasswordNumberValid) return "Password must contain at least one number.";
    return null;
  }

  Future<void> saveUserData(String emailOrPhone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('emailOrPhone', emailOrPhone);
    prefs.setString('password', password);
    prefs.setStringList('bookmarks', []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: widget.titleTextStyle),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email/Mobile",
                  labelStyle: widget.emailLabelStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => validateEmailOrPhone(value ?? ''),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: widget.passwordLabelStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                obscureText: true,
                onChanged: (value) => validatePassword(value),
                validator: (value) => validatePassword(value ?? ''),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• Password should be more than 6 characters",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                      color: isPasswordLengthValid ? Colors.green : Colors.black,
                    ),
                  ),
                  Text(
                    "• Password should contain at least 1 number",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                      color: isPasswordNumberValid ? Colors.green : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final emailOrPhone = emailController.text;
                  final password = passwordController.text;

                  final emailOrPhoneError = validateEmailOrPhone(emailOrPhone);
                  final passwordError = validatePassword(password);

                  if (emailOrPhoneError == null && passwordError == null) {
                    await saveUserData(emailOrPhone, password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(emailOrPhoneError ?? passwordError ?? '')),
                    );
                  }
                },
                child: Text("Sign In", style: widget.buttonTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}