USE NOTA_FISCAL_NORMALIZADA;

-- FORMA CLÁSSICA DE CONSULTAS COMBINADAS
SELECT NOTA_FISCAL.*, ITEM_NOTA_FISCAL.* 
FROM NOTA_FISCAL, ITEM_NOTA_FISCAL
WHERE NOTA_FISCAL.NRO_NOTA = ITEM_NOTA_FISCAL.NRO_NOTA;

-- Podemos definir ALIAS (apelidos) para as tabelas e facilitar a codificação
SELECT NF.NRO_NOTA, NF.DT_EMISSAO, NF.VL_TOTAL, 
INF.COD_PRODUTO, P.DESC_PRODUTO, P.UN_MED,
INF.QTD_PRODUTO, INF.VL_PRECO, 
INF.VL_TOTAL
FROM 
	NOTA_FISCAL AS NF,
	ITEM_NOTA_FISCAL AS INF,
	PRODUTO AS P
WHERE 
	NF.NRO_NOTA = INF.NRO_NOTA
	AND INF.COD_PRODUTO = P.COD_PRODUTO
ORDER BY 
	NF.NRO_NOTA DESC, INF.COD_PRODUTO ASC;
    
-- INNER JOIN
SELECT NF.NRO_NOTA, NF.DT_EMISSAO, NF.VL_TOTAL, 
INF.COD_PRODUTO, P.DESC_PRODUTO, P.UN_MED,
INF.QTD_PRODUTO, INF.VL_PRECO, 
INF.VL_TOTAL
FROM 
	NOTA_FISCAL AS NF 
    INNER JOIN
		ITEM_NOTA_FISCAL AS INF ON NF.NRO_NOTA = INF.NRO_NOTA
	INNER JOIN
		PRODUTO AS P ON INF.COD_PRODUTO = P.COD_PRODUTO
WHERE NF.NRO_NOTA = 4
ORDER BY 
	NF.NRO_NOTA DESC, INF.COD_PRODUTO ASC;
    
-- FUNÇÕES DE AGREGAÇÃO
-- Contando e quantificando registros

-- Quantas notas fisais tem emitidas?
SELECT COUNT(*) 
FROM NOTA_FISCAL;

-- NOTAS FISCAIS POR PERÍODO
SELECT COUNT(*)
FROM NOTA_FISCAL
WHERE DT_EMISSAO > '2025-03-21' 
AND DT_EMISSAO < '2025-03-25';

SELECT COUNT(*)
FROM NOTA_FISCAL
WHERE DT_EMISSAO BETWEEN '2025-03-21' 
AND DT_EMISSAO < '2025-03-25';

-- TOTAL DE NOTAS NO ANO
SELECT COUNT(*)
FROM NOTA_FISCAL
WHERE YEAR(DT_EMISSAO) = 2025;

-- MAX() -> Obtendo o cliente que mais comprou determinado produto em uma única NF
SELECT 
	NF.NM_CLIENTE AS CLIENTE, 
    P.DESC_PRODUTO AS PRODUTO,
    MAX(QTD_PRODUTO) AS QTD
FROM ITEM_NOTA_FISCAL AS INF
INNER JOIN NOTA_FISCAL AS NF 
	ON INF.NRO_NOTA = NF.NRO_NOTA
INNER JOIN PRODUTO AS P
	ON INF.NRO_NOTA = NF.NRO_NOTA
-- WHERE INF.COD_PRODUTO = 2
GROUP BY NF.NM_CLIENTE, P.DESC_PRODUTO -- CASO TENHA MAIS CLIENTES
ORDER BY CLIENTE, QTD DESC;
