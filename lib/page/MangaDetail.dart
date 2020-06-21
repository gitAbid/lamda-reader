import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lamdareader/model/Models.dart';
import 'package:lamdareader/page/MangaViewer.dart';
import 'package:transparent_image/transparent_image.dart';

class MangaDetail extends StatefulWidget {
  String mangaUrl;

  MangaDetail(this.mangaUrl);

  @override
  _MangaDetailState createState() => _MangaDetailState();
}

class _MangaDetailState extends State<MangaDetail> {
//  var dummyCoverUrl = "https://drive.google.com/uc?export=view&id=13YJ1dghZK5axnVSFhgb2SGAZsZBSlr8f";
  var dummyCoverUrl = "https://cdn.the-scientist.com/assets/articleNo/66547/aImg/33968/tech-transfer-thumb-s.png";
  Future<Manga> manga;

  Future<Manga> getManga() async {
    Manga manga;
    String link = "http://13.233.104.213:9090/v1/manga/srcUrl/";
//    String link = "http://172.22.176.1:9090/v1/manga/srcUrl/";
//    var res = await http.get(Uri.encodeFull(link));
    var res = await http.post(
      link,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mangaUrl': widget.mangaUrl,
      }),
    );

    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      manga = Manga.fromJson(data);
    }
    return manga;
  }

  @override
  void initState() {
    manga = getManga();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 40;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Container(
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
                                FutureBuilder<Manga>(
                                  future: manga,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.data.status,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: .2,
                                                  color: Colors.blueGrey,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data.rating.toString(),
                                              style: TextStyle(
                                                  letterSpacing: .2,
                                                  fontSize: 16,
                                                  color: Colors.blueGrey,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data.lastUpdated
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
                                      return CircularProgressIndicator();
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
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 20),
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
                          child: FutureBuilder<Manga>(
                              future: manga,
                              builder: (context, snapshot) {
                                var description = "";
                                if (snapshot.hasData) {
                                  description = snapshot.data.description;
                                }
                                if (snapshot.hasData && snapshot.data != null) {
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
                                } else {
                                  return Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ));
                                }
                              }),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 20),
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
                          child: FutureBuilder<Manga>(
                              future: manga,
                              builder: (context, snapshot) {
                                Manga manga;
                                List<Chapter> chapters = [];
                                if (snapshot.hasData && snapshot.data != null) {
                                  manga = snapshot.data;
                                  chapters = snapshot.data.chapters;
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                      splashColor: Colors.blueGrey,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MangaViewer(manga, index),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 15, 20, 8),
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
                                                20, 0, 20, 15),
                                            child: Text(
                                              chapters[index].lastUpdated,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: .2,
                                                  color: Colors.grey[700],
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ),
                                          Divider(height: 0,),
                                        ],
                                      ),
                                    ),
                                    itemCount: snapshot.data.chapters.length,
                                  );
                                } else {
                                  return Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ));
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 120,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 3,
                      height: (width / 3) * 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          radius: 20,
                          onTap: () {},
                          child: FutureBuilder<Manga>(
                            future: manga,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Manga manga = snapshot.data;
                                return Column(
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
                                          child: Hero(
                                            tag: manga.mangaName,
                                            child: FadeInImage.memoryNetwork(
                                              fit: BoxFit.fill,
                                              image: manga.cover,
                                              placeholder: kTransparentImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container(
                                    color: Colors.white,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            "${snapshot.data.mangaName}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontFamily: 'Roboto',
                            ),
                          );
                        } else {
                          return Container(
                            color: Colors.transparent,
                          );
                        }
                      },
                      future: manga,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
