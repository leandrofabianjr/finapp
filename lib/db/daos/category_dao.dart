import 'package:finapp/db/daos/dao.dart';
import 'package:finapp/models/category.dart';
import 'package:flutter/material.dart';

class CategoryDao extends Dao<Category> {
  @override
  String tblName = 'category';

  String colId = 'id';
  String colName = 'name';
  String colIdCategoryType = 'id_category_type';
  String colDescription = 'description';
  String colColor = 'color';

  @override
  Map<String, dynamic> toRow(Category obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colIdCategoryType: obj.idCategoryType,
      colColor: obj.color.value,
    };
  }

  @override
  Category toObj(Map<String, dynamic> row) {
    return Category(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
      idCategoryType: row[colIdCategoryType],
      color: Color(row[colColor]),
    );
  }
}
