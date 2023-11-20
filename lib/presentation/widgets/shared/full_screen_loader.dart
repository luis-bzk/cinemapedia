import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final List<String> messages = [
      'Cargando películas',
      'Comprando las palomitas',
      'Esto podia demorar un momento',
      'Ya casi esta todo listo',
    ];

    return Stream.periodic(const Duration(microseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("data"),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: getLoadingMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando...');
                return Text(snapshot.data!);
              },
            )
          ]),
    );
  }
}
