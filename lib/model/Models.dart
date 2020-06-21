class Manga {
  String id;
  String mangaName;
  String mangaUrl;
  String cover;
  String status;
  double rating;
  String lastUpdated;
  String description;
  List<Chapter> chapters;

  Manga(
      {this.id,
      this.mangaName,
      this.cover,
      this.description,
      this.mangaUrl,
      this.status,
      this.rating,
      this.lastUpdated,
      this.chapters});

  factory Manga.fromJson(Map<String, dynamic> json) {
    var chaptersObject = json["chapters"] as List;
    return Manga(
        id: json["id"],
        mangaName: json["mangaName"],
        cover: json["cover"],
        mangaUrl: json["mangaUrl"],
        status: json["status"],
        rating: json["rating"],
        description: json["description"],
        lastUpdated: json["mangaLastUpdated"],
        chapters: chaptersObject
            .map<Chapter>((chap) => Chapter.fromJson(chap))
            .toList());
  }
}

class Chapter {
  String id;
  String chapterName;
  String lastUpdated;
  List<dynamic> images;

  Chapter({this.id, this.chapterName, this.lastUpdated, this.images});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
        id: json["id"],
        chapterName: json["chapterName"],
        lastUpdated: json["lastUpdated"],
        images: json["chapterImages"] as List);
  }
}

class MangaUpdate {
  String id;
  String mangaName;
  String mangaUrl;
  String cover;
  String status;
  double rating;
  String lastUpdated;
  String description;
  MangaUpdate(
      {this.id,
        this.mangaName,
        this.cover,
        this.description,
        this.mangaUrl,
        this.status,
        this.rating,
        this.lastUpdated});

  factory MangaUpdate.fromJson(Map<String, dynamic> json) {
    return MangaUpdate(
        id: json["id"],
        mangaName: json["mangaName"],
        cover: json["cover"],
        mangaUrl: json["mangaUrl"],
        status: json["status"],
        rating: json["rating"],
        description: json["description"],
        lastUpdated: json["mangaLastUpdated"]);
  }
}
