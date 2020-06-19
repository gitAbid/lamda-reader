import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamdareader/model/Models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangaViewer extends StatefulWidget {
  Manga _manga;
  int _index;

  MangaViewer(this._manga, this._index);

  @override
  _MangaViewerState createState() => _MangaViewerState();
}

class _MangaViewerState extends State<MangaViewer> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _controller = new ScrollController(keepScrollOffset: true);

  Chapter _chapter;
  int index;
  Key listKey;
  double progress = 0.0;
  double currentPosition = 0.0;

  @override
  void initState() {
    index = widget._index;
    _chapter = widget._manga.chapters[index];
    listKey = ObjectKey(_chapter.id);
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    currentPosition = _controller.offset;

    setState(() {
      progress =
          ((100 / _controller.position.maxScrollExtent) * currentPosition) / 100;
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _chapter = widget._manga.chapters[index];
      listKey = ObjectKey(Random.secure().nextDouble().toString());
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {
      if (index - 1 >= 0) {
        index = index - 1;
        _chapter = widget._manga.chapters[index];
        listKey = ObjectKey(_chapter.id);
      }
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LinearProgressIndicator(
        value: progress,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
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
            child: ListView.builder(
              controller: _controller,
              addAutomaticKeepAlives: true,
              physics: BouncingScrollPhysics(),
              key: listKey,
              itemBuilder: (context, index) => FadeInImage.assetNetwork(
                  width: double.infinity,
                  placeholderScale: 2,
                  placeholder: "images/loading.gif",
                  image: _chapter.images[index]),
              itemCount: _chapter.images.length,
            ),
          ),
        ),
      ),
    );
  }
}
