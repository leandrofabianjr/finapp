import 'package:flutter/cupertino.dart';

class Category {
  int id;
  String name;
  String description;
  Color color;
  int idCategoryType;
  DateTime createdAt;
  DateTime deletedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.idCategoryType,
      this.color,
      this.createdAt,
      this.deletedAt});

  @override
  String toString() {
    return 'Category{id: $id, name: $name, description: $description, color: ${color.toString()}, idCategoryType: $idCategoryType, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
