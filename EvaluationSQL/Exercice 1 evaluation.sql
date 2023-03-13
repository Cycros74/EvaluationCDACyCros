
DROP DATABASE IF EXISTS exercice1_evaluation_mettre_en_place_une_base_de_donnees;
create database exercice1_evaluation_mettre_en_place_une_base_de_donnees
;

use exercice1_evaluation_mettre_en_place_une_base_de_donnees
;


create table client (
cli_num int primary key,
cli_nom varchar (50),
cli_adresse varchar (50),
cli_tel varchar (30)
)
;

create table commande (
com_num int primary key,
com_date datetime,
com_obs varchar (50),
cli_num int references client(cli_num)
)
;

create table produit (
pro_num int primary key,
pro_libelle varchar (50),
pro_description varchar (50)
)
;

create table est_compose (
com_num int references commande(com_num),
pro_num int references produit(pro_num),
est_qte int,
primary key (com_num,pro_num)
)
;

create index index1 on client (cli_nom)