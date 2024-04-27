class Receita {
  final String nome;
  final String tempoPreparo;
  final List<Ingrediente> ingredientes;
  final String imagemUrl;
  final String descricao;

  Receita({
    required this.nome,
    required this.tempoPreparo,
    required this.ingredientes,
    required this.imagemUrl,
    required this.descricao,
  });
}

class Ingrediente {
  final String quantidade;
  final String nome;

  Ingrediente({
    required this.quantidade,
    required this.nome,
  });
}
