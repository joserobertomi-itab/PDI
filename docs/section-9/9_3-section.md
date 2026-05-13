# Seção 9.3 - Abertura E Fechamento

Páginas usadas: livro 420-423, PDF 438-441.

## Ideia Central

- Abertura e fechamento combinam erosão e dilatação.
- Abertura remove estruturas claras/objetos finos que não acomodam o ES.
- Fechamento preenche lacunas e pequenos buracos que o ES consegue cobrir.

## Abertura

```text
A o B = (A ⊖ B) ⊕ B
```

- Primeiro erode, depois dilata.
- Suaviza contornos.
- Rompe istmos finos.
- Remove saliências finas e pequenas ilhas.
- Não restaura necessariamente a forma original dos objetos erodidos.

Interpretação geométrica:

- Pense em `B` como um disco rolando por dentro de `A`.
- A abertura preserva regiões onde o ES consegue se encaixar.
- Teoria dos conjuntos:

```text
A o B = union { (B)_z | (B)_z subset A }
```

## Fechamento

```text
A . B = (A ⊕ B) ⊖ B
```

- Primeiro dilata, depois erode.
- Suaviza contornos.
- Funde quebras estreitas.
- Preenche pequenos buracos.
- Alonga golfos finos.

Interpretação geométrica:

- Pense em `B` rolando por fora da fronteira de `A`.
- O fechamento preserva a forma externa enquanto fecha reentrâncias estreitas.

## Dualidade

```text
(A . B)^c = A^c o B_hat
(A o B)^c = A^c . B_hat
```

- Se `B` é simétrico, `B_hat = B`, e a dualidade fica mais simples.

## Propriedades

Abertura:

```text
A o B subset A
se C subset D, então C o B subset D o B
(A o B) o B = A o B
```

Fechamento:

```text
A subset A . B
se C subset D, então C . B subset D . B
(A . B) . B = A . B
```

- A terceira propriedade é idempotência: aplicar novamente não muda o resultado.

## Abertura Versus Fechamento

| Operação | Remove | Preserva melhor |
|---|---|---|
| Abertura | Saliências claras, pontes finas, ilhas pequenas | Fundo e objetos maiores que o ES |
| Fechamento | Lacunas, buracos pequenos, quebras estreitas | Massa geral dos objetos |

## Pontos De Prova

- Escrever abertura e fechamento como composições.
- Explicar a interpretação de "bola/disco rolante".
- Diferenciar o que abertura remove e o que fechamento preenche.
- Usar propriedades de inclusão e idempotência.
