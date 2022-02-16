import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'model/data.dart';


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
        home: const HomeScreen()
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Data> _data = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('주요소 요소수 현황'),
          actions: [
            IconButton(onPressed: () {} ,
              icon: const Icon(Icons.add_reaction_sharp),
            ),

          ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {fetch();},
              child: const Text('가져오기'),
            ),

            Expanded(
              child: ListView(
                children: _data.map((e) {
                  return  ListTile(
                    title: Text(e.name ?? '이222없음'),
                    subtitle: Text(e.addr?? '주소없음'),
                    trailing: Text(e.inventory?? '재고없음'),
                    onTap: () {
                      launch('tel: ${e.tel}');
                    },
                  );
                }).toList(),
              ),
            )
          ],
        )
    );
  }


  Future<void> fetch() async{
    var url = Uri.parse('https://api.odcloud.kr/api/uws/v1/inventory?page=1&perPage=10&serviceKey=data-portal-test-key');
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonData = jsonResult['data'];

    setState(() {
      _data.clear();
      jsonData.forEach((e) {

        _data.add(Data.fromJson(e));
      });
    });
    // print('d완료');

  }

}
