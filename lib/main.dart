import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ストップウォッチアプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stopwatch = Stopwatch();
  String elapsedTime = "00:00:00";

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
      if (stopwatch.isRunning == false) return;
      setState(() {
        int totalMSec = stopwatch.elapsed.inMilliseconds;
        //totalMSec += (58 * 1000);
        int minute = totalMSec ~/ (1000 * 60);
        int sec = totalMSec ~/ 1000;
        int msec = totalMSec % 1000;

        elapsedTime =
            '${minute.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}:${msec.toString().padLeft(3, "0").substring(0, 2)}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 100),
              width: MediaQuery.of(context).size.width * 1.0,
              child: Image.asset('assets/bg.png', fit: BoxFit.fitWidth),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  elapsedTime,
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 10,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
//                      style: ElevatedButton.styleFrom(fixedSize: Size(100, 50)),
                      child: Text(
                        'RESET',
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: stopwatch.isRunning
                          ? null
                          : () {
                              setState(() {
                                stopwatch.reset();
                                elapsedTime = "00:00:00";
                              });
                            },
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      child: Text(stopwatch.isRunning ? 'STOP' : 'START'),
                      onPressed: () {
                        // ここに押された時の処理を書く！
                        setState(() {
                          if (stopwatch.isRunning) {
                            stopwatch.stop();
                          } else {
                            stopwatch.start();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: stopwatch.isRunning
                              ? Colors.red
                              : Theme.of(context).primaryColor),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
