INSERT INTO account (id, name,description,id_account_type,created_at) VALUES
    (1, 'Meu cartão','Meu cartão de crédido',3,(strftime('%s', 'now'))),
    (2, 'Minha conta','Minha conta em banco',1,(strftime('%s', 'now'))),
    (3, 'Minha carteira','Minha carteira que levo no bolso',4,(strftime('%s', 'now')));

INSERT INTO movement (name,value,datetime,id_account,id_category,created_at) VALUES
    ('Aluguel',1000.00,(strftime('%s', '2020-01-06')),2,8,(strftime('%s', 'now'))),
    ('Luz',200.00,(strftime('%s', '2020-01-06')),2,5,(strftime('%s', 'now'))),
    ('Água',20.40,(strftime('%s', '2020-01-06')),2,5,(strftime('%s', 'now'))),
    ('Farmácia',150.70,(strftime('%s', '2020-01-16')),1,9,(strftime('%s', 'now'))),
    ('Aluguel',1000.00,(strftime('%s', '2020-02-08')),2,8,(strftime('%s', 'now'))),
    ('Luz',150.06,(strftime('%s', '2020-02-09')),2,5,(strftime('%s', 'now'))),
    ('Água',40.00,(strftime('%s', '2020-02-08')),2,5,(strftime('%s', 'now'))),
    ('Farmácia',150.00,(strftime('%s', '2020-02-16')),1,9,(strftime('%s', 'now'))),
    ('Aluguel',1000.00,(strftime('%s', '2020-03-05')),2,8,(strftime('%s', 'now'))),
    ('Luz',200.00,(strftime('%s', '2020-03-03')),2,5,(strftime('%s', 'now'))),
    ('Água',200.40,(strftime('%s', '2020-03-04')),2,5,(strftime('%s', 'now'))),
    ('Farmácia',150.33,(strftime('%s', '2020-03-18')),1,9,(strftime('%s', 'now')));
