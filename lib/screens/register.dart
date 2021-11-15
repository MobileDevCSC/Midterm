import 'package:flutter/material.dart';
import 'package:midterm/provider/auth_provider.dart';
import 'package:midterm/screens/home.dart';
import 'package:midterm/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: isLoading == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          AuthClass()
                              .createAccount(
                                  email: _email.text.trim(),
                                  password: _password.text.trim())
                              .then((value) {
                            if (value == "Account Created") {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(value)));
                            }
                          });
                        },
                        child: Text("Create Account")),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("Already have an account? Login")),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
