import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lamdareader/model/Models.dart';
import 'package:lamdareader/widget/WidgetUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangaList extends StatefulWidget {
  MangaList();

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  RefreshController _refreshController;
  Future<List<MangaUpdate>> _mangas;
  int pageNo = 0;
  int previousPage = 0;
  int maxPage = 0;
  List<MangaUpdate> mangaList = new List<MangaUpdate>();

  Future<List<MangaUpdate>> _loadManga(int page) async {
    List<MangaUpdate> list = [];
    String link = "http://13.233.104.213:9090/v1/manga/all?pageSize=9&pageNo=$page";
//    String link = "http://172.22.144.1:9090/v1/manga/all??sortBy=viewCount&orderBy=DESC&pageSize=9&pageNo=$page";
    var res = await http.get(Uri.encodeFull(link));
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["content"] as List;
      maxPage = data["totalPages"];
      pageNo = data["number"];
      list =
          rest.map<MangaUpdate>((json) => MangaUpdate.fromJson(json)).toList();
      mangaList.addAll(list);
    } else {
      setState(() {
        pageNo = previousPage;
      });
    }
    return mangaList;
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      previousPage = 0;
      pageNo =0;
      _mangas = _loadManga(pageNo);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {
      previousPage = pageNo;
      pageNo = pageNo + 1;
      _mangas = _loadManga(pageNo);
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _mangas = _loadManga(pageNo);
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: ClassicFooter(
            completeDuration: Duration(milliseconds: 1000),
            idleText: "No More Chapter",
            loadingText: "Next Chapter",
            idleIcon: Icon(
              Icons.not_interested,
              color: Colors.red[400],
            ),
            canLoadingText: "Load Next Chapter",
            loadStyle: LoadStyle.ShowWhenLoading,
            height: 40,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Hero(
                      tag: "searchBar",
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 90,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueGrey[200]
                                            .withOpacity(0.5),
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
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.search,
                                          color:
                                              Color.fromARGB(70, 93, 115, 139),
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
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
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
                                          color: Colors.blueGrey[200]
                                              .withOpacity(0.5),
                                          spreadRadius: 10,
                                          blurRadius: 100,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: FutureBuilder<List<MangaUpdate>>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(20),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getMangaCover(snapshot.data[index], context);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 4 / 7),
                          );
                        } else {
                          return Center(
                            child: Text("No Manga Found"),
                          );
                        }
                      },
                      future: _mangas,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
