import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:provider/provider.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final loginFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  void dispose() {
    loginFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select((AuthNotifier n) => n.error);
    final signin = context.select((AuthNotifier n) => n.signin);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (error != null)
            Text(
              error,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          TextFormField(
            controller: loginFieldController,
            decoration: const InputDecoration(
              labelText: 'Login',
              hintText: 'Enter valid login',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordFieldController,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: 'Password', hintText: 'Enter secure password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                signin(
                  context,
                  loginFieldController.text,
                  passwordFieldController.text,
                );
              }
            },
            child: const Text(
              'Login',
            ),
          )
        ],
      ),
    );
  }
}
