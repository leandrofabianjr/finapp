import 'package:finapp/db/daos/category_type_dao.dart';
import 'package:finapp/models/category_type.dart';
import 'package:finapp/shared/components/select_list.dart';
import 'package:flutter/material.dart';

import 'category_type_new.dart';

class CategoryTypeSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um tipo de categoria'),
      ),
      body: SelectList(
          data: CategoryTypeDao().findAll(),
          listTileBuilder: (context, obj) => ListTile(
                title: Text(obj.name),
                subtitle:
                    obj.description != null ? Text(obj.description) : null,
                trailing: obj.createdAt != null ? Icon(Icons.edit) : null,
                onTap: () => Navigator.pop<CategoryType>(context, obj),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<CategoryType>(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoryTypeNewScreen()))
            .then((categoryType) {
          if (categoryType != null) {
            Navigator.pop<CategoryType>(context, categoryType);
          }
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
