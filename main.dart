import "dart:convert";
import "dart:io";

Future<void> main() async {
  final file = File("posts.json");
  final fileAsString = await file.readAsString();
  final jsonDecoded = jsonDecode(fileAsString);

  List<dynamic> authorsList = [];

  for (final jsonIndex in jsonDecoded) {
    final int id = jsonIndex["author"]["id"];
    final String name = jsonIndex["author"]["name"];
    final int publishedPostsCount = 1;
    final int commentsCount = jsonIndex["comments"].length;

    bool authorInList = false;

    for (final listIndex in authorsList) {
      if (listIndex["id"] == id) {
        listIndex["published_posts_count"] =
            listIndex["published_posts_count"] + 1;
        listIndex["comments_count"] =
            listIndex["comments_count"] + commentsCount;
        authorInList = true;
      }
    }

    if (!authorInList || authorsList.length == 0) {
      Map<String, dynamic> mapCurrentAuthor = {
        "id": id,
        "name": name,
        "published_posts_count": publishedPostsCount,
        "comments_count": commentsCount,
      };

      authorsList.add(mapCurrentAuthor);
    }
  }

  print(authorsList);
}