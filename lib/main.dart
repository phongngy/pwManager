import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/fixValues/mytheme.dart';
import 'package:pwsafe/pages/pwlist.dart';
import 'package:pwsafe/provider/pw_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pwsafe/klassen/get_it.dart' as injector;
//import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PWProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/*
  bool _jailbroken = false;
  bool _developerMode = false;


  @override
  void initState() {
    super.initState();
    _checkJailBreak();
  }
*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme(),
      home: const PWList(),
    );
  }
/*
  Future<void> _checkJailBreak() async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });
  }*/
}
