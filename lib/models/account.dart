class Account {
  int id;
  String name;
  String description;
  int idAccountType;
  DateTime createdAt;
  DateTime deletedAt;

  Account(
      {this.id,
      this.name,
      this.description,
      this.idAccountType,
      this.createdAt,
      this.deletedAt});

  @override
  String toString() {
    return 'Account{id: $id, name: $name, description: $description, idAccountType: $idAccountType, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
