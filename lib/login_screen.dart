import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = "/login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool loggedIn = false;
  String? name;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _validate(){
    final form = _formKey.currentState;
    if (!form!.validate()){
      return;
    }
    // setState(() {
    //   loggedIn = true;
    //   name = _nameController.text;
    // });
    final name = _nameController.text;
    // final email = _emailController.text;
    Navigator.of(context).pushReplacementNamed(
      StopWatch.route,
      arguments: name,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(child : _buildLoginForm(context)),
    );
  }
  Widget _buildLoginForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (text) => text!.isEmpty ? "Enter the name ": null,
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (text) {
                if (text!.isEmpty){
                  return "Enter the Email";
                }
                final regex = RegExp("[^@]+@[^\.]+\..+");
                if (!regex.hasMatch(text)){
                  return "Enter a valid email";
                }
              },
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.greenAccent),
              ),
                onPressed: _validate,
                child: const Text(
                    "Continue",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
