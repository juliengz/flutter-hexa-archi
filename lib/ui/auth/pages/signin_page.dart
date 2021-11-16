import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/signin_notifier.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((SigninNotifier n) => n.isLoading);
    final tokens = context.select((SigninNotifier n) => n.tokens);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16.0),
            const Icon(
              Icons.wine_bar_rounded,
              size: 100.0,
              color: Colors.pink,
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                  hintText: 'Enter valid login'),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SigninNotifier>().signin();
                if (!isLoading && tokens != null) {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Create a new account',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
