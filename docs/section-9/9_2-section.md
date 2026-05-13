# Seção 9.2 - Erosão E Dilatação

Páginas usadas: livro 417-420, PDF 435-438.

## Ideia Central

- Erosão e dilatação são as duas operações fundamentais da morfologia.
- Erosão contrai objetos e remove detalhes menores que o elemento estruturante.
- Dilatação expande objetos, une lacunas e engrossa componentes.

## 9.2.1 Erosão

Definição:

```text
A ⊖ B = {z | (B)_z subset A}
```

Forma equivalente:

```text
A ⊖ B = {z | (B)_z intersect A^c = vazio}
```

Interpretação:

- O ponto `z` entra no resultado somente se `B`, transladado para `z`, couber completamente dentro de `A`.
- Se qualquer parte de `B` cair no fundo, a posição é rejeitada.
- A fronteira tende a ser removida.

## Efeito Da Erosão

- Afina objetos.
- Remove conexões estreitas.
- Remove componentes menores que o ES.
- Pode separar objetos ligados por pontes finas.
- Quanto maior o ES, mais agressiva a erosão.

## 9.2.2 Dilatação

Definição:

```text
A ⊕ B = {z | (B_hat)_z intersect A != vazio}
```

Interpretação:

- O ponto `z` entra no resultado se o ES refletido e transladado toca `A` em pelo menos um ponto.
- Em vez de exigir encaixe total, a dilatação exige sobreposição não vazia.

## Efeito Da Dilatação

- Engrossa objetos.
- Fecha pequenas lacunas.
- Une componentes próximos.
- Expande fronteiras conforme o formato do ES.
- Pode reconstruir quebras em caracteres binários sem criar tons de cinza, diferente de uma filtragem passa-baixa seguida de limiarização.

## 9.2.3 Dualidade

```text
(A ⊖ B)^c = A^c ⊕ B_hat
(A ⊕ B)^c = A^c ⊖ B_hat
```

- Erosão e dilatação são duais por complemento e reflexão.
- Se `B` é simétrico, então `B_hat = B`.
- Na prática, erodir o objeto equivale a dilatar o fundo e complementar o resultado.

## Comparação Direta

| Operação | Critério | Efeito |
|---|---|---|
| Erosão | `B` cabe inteiro em `A` | Contrai, afina, remove detalhes pequenos |
| Dilatação | `B_hat` toca `A` | Expande, engrossa, fecha lacunas |

## Receita De Implementação

Erosão binária:

```text
para cada pixel z:
  posicione a origem de B em z
  se todos os 1s de B coincidirem com 1s de A:
    saída(z) = 1
  senão:
    saída(z) = 0
```

Dilatação binária:

```text
para cada pixel z:
  posicione a origem de B_hat em z
  se algum 1 de B_hat coincidir com um 1 de A:
    saída(z) = 1
  senão:
    saída(z) = 0
```

## Como Escolher O Elemento Estruturante

| ES | Efeito típico |
|---|---|
| Quadrado | trata direções horizontal, vertical e diagonal de modo uniforme aproximado |
| Cruz | preserva conectividade-4 e evita algumas conexões diagonais |
| Linha horizontal | remove/preserva estruturas conforme orientação horizontal |
| Linha vertical | remove/preserva estruturas conforme orientação vertical |
| Disco | suavização morfológica mais isotrópica |
| ES alongado | efeito direcional controlado |

## Intuição De Tamanho

- Se o ES não cabe dentro de uma estrutura, a erosão remove essa estrutura.
- Se uma lacuna é menor que o alcance do ES, a dilatação pode fechá-la.
- Aumentar o ES aumenta o efeito, mas também aumenta perda de detalhe.
- Em prova, sempre compare o tamanho da estrutura com o tamanho do ES.

## Pontos De Prova

- Escrever as definições de erosão e dilatação.
- Explicar por que erosão remove componentes pequenos.
- Explicar por que dilatação une lacunas.
- Aplicar a dualidade com complemento e reflexão.
- Relacionar tamanho/formato do ES com o resultado.
