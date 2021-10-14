import 'package:flutter/cupertino.dart';
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
      "https://raw.githubusercontent.com/iiitv/hacktoberfest21-flutter-gdsc-iiitv/main/data.json");

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
      appBar: PreferredSize(
        
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: const Text("GDSC-Hacktoberfest21"),
          shape: const RoundedRectangleBorder(
            
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            )
          ),
        ),
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
              child: Padding(
                padding: const EdgeInsets.only(top:20,left: 10.0,right: 10.0),
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

                                  shadowColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.teal,width: 1.5),
                                    borderRadius: BorderRadius.circular(22)
                                  ),
                                  elevation: 4.0,
                                  child: Column(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: avenge.imgURL.toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: SizedBox(
                                            // width:
                                            // MediaQuery.of(context).size.width /
                                            //     4,
                                            height:
                                                MediaQuery.of(context).size.height /
                                                    4.2,
                                            // decoration: BoxDecoration(
                                            //   image: DecorationImage(
                                            //
                                            //       image: NetworkImage(
                                            //           avenge.imgURL.toString())),
                                            // ),
                                            child: CircleAvatar(
                                                radius: 90,
                                                backgroundImage:NetworkImage(avenge.imgURL.toString()),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                        child: Text(avenge.name.toString(),
                                            overflow: TextOverflow.ellipsis,

                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              ),
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
