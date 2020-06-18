import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lamdareader/model/Models.dart';
import 'package:lamdareader/page/MangaViewer.dart';
import 'package:transparent_image/transparent_image.dart';

class MangaDetail extends StatefulWidget {
  @override
  _MangaDetailState createState() => _MangaDetailState();
}

class _MangaDetailState extends State<MangaDetail> {
  var dummyCoverUrl =
      "https://cdn.the-scientist.com/assets/articleNo/66547/aImg/33968/tech-transfer-thumb-s.png";
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
    return SingleChildScrollView(
      child: Container(
        color: Colors.blueGrey[50],
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: dummyCoverUrl),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(11),
                              child: Center(
                                child: Text(
                                  "Subscribe",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                          letterSpacing: .2,
                                          color: Colors.grey[600],
                                          fontFamily: 'Roboto'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Rating",
                                      style: TextStyle(
                                          letterSpacing: .2,
                                          color: Colors.grey[600],
                                          fontFamily: 'Roboto'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Last Updated",
                                      style: TextStyle(
                                          letterSpacing: .2,
                                          color: Colors.grey[600],
                                          fontFamily: 'Roboto'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FutureBuilder<List<Manga>>(
                                future: mangas,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data[0].status,
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: .2,
                                                color: Colors.blueGrey,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data[0].rating.toString(),
                                            style: TextStyle(
                                                letterSpacing: .2,
                                                fontSize: 16,
                                                color: Colors.blueGrey,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data[0].lastUpdated
                                                .split(" ")[0],
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: .2,
                                                color: Colors.blueGrey,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Expanded(
                              child: Text(
                                "Description",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: .2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: FutureBuilder<List<Manga>>(
                            future: mangas,
                            builder: (context, snapshot) {
                              var description = "";
                              if (snapshot.hasData) {
                                description = snapshot.data[0].description;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  description,
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: .2,
                                      color: Colors.blueGrey,
                                      fontFamily: 'Roboto'),
                                ),
                              );
                            }),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Expanded(
                              child: Text(
                                "Chapters",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: .2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: FutureBuilder<List<Manga>>(
                            future: mangas,
                            builder: (context, snapshot) {
                              Manga manga;
                              List<Chapter> chapters = [];
                              if (snapshot.hasData) {
                                manga = snapshot.data[0];
                                chapters = snapshot.data[0].chapters;
                              }
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                  splashColor: Colors.blueGrey,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MangaViewer(manga, chapters[index]),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 8),
                                        child: Text(
                                          chapters[index].chapterName,
                                          style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: .2,
                                              color: Colors.blueGrey,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 10),
                                        child: Text(
                                          chapters[index].lastUpdated,
                                          style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: .2,
                                              color: Colors.grey[700],
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                                itemCount: snapshot.data[0].chapters.length,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 122,
              left: 18,
              child: FutureBuilder<List<Manga>>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Manga manga = snapshot.data[0];
                    var width = MediaQuery.of(context).size.width;
                    width = width - 40;
                    return Container(
                      width: width / 3,
                      height: (width / 3) * 2,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          radius: 20,
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 4 / 5.5,
                                    child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fill,
                                      image: manga.cover,
                                      placeholder: kTransparentImage,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text(
                                  "${manga.mangaName}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                future: mangas,
              ),
            )
          ],
        ),
      ),
    );
  }
}
