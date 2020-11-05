import 'package:flutter/material.dart';
import 'package:ip_info/ip_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPInfo-Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'IPInfo-Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int fingerprint = 0;
  String ipv4 = '', ipv6 = '', location = '';

  void refresh() async {
    fingerprint = IPInfo.fingerprint(context);
    ipv4 = await IPInfo.ipv4 ?? 'Not available';
    ipv6 = await IPInfo.ipv6 ?? 'Not available';
    location = await IPInfo.location ?? 'Not available';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Your unique fingerprint (beta): $fingerprint\nYour current IPv4: $ipv4\nYour current IPv6: $ipv6\nYour current Location: $location',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
