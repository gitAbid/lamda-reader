import 'package:flutter/material.dart';

class MangaList extends StatefulWidget {
  MangaList();

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Hero(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
