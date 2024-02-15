import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loggedIn = false;
  String? name;

  void _validate(){
    final form = _formKey.currentState;
    if (!form!.validate()){
      return ;
    }
    setState(() {
      loggedIn = true;
      name = _nameController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page"),),
      body: Center(
        child: loggedIn ?  _buildSuccess(context): _buildLoginForm(context),
      ),
    );
  }
  Widget _buildSuccess(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check, color: Colors.orangeAccent,),
        Text("hii $name"),
      ],

    );
  }
  Widget _buildLoginForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Runner"),
              validator: (text) => text!.isEmpty ? "Enter the Runner\'s name." : null,
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (text) {
                if (text!.isEmpty){
                  return "Enter the Runner\'s Email.";
                }
                final regex = RegExp("[^@]+@[^\.]+\..+");
                if (!regex.hasMatch(text)){
                  return "Enter the Valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blueGrey),
                backgroundColor: MaterialStateProperty.all(Colors.yellowAccent),
              ),
              onPressed: _validate,
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
