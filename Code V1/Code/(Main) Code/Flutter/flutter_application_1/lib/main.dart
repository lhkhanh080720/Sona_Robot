import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
//import 'package:web_socket_channel/status.dart' as status;

const String espUrl = 'ws://192.168.99.100:81';
bool statusSweep = false;

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SONNA CONTROL  v1'),
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
  String msg = '';
  double speed = 0;
  IOWebSocketChannel channel = IOWebSocketChannel.connect(espUrl);

  @override
  void initState() {
    super.initState();
    channel.stream.listen(
      (message) {
        print('Connection Status: $message');
        setState(() {
          msg = message;
        });
        //channel.sink.close(status.goingAway);
      },
      onDone: () {
        //if WebSocket is disconnected
        print("Web socket is closed");
        setState(() {
          msg = 'disconnected';
        });
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            //LINE 1
            const Text(
              'Connection Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            //LINE 2
            GestureDetector(
              onTapDown: (details) {
                if (msg == 'disconnected') {
                  channel = IOWebSocketChannel.connect(espUrl);
                  channel.stream.listen(
                    (message) {
                      print('Received from MCU: $message');
                      setState(() {
                        msg = message;
                      });
                    },
                    onDone: () {
                      print("Web socket is closed");
                      setState(() {
                        msg = 'disconnected';
                      });
                    },
                    onError: (error) {
                      print(error.toString());
                    },
                  );
                  print('Reset app');
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 35,
                width: (msg == 'connected' ? 110 : 135),
                child: Text(msg,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)),
                decoration: BoxDecoration(
                  color: (msg == 'connected'
                      ? const Color.fromARGB(255, 20, 248, 123)
                      : const Color.fromARGB(255, 241, 70, 70)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
            //LINE 3
            GestureDetector(
              onTapDown: (details) {
                channel.sink.add('f');
              },
              onTapUp: (details) {
                channel.sink.add('s');
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 100,
                width: 100,
                child: const Text('Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.black),
                ),
              ),
            ),
            //LINE 4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    channel.sink.add('l');
                    print("Hello");
                  },
                  onTapUp: (details) {
                    channel.sink.add('s');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    child: const Text('Left',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    statusSweep = !statusSweep;
                    if (statusSweep) {
                      channel.sink.add('m');
                      print('m');
                    } else {
                      channel.sink.add('o');
                      print('o');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    child: const Text('Sweep',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                  ),
                ),
                //const Padding(padding: EdgeInsets.only(left: 90)),
                GestureDetector(
                  onTapDown: (details) {
                    channel.sink.add('r');
                  },
                  onTapUp: (details) {
                    channel.sink.add('s');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    child: const Text('Right',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            //LINE 5
            GestureDetector(
              onTapDown: (details) {
                channel.sink.add('b');
              },
              onTapUp: (details) {
                channel.sink.add('s');
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 100,
                width: 100,
                child: const Text('Down',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.black),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            //LINE 6
            Text(
              'Speed: ${speed.round()}',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            //LINE 7
            Slider(
              activeColor: Colors.blue,
              min: 0,
              max: 255,
              value: speed,
              divisions: 255,
              label: '${speed.round()}',
              onChanged: (value) {
                setState(() {
                  speed = value;
                });
              },
            ),
            //LINE 8
            GestureDetector(
              onTapDown: (details) {
                String s = 'p${speed.round()}';
                channel.sink.add(s);
                print(s);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                height: 35,
                width: 60,
                child: const Text('Send',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
