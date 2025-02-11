import 'package:flutter/material.dart';
import 'Quizz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'It\'s quiz Time'),
      routes: {
        '/home': (context) =>
            MyHomePage(
              title: 'On s\'en refait une ?',
            ),
        '/quiz_page': (context) => const QuizzPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: SizedBox(
                height: 360,
                width: 300,
                child: Column(
                  children: [
                    const Text(
                      'Tu t\'y connais un peu \n en Rock ?',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image:
                          const AssetImage('assets/images/emilien.jpg'),
                          height: 200,
                          width: 200,
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tu veux te tester ?',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/quiz_page', arguments: {'theme' : 'rock'});
                          },
                          child: const Text('Oui'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            showCustomDialog(
                                dialog: customAlertDialogResponse(context, 'rock'),
                                context: context);
                          },
                          child: const Text('Non'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

Future<void> showCustomDialog(
    {required Widget dialog, required BuildContext context}) async {
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext buildContext) {
        return dialog;
      });
}

AlertDialog customAlertDialogResponse(context, quiz) {

  return AlertDialog(
    title: const Text('Ta gueule'),
    content: const Image(image: AssetImage("assets/images/fuck.jpg")),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/quiz_page", arguments: {'quiz': quiz});
          },
          child: const Text("Et avec le sourire!"))
    ],
  );
}