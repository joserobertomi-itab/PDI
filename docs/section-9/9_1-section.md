# Seção 9.1 - Algumas Definições Básicas

Páginas usadas: livro 415-417, PDF 433-435.

## Ideia Central

- A linguagem da morfologia matemática é a teoria dos conjuntos.
- Em imagens binárias, objetos são conjuntos de pixels.
- Operações morfológicas usam elementos estruturantes para examinar a imagem.

## Conceitos Principais

- `A`: conjunto de pixels do objeto na imagem.
- `A^c`: complemento de `A`, normalmente o fundo.
- `B`: elemento estruturante.
- `B_hat`: reflexão de `B`.
- `(B)_z`: translação de `B` pelo vetor `z`.
- `Z^2`: espaço dos pares inteiros `(x,y)` usados em imagens digitais binárias.
- Em imagens em níveis de cinza, pode-se pensar em conjuntos em `Z^3`: `(x,y,intensidade)`.

## Reflexão

```text
B_hat = {w | w = -b, para b in B}
```

- Troca cada ponto `(x,y)` por `(-x,-y)`.
- É análoga à rotação/inversão usada em convolução espacial.
- Importante principalmente na definição de dilatação.

## Translação

```text
(B)_z = {c | c = b + z, para b in B}
```

- Se `z = (z1,z2)`, cada ponto `(x,y)` vira `(x+z1, y+z2)`.
- A translação é o movimento do elemento estruturante pela imagem.

## Elemento Estruturante

- É uma pequena subimagem usada como sonda.
- Pode ter formato quadrado, linha, disco, cruz, pares de padrões etc.
- A origem precisa ser especificada.
- Elementos marcados como "não importa" são usados em casamento de padrões.
- Para implementação, o ES costuma ser armazenado em uma matriz retangular, preenchendo o restante com fundo.

## Interpretação Operacional

Para cada posição da origem do ES:

```text
1. Posicione B sobre a imagem.
2. Verifique encaixe, interseção ou padrão.
3. Marque ou não marque a posição de saída.
4. Repita até varrer a imagem.
```

## Pontos De Prova

- Explicar por que morfologia usa conjuntos.
- Definir reflexão e translação.
- Explicar o papel da origem do elemento estruturante.
- Saber que somente os elementos pertencentes ao ES importam; o preenchimento retangular é detalhe de implementação.
