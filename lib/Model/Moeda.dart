final String id = "id";
final String valorParaConversao = "valorParaConversao";
final String valorConvertido = "valorConvertido";

class Moeda {

  int idConversao;
  String mValorParaConversao;
  String mValorConvertido;

  Moeda();

  Moeda.fromMap(Map map){
    idConversao = map[id];
    mValorParaConversao = map[valorParaConversao];
    mValorConvertido = map[valorConvertido];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorParaConversao:  mValorParaConversao,
       valorConvertido: mValorConvertido
    };
    if (id != null) {
      map[id] = idConversao;
    }
    return map;
  }

}
