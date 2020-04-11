class Movement {
  int id;
  String nome;

  Movement({id, nome});

  @override
  String toString() {
    return 'Movement{_id: $id, _nome: $nome}';
  }
}