# Seção 9.4 - A Transformada Hit-Or-Miss

Páginas usadas: livro 423-424, PDF 441-442.

## Ideia Central

- A transformada hit-or-miss detecta padrões específicos em imagens binárias.
- Ela procura simultaneamente pixels de objeto e pixels de fundo.
- É a base para algoritmos como fecho convexo, afinamento, espessamento, esqueletização e poda.

## Definição

Considere um elemento estruturante composto por dois conjuntos:

```text
B = (B1, B2)
```

- `B1`: posições que devem casar com o objeto `A`.
- `B2`: posições que devem casar com o fundo `A^c`.

A transformada é:

```text
A hit B = (A ⊖ B1) intersect (A^c ⊖ B2)
```

Forma equivalente:

```text
A hit B = (A ⊖ B1) - (A ⊕ B2_hat)
```

## Interpretação

- `B1` precisa encontrar um acerto no objeto.
- `B2` precisa encontrar um acerto no fundo.
- A saída contém as posições da origem em que os dois casamentos ocorrem simultaneamente.

## Por Que Usar Fundo Explicitamente

- Em uma imagem binária, objetos distintos precisam estar separados por fundo.
- Casar apenas o objeto pode detectar estruturas conectadas indevidamente.
- Casar objeto e fundo permite identificar formas específicas, extremidades, cantos, junções e padrões locais.

## Caso Simplificado

- Se o fundo não importa, a hit-or-miss vira uma erosão.
- Isso ocorre quando o objetivo é detectar somente um padrão de 1s, sem restrição sobre os 0s ao redor.

## Como Montar Um Hit-Or-Miss

```text
1. Desenhe o padrão que quer detectar.
2. Marque pixels obrigatórios de objeto em B1.
3. Marque pixels obrigatórios de fundo em B2.
4. Marque o restante como "não importa".
5. Aplique erosão em A por B1.
6. Aplique erosão em A^c por B2.
7. Intersecte os resultados.
```

## Exemplo Mental

Para detectar uma extremidade de linha:

```text
B1: exige o pixel central e um vizinho de linha.
B2: exige fundo nos pixels que provariam continuação da linha.
X: marca posições que não importam.
```

- Rotacionar o par `(B1,B2)` permite detectar extremidades em outras orientações.
- Essa é a lógica usada em afinamento, poda e vários detectores de padrões morfológicos.

## Diferença Entre Erosão E Hit-Or-Miss

| Operação | Exige objeto? | Exige fundo? | Uso |
|---|---:|---:|---|
| Erosão | Sim | Não | testar se uma forma cabe no objeto |
| Hit-or-miss | Sim | Sim | detectar configuração local específica |

## Cuidados

- `B1` e `B2` não podem exigir coisas contraditórias na mesma posição.
- Pixels "não importa" não entram em `B1` nem em `B2`.
- Se o padrão pode aparecer rotacionado, é preciso usar uma sequência de elementos estruturantes rotacionados.

## Pontos De Prova

- Escrever a fórmula `(A ⊖ B1) intersect (A^c ⊖ B2)`.
- Explicar a diferença entre hit e miss.
- Explicar o papel dos pixels "não importa".
- Relacionar hit-or-miss com casamento de padrões.
