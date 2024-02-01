import 'package:flutter/material.dart';
import 'package:flutter_iomb_library/flutter_iomb_library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IombLibrary.instance.android.setDebugModeEnabled(true);
  await IombLibrary.instance.ios.setDebugLogLevel(IOMBDebugLevel.trace);

  await IombLibrary.instance.sessionConfiguration(
    baseURL: '<yourBaseURL>',
    offerIdentifier: '<yourIdentifier>',
  );

  await IombLibrary.instance.logViewEvent(type: IOMBViewEvent.appeared, category: 'home');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IombLibrary Plugin'),
        ),
        body: const Center(
          child: Column(
            children: [
              Text('Running'),
            ],
          ),
        ),
      ),
    );
  }
}
