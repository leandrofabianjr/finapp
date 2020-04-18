import 'package:finapp/db/daos/dao.dart';
import 'package:finapp/helpers/date_helper.dart';
import 'package:finapp/models/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryDao extends Dao<Category> {
  @override
  String tblName = 'category';
  @override
  String colPk = 'id';

  String colId = 'id';
  String colName = 'name';
  String colIdCategoryType = 'id_category_type';
  String colDescription = 'description';
  String colColor = 'color';
  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  @override
  Map<String, dynamic> toRow(Category obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colIdCategoryType: obj.idCategoryType,
      colColor: obj.color.value,
      colCreatedAt: obj.createdAt.toString(),
      colDeletedAt: obj.deletedAt.toString()
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
        createdAt: DateHelper.stringToDateTime(row[colCreatedAt]),
        deletedAt: DateHelper.stringToDateTime(row[colDeletedAt]));
  }
}
