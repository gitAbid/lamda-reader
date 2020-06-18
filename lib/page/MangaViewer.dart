import 'package:flutter/material.dart';
import 'package:lamdareader/model/Models.dart';

class MangaViewer extends StatelessWidget {
  Manga _manga;
  Chapter _chapter;

  MangaViewer(this._manga, this._chapter);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (context, index) => FadeInImage.assetNetwork(
            width: double.infinity,
            placeholder: "images/loading.gif",
            image: _chapter.images[index]),
        itemCount: _chapter.images.length,
      ),
    );
  }
}
