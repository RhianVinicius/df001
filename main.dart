import "dart:convert";
import "dart:io";

void main() async {
  // Lê o arquivo .json e armazena seu conteúdo em uma string convertida para Map
  var config = File("posts.json");
  var entradaJson = await config.readAsString();
  var saidaJson = jsonDecode(entradaJson);


  List<dynamic> relatorio = [];
  for (var jsonRow in saidaJson) { // Varre objeto por objeto do json convertido
    int id, published_posts_count, comments_count; 
    String name;

    // Coleta os dados do autor e do post que está sendo analisado
    id = jsonRow["author"]["id"];
    name = jsonRow["author"]["name"];
    published_posts_count = 1;
    comments_count = jsonRow["comments"].length;

    // Verifica se os dados desse autor já estão presentes no relatório. Se sim, os novos dados são sobrepostos
    bool relatorioCountains = false;
    for (var relatorioRow in relatorio) {
      if (relatorioRow["id"] == id) {
        relatorioRow["published_posts_count"] = relatorioRow["published_posts_count"] + 1;
        relatorioRow["comments_count"] = relatorioRow["comments_count"] + comments_count;
        relatorioCountains = true;
      }
    }

    // Se os dados do autor não estiverem presentes no relatório, eles serão inseridos no final da lista
    Map insertRow = {};
    if (!relatorioCountains || relatorio.length == 0) {
      insertRow["id"] = id;
      insertRow["name"] = name;
      insertRow["published_posts_count"] = published_posts_count;
      insertRow["comments_count"] = comments_count;
      relatorio.add(insertRow);
    } 
  }

  // Exibe o relatório
  print(relatorio[0]);
}
