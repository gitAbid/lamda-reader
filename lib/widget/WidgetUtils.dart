import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lamdareader/model/Models.dart';
import 'package:transparent_image/transparent_image.dart';

Widget getMangaCover(Manga manga, BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  width = width - 40;
  return Container(
    width: width / 3,
    height: (width / 3) * 1.8,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey[200].withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 100,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "${manga.mangaName}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[500],
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
