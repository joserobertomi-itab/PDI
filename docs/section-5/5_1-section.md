# Seção 5.1 - Modelo De Processo De Degradação/Restauração

Páginas usadas: livro 205, PDF 223.

## Ideia Central

- A imagem degradada é modelada como resultado de uma função de degradação aplicada à imagem original mais ruído aditivo.
- A restauração usa conhecimento prévio de `H` e `eta` para estimar `f_hat(x,y)`, uma aproximação da imagem original.
- Quanto melhor o conhecimento sobre a degradação e o ruído, melhor tende a ser a restauração.

## Fórmulas / Relações Importantes

- Modelo espacial para degradação linear invariante no espaço:

```text
g(x,y) = h(x,y) * f(x,y) + eta(x,y)
```

- Modelo equivalente no domínio da frequência:

```text
G(u,v) = H(u,v)F(u,v) + N(u,v)
```

- Relação operacional:

```text
convolução no espaço <=> multiplicação na frequência
```

## Conceitos Principais

- `f(x,y)`: imagem original.
- `g(x,y)`: imagem observada/degradada.
- `h(x,y)`: representação espacial da degradação.
- `H(u,v)`: função de transferência da degradação.
- `eta(x,y)`: ruído aditivo no espaço.
- `N(u,v)`: ruído no domínio da frequência.
- `f_hat(x,y)`: estimativa restaurada da imagem original.

## Interpretação

- Se a degradação for apenas ruído, o problema é reduzir `eta`.
- Se houver borramento, `H` precisa ser estimada ou conhecida.
- Se `H` tiver zeros ou valores muito pequenos, a inversão direta fica instável.

## Pontos De Prova

- Escrever o modelo no espaço e na frequência.
- Explicar por que a frequência simplifica a convolução.
- Identificar o que precisa ser conhecido para restaurar uma imagem.
