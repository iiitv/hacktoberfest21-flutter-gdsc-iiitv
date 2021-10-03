import 'package:flutter/material.dart';
import 'package:hacktoberfest21_gdsc/avenger_detail.dart';
import 'package:hacktoberfest21_gdsc/models/avengers.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
      title: "Avengers",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/iiitv/hacktoberfest21-flutter-gdsc-iiitv/main/data.json?token=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");

  DataHub? dataHub;
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedValue = jsonDecode(res.body);
    dataHub = DataHub.fromJson(decodedValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 240) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("GDSC-Hacktoberfest21"),
      ),
      body: dataHub == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    setState(() {
                      fetchData();
                    });
                  },
                );
              },
              child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  children: dataHub!.data
                      .map((Data avenge) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AvengerDetail(
                                              data: avenge,
                                            )));
                              },
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Hero(
                                      tag: avenge.imgURL.toString(),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  avenge.imgURL.toString())),
                                        ),
                                      ),
                                    ),
                                    Text(avenge.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: InkWell(
            child: Container(
              color: Colors.teal,
              height: MediaQuery.of(context).size.height / 20,
              // ng: EdgeInsets.all(8.0),paddi
              child: const Center(
                child: Text(
                  "</> by GDSC IIITV",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () => launch(
                'https://iiitv.github.io/hacktoberfest21-flutter-gdsc-iiitv/'),
          ),
        ),
      ),
    );
  }
}
