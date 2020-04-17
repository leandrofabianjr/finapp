create table category_type (
  id integer primary key autoincrement,
  name text not null,
  description integer,
  created_at timestamp default current_timestamp,
  deleted_at timestamp
);

create table category (
  id integer primary key autoincrement,
  name text not null,
  description text,
  color character(16),
  id_category_type integer not null constraint category_category_type_id_fk references category_type on update restrict on delete restrict,
  created_at timestamp default current_timestamp,
  deleted_at timestamp
);

create table account_type (
  id integer primary key autoincrement,
  name text not null,
  description text,
  created_at timestamp default current_timestamp,
  deleted_at timestamp
);

create table account (
  id integer primary key autoincrement,
  name text not null,
  description text,
  id_account_type integer not null references account_type on update restrict on delete restrict,
  created_at timestamp default current_timestamp,
  deleted_at timestamp
);

create table movement (
  id integer primary key autoincrement,
  name integer not null,
  description text,
  value real not null,
  datetime timestamp not null,
  id_account integer not null references account on update restrict on delete restrict,
  id_category integer not null references category on update restrict on delete restrict,
  created_at timestamp default current_timestamp,
  deleted_at timestamp
);

insert into category_type (id, name, created_at)
values (1, 'Não categorizado', null),
  (2, 'Renda', null),
  (3, 'Gastos Essenciais', null),
  (4, 'Estilo de Vida', null),
  (5, 'Lançamentos entre contas', null);

insert into category (name, id_category_type, color, created_at)
values ('Não categorizado', 1, '0xaaaaaaaa', null),
  ('Empréstimo', 2, '0xaaaaaaaa', null),
  ('Remuneração', 2, '0xaaaaaaaa', null),
  ('Ganhos', 2, '0xaaaaaaaa', null),
  ('Contas residenciais', 3, '0xaaaaaaaa', null),
  ('Educação', 3, '0xaaaaaaaa', null),
  ('Mercado', 3, '0xaaaaaaaa', null),
  ('Aluguel', 3, '0xaaaaaaaa', null),
  ('Saúde', 3, '0xaaaaaaaa', null),
  ('Transporte', 3, '0xaaaaaaaa', null),
  ('Academia', 4, '0xaaaaaaaa', null),
  ('Restaurante', 4, '0xaaaaaaaa', null),
  ('Compras', 4, '0xaaaaaaaa', null),
  ('Cuidados pessoais', 4, '0xaaaaaaaa', null),
  ('Família', 4, '0xaaaaaaaa', null),
  ('Lazer', 4, '0xaaaaaaaa', null),
  ('Outros gastos', 4, '0xaaaaaaaa', null),
  ('Doações', 4, '0xaaaaaaaa', null),
  ('Serviços', 4, '0xaaaaaaaa', null),
  ('Viagem', 4, '0xaaaaaaaa', null),
  ('Investimentos', 5, '0xaaaaaaaa', null),
  ('Pagamento de cartão', 5, '0xaaaaaaaa', null),
  ('Resgate', 5, '0xaaaaaaaa', null),
  ('Transferência', 5, '0xaaaaaaaa', null);

insert into account_type (name, created_at)
values ('Conta corrente', null), ('Investimento', null), ('Cartão de crédito', null), ('Carteira', null);
