DROP SCHEMA IF EXISTS Loja1;
CREATE SCHEMA Loja1;
USE Loja1;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nm_login_usuario VARCHAR(225) UNIQUE NOT NULL,
    nm_senha_usuario VARCHAR(225) NOT NULL
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nm_categoria VARCHAR(225) NOT NULL
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    cd_produto varchar(200) NOT NULL,          
    nm_produto VARCHAR(225) NOT NULL,
    ds_produto TEXT,
    vl_produto DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    img_produto VARCHAR(255),

    CONSTRAINT uq_cd_produto UNIQUE (cd_produto),
    CONSTRAINT fk_categoria_produto
        FOREIGN KEY (id_categoria)
        REFERENCES categoria (id_categoria)
);



/*Adicionar Categoria*/
delimiter $$

drop procedure if exists ADICIONARCATEGORIA $$

create procedure ADICIONARCATEGORIA (
    p_nome varchar(225)
)
begin
    insert into categoria (nm_categoria)
    values (p_nome);
end $$

delimiter ;


/*REMOVER CATEGORIA*/
delimiter $$
drop procedure if exists REMOVERCATEGORIA $$
create procedure REMOVERCATEGORIA (c_id int)
begin
 delete from categoria where id_categoria = c_id; 
end$$
delimiter ; 

/*ADICIONAR PRODUTO*/
delimiter $$
drop procedure if exists ADICIONARPRODUTO $$
create procedure ADICIONARPRODUTO(
    p_codigo varchar(200),
    p_nome VARCHAR(225),
    p_descricao TEXT,
    p_valor DECIMAL(10,2),
    p_categoria INT,
    p_imagem VARCHAR(255)
)
begin
    insert into produto (
        cd_produto,
        nm_produto,
        ds_produto,
        vl_produto,
        id_categoria,
        img_produto
    ) 
    values (
        p_codigo,
        p_nome,
        p_descricao,
        p_valor,
        p_categoria,
        p_imagem
    );
end$$
delimiter ;


/*REMOVER PRODUTO*/

delimiter $$
drop procedure if exists REMOVERPRODUTO $$
create procedure REMOVERPRODUTO (
    p_id INT
)
begin
    delete from produto where id_produto = p_id;
end$$
delimiter ;


/*ATUALIZAR PRODUTO*/
delimiter $$
drop procedure if exists ATUALIZARPRODUTO $$
create procedure ATUALIZARPRODUTO (
    p_id INT,
    p_codigo varchar(200),
    p_nome VARCHAR(225),
    p_descricao TEXT,
    p_valor DECIMAL(10,2),
    p_categoria INT,
    p_imagem VARCHAR(255)
)
begin
    update produto
    set
        cd_produto   = p_codigo,
        nm_produto   = p_nome,
        ds_produto   = p_descricao,
        vl_produto   = p_valor,
        id_categoria = p_categoria,
        img_produto  = p_imagem
    where id_produto = p_id;
end$$
delimiter ;

/*Listar produtos*/
delimiter $$
drop procedure if exists LISTARPRODUTOS $$
create procedure LISTARPRODUTOS()
begin
    select 
        p.id_produto,
        p.cd_produto,
        p.nm_produto,
        p.ds_produto,
        p.vl_produto,
        p.img_produto,
        p.id_categoria,     
        c.nm_categoria
    from produto p
    inner join categoria c on c.id_categoria = p.id_categoria;
end$$
delimiter ;


/*Listar Categoria*/
delimiter $$

drop procedure if exists LISTARCATEGORIAS $$

create procedure LISTARCATEGORIAS()
begin
    select 
        id_categoria,
        nm_categoria
    from categoria
    order by nm_categoria;
end$$

delimiter ;

INSERT INTO USUARIO(nm_login_usuario, nm_senha_usuario) values('admin', SHA2('123456', 256));

