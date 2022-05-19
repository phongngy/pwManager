import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/pages/pwlist.dart';
import 'package:pwsafe/provider/pw_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PWProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PWList(),
    );
  }
}
