create table category_type (
  id integer primary key autoincrement,
  name text not null,
  description integer,
  created_at timestamp not null default current_timestamp,
  deleted_at timestamp
);

create table category (
  id integer primary key autoincrement,
  name text not null,
  description text,
  id_category_type integer not null constraint category_category_type_id_fk references category_type on update restrict on delete restrict,
  created_at timestamp not null default current_timestamp,
  deleted_at timestamp
);

create table account_type (
  id integer primary key autoincrement,
  name text not null,
  description text,
  created_at timestamp not null default current_timestamp,
  deleted_at timestamp
);

create table account (
  id integer primary key autoincrement,
  name text not null,
  description text,
  id_account_type integer not null references account_type on update restrict on delete restrict,
  created_at timestamp not null default current_timestamp,
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
  created_at timestamp not null default current_timestamp,
  deleted_at timestamp
);

insert into category_type (id, name)
values (1, 'Não categorizado'),
  (2, 'Renda'),
  (3, 'Gastos Essenciais'),
  (4, 'Estilo de Vida'),
  (5, 'Lançamentos entre contas');

insert into category (name, id_category_type)
values ('Não categorizado', 1),
  ('Empréstimo', 2),
  ('Remuneração', 2),
  ('Ganhos', 2),
  ('Contas residenciais', 3),
  ('Educação', 3),
  ('Mercado', 3),
  ('Aluguel', 3),
  ('Saúde', 3),
  ('Transporte', 3),
  ('Academia', 4),
  ('Restaurante', 4),
  ('Compras', 4),
  ('Cuidados pessoais', 4),
  ('Família', 4),
  ('Lazer', 4),
  ('Outros gastos', 4),
  ('Doações', 4),
  ('Serviços', 4),
  ('Viagem', 4),
  ('Investimentos', 5),
  ('Pagamento de cartão', 5),
  ('Resgate', 5),
  ('Transferência', 5);

insert into account_type (name)
values ('Conta corrente'), ('Investimento'), ('Cartão de crédito'), ('Carteira');
