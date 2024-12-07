import "dart:convert";
import "dart:io";

void main() async {
  var config = File("posts.json");
  var entradaJson = await config.readAsString();
  var saidaJson = jsonDecode(entradaJson);


  List<dynamic> relatorio = [];
  for (var jsonRow in saidaJson) {
    int id, published_posts_count, comments_count; 
    String name;

    id = jsonRow["author"]["id"];
    name = jsonRow["author"]["name"];
    published_posts_count = 1;
    comments_count = jsonRow["comments"].length;

    bool relatorioCountains = false;
    for (var relatorioRow in relatorio) {
      if (relatorioRow["id"] == id) {
        relatorioRow["published_posts_count"] = relatorioRow["published_posts_count"] + 1;
        relatorioRow["comments_count"] = relatorioRow["comments_count"] + comments_count;
        relatorioCountains = true;
      }
    }

    Map insertRow = {};
    if (!relatorioCountains || relatorio.length == 0) {
      insertRow["id"] = id;
      insertRow["name"] = name;
      insertRow["published_posts_count"] = published_posts_count;
      insertRow["comments_count"] = comments_count;
      relatorio.add(insertRow);
    } 
  }

  print(relatorio[0]);
}
