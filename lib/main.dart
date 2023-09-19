import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
   

  static const platform = MethodChannel('samples.flutter.dev/battery');
  // battery level, to  show  inside text widget:
  String batteryLevel = 'unknown batterylevel';
  Future<void> _getbatteryLevel() async {
    String _batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      _batteryLevel = 'batteryLevel at $result %';
    } on PlatformException catch (e) {
      _batteryLevel = 'failed to getbatteryLevel : ${e.message}';
    }
    setState(() {
      batteryLevel = _batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            ElevatedButton(
              
              onPressed: () {
                _getbatteryLevel();
              }, 
              child: Text('get battery level')),
            Text(batteryLevel),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
