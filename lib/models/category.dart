class Category {
  int id;
  String name;
  String description;
  int idCategoryType;
  DateTime createdAt;
  DateTime deletedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.idCategoryType,
      this.createdAt,
      this.deletedAt});

  @override
  String toString() {
    return 'Category{id: $id, name: $name, description: $description, idCategoryType: $idCategoryType, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
