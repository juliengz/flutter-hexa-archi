import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = context.select((AuthNotifier n) => n.currentUser);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello ${currentUser?.name} :)'),
            const Text('Welcome to hexagonal architecture app'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('signout'),
        onPressed: () {
          context.read<AuthNotifier>().signout(context);
        },
        tooltip: 'Signout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
