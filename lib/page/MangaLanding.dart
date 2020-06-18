import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lamdareader/model/Models.dart';
import 'package:lamdareader/widget/WidgetUtils.dart';
import 'package:transparent_image/transparent_image.dart';


class MangaLanding extends StatefulWidget {
  @override
  _MangaLandingState createState() => _MangaLandingState();
}

class _MangaLandingState extends State<MangaLanding> {
  Future<List<Manga>> mangas;

  Future<List<Manga>> getManga() async {
    List<Manga> list = [];
    String link = "http://52.66.213.188:9000/v1/manga/all?pageSize=10";
//    String link = "http://172.20.160.1:9000/v1/manga/all?pageSize=10";
    var res = await http.get(Uri.encodeFull(link));
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["content"] as List;
      list = rest.map<Manga>((json) => Manga.fromJson(json)).toList();
    }
    return list;
  }

  @override
  void initState() {
    mangas = getManga();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Browse",
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 93, 115, 139),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Text(
                            "Manga",
                            style: TextStyle(
                                color: Colors.blueGrey[600],
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 90,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey[200].withOpacity(0.5),
                                  spreadRadius: 10,
                                  blurRadius: 100,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Color.fromARGB(70, 93, 115, 139),
                                  ),
                                ),
                                flex: 20,
                              ),
                              Flexible(
                                flex: 90,
                                child: TextField(
                                  decoration: new InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey[400],
                                        fontFamily: 'Roboto',
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "Search",
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          6.0, 0.0, 0, 0.0)),
                                  style: TextStyle(
                                    color: Colors.blueGrey[400],
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 20,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.settings_input_component,
                                color: Color.fromARGB(100, 93, 115, 139),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.blueGrey[200].withOpacity(0.5),
                                    spreadRadius: 10,
                                    blurRadius: 100,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TRENDING NOW",
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            fontSize: 16,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "View All",
                            style: TextStyle(
                                color: Colors.blueGrey[400],
                                fontSize: 12,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<Manga>>(
                    future: mangas,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return getTrendingGrid(snapshot.data, context);
                      } else {
                        return Text("No Data available");
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MOST POPULAR",
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            fontSize: 16,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "View All",
                            style: TextStyle(
                                color: Colors.blueGrey[400],
                                fontSize: 12,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<Manga>>(
                    future: mangas,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return getTrendingGrid(snapshot.data,  context);
                      } else {
                        return Text("No Data available");
                      }
                    },
                  ),
                ],
              ),
              color: Color(0xEDF0F5),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getTrendingGrid(List<Manga> data, BuildContext context) {
  List<Row> rows = [];
  var index = 0;
  for (var i = 0; i < 2; i++) {
    List<Widget> mangas = [];
    for (var j = 0; j < 3; j++) {
      mangas.add(getMangaCover(data[index++], context));
    }
    rows.add(Row(
      children: mangas,
    ));
  }

  return Column(children: rows);
}

