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
}

class Ingrediente {
  final String nome;

  Ingrediente({
    required this.nome,
  });
}
