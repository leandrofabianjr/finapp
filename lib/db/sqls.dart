/// Migration scripts for the database
const sqlVersions = [
  [ // Version 1
    'create table category_type ('
        'id integer primary key autoincrement,'
        'name text not null,'
        'description integer,'
        'created_at timestamp not null default current_timestamp,'
        'deleted_at timestamp'
        ')',
    'create table category ('
        'id integer primary key autoincrement,'
        'name text not null,'
        'description text,'
        'id_category_type integer not null constraint category_category_type_id_fk references category_type on update restrict on delete restrict,'
        'created_at timestamp not null default current_timestamp,'
        'deleted_at timestamp'
        ')',
    'create table account_type ('
        'id integer primary key autoincrement,'
        'name text not null,'
        'description text,'
        'created_at timestamp not null default current_timestamp,'
        'deleted_at timestamp'
        ')',
    'create table account ('
        'id integer primary key autoincrement,'
        'name text not null,'
        'description text,'
        'id_account_type integer not null references account_type on update restrict on delete restrict,'
        'created_at timestamp not null default current_timestamp,'
        'deleted_at timestamp'
        ')',
    'create table movement ('
        'id integer primary key autoincrement,'
        'name integer not null,'
        'description text,'
        'data timestamp not null,'
        'id_account integer not null references account on update restrict on delete restrict,'
        'id_category integer not null references category on update restrict on delete restrict,'
        'created_at timestamp not null default current_timestamp,'
        'deleted_at timestamp'
        ')'
  ], // End Version 1
];
