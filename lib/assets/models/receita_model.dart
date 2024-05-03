class Receita {
  final String nome;
  final String tempoPreparo;
  late final List<Ingrediente> ingredientes;
  late final String descricao;

  Receita({
    required this.nome,
    this.tempoPreparo = "",  // Set default value
    this.ingredientes = const [],  // Set default value
    required this.descricao,
  });

  Receita.fromJson(Map<String, dynamic> json)
      : nome = json['titulo'],
        tempoPreparo = json['tempo_preparo'],
        ingredientes = (json['ingredientes'] as List<dynamic>)
            .map((e) => Ingrediente(nome: e))
            .toList(),
        descricao = json['modo_de_preparo'];
}

class Ingrediente {
  final String nome;

  Ingrediente({
    required this.nome,
  });
}