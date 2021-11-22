import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:flutter_clean_archi/ui/home/notifiers/home_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example with provider'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            _showBody(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('signout'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () {
          context.read<AuthNotifier>().signout(context);
        },
        tooltip: 'Signout',
        child: const Icon(Icons.logout),
      ),
    );
  }

  Widget _showLoadButton(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.read<HomeNotifier>().signin(),
      child: const Text("Load data"),
      color: Colors.blue,
    );
  }

  Widget _showBody(BuildContext context) {
    final isLoading = context.select((HomeNotifier n) => n.isLoading);
    final error = context.select((HomeNotifier n) => n.error);
    final tokens = context.select((HomeNotifier n) => n.tokens);

    if (!isLoading && tokens == null) {
      return _showLoadButton(context);
    } else if (isLoading) {
      return const CircularProgressIndicator();
    } else if (!isLoading && tokens != null) {
      return Text(tokens.toString());
    } else if (error != null) {
      return Container();
    } else {
      return Container();
    }
  }
}

// class Count extends StatelessWidget {
//   const Count({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final count = context.select((HomeNotifier n) => n.count);

//     return Text(

//         /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
//         '$count',
//         key: const Key('counterState'),
//         style: Theme.of(context).textTheme.headline4);
//   }
// }
