import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seconda/my-data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Seconda',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late String _title;
  MyHomePage({String? title}) {
    _title = title!;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   super.initState();
  //   print('INIT STATE');
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       print('appLifeCycleState inactive');
  //       break;
  //     case AppLifecycleState.resumed:
  //       print('appLifeCycleState resumed');
  //       break;
  //     case AppLifecycleState.paused:
  //       print('appLifeCycleState paused');
  //       break;
  //     case AppLifecycleState.detached:
  //       print('appLifeCycleState detached');
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyData>(
      create: (_) => MyData(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClockWidget(
                  ticks: context.watch<MyData>().count,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: context.watch<MyData>().running
                              ? Colors.cyan
                              : Colors.green),
                      onPressed: () {
                        context.read<MyData>().startstop();
                      },
                      child: Text(
                          context.watch<MyData>().running ? "PAUSE" : "START"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MyData>().reset();
                      },
                      child: Text('RESET'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClockWidget extends StatelessWidget {
  int seconds = 0;
  int milliseconds = 0;
  int minutes = 0;
  ClockWidget({required int ticks}) {
    minutes = (ticks / 6000).floor();
    seconds = ((ticks / 100).floor()) % 60;
    milliseconds = ticks % 100;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatClock(minutes),
            style: TextStyle(fontSize: 64.0),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            formatClock(seconds),
            style: TextStyle(fontSize: 64.0, color: Colors.deepOrange),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            formatClock(milliseconds),
            style: TextStyle(fontSize: 36.0),
          ),
        ],
      ),
    );
  }

  String formatClock(int value) {
    String output = "";
    if (value < 10) {
      output = "0" + value.toString();
    } else {
      output = value.toString();
    }
    return output;
  }
}
