class AccountType {
  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime deletedAt;

  AccountType(
      {this.id, this.name, this.description, this.createdAt, this.deletedAt});

  @override
  String toString() {
    return 'AccountType{id: $id, name: $name, description: $description, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
