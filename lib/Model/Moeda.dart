final String id = "id";
final String valorParaConversao = "valorParaConversao";
final String valorConvertido = "valorConvertido";
final String nomeMoedaParaConversao = "nomeMoedaParaConversao";
final String nomeMoedaConvertida = "nomeMoedaConvertida";

class Moeda {

  int idConversao;
  String mValorParaConversao;
  String mValorConvertido;
  String mNomeMoedaParaConversao;
  String mNomeMoedaConvertida;

  Moeda();

  Moeda.fromMap(Map map){
    idConversao = map[id];
    mValorParaConversao = map[valorParaConversao];
    mValorConvertido = map[valorConvertido];
    mNomeMoedaParaConversao = map[nomeMoedaParaConversao];
    mNomeMoedaConvertida = map[nomeMoedaConvertida];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorParaConversao:  mValorParaConversao,
      valorConvertido: mValorConvertido,
      nomeMoedaParaConversao: mValorParaConversao,
      nomeMoedaConvertida: mValorConvertido
    };
    if (id != null) {
      map[id] = idConversao;
    }
    return map;
  }

}
