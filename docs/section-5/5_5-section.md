# Seção 5.5 - Degradações Lineares, Invariantes No Espaço

Páginas usadas: livro 225-227, PDF 243-245.

## Ideia Central

- Muitos sistemas de degradação podem ser aproximados por sistemas lineares e invariantes no espaço.
- Essa hipótese permite usar teoria de sistemas lineares, convolução e transformada de Fourier para modelar a degradação.
- A resposta ao impulso do sistema é a função de espalhamento de ponto, ou PSF.

## Modelo Geral

```text
g(x,y) = H[f(x,y)] + eta(x,y)
```

Sem ruído:

```text
g(x,y) = H[f(x,y)]
```

## Linearidade

Um operador `H` é linear se:

```text
H[a f1(x,y) + b f2(x,y)] = a H[f1(x,y)] + b H[f2(x,y)]
```

Propriedades equivalentes:

```text
H[f1 + f2] = H[f1] + H[f2]
H[a f1] = a H[f1]
```

- A primeira é aditividade.
- A segunda é homogeneidade.

## Invariância No Espaço

```text
H[f(x-alpha, y-beta)] = g(x-alpha, y-beta)
```

- A resposta depende do padrão de entrada, não da posição absoluta.
- Um mesmo ponto de luz borrado em qualquer região da imagem gera o mesmo espalhamento, apenas deslocado.

## Resposta Ao Impulso E PSF

- A imagem pode ser representada como soma/integral de impulsos ponderados.
- A resposta do sistema a um impulso define completamente um sistema linear.
- Em imagens, essa resposta é chamada de `h`, PSF ou função de espalhamento de ponto.

## Integral De Superposição

Para sistema linear geral:

```text
g(x,y) =
  integral integral f(alpha,beta) h(x,alpha,y,beta) d alpha d beta
```

Se o sistema também for invariante no espaço:

```text
g(x,y) =
  integral integral f(alpha,beta) h(x-alpha,y-beta) d alpha d beta
```

Ou seja:

```text
g(x,y) = h(x,y) * f(x,y)
```

Com ruído:

```text
g(x,y) = h(x,y) * f(x,y) + eta(x,y)
G(u,v) = H(u,v)F(u,v) + N(u,v)
```

## Interpretação

- Restauração linear é deconvolução: tentar desfazer a convolução causada por `h`.
- No espaço, a degradação é uma convolução com a PSF.
- Na frequência, a degradação é multiplicação por `H(u,v)`.
- Para DFTs discretas, produtos são termo a termo.

## Derivação Que Você Precisa Entender

Representação de uma imagem por impulsos:

```text
f(x,y) =
  integral integral f(alpha,beta) delta(x-alpha, y-beta) d alpha d beta
```

Aplicando o sistema `H`:

```text
g(x,y) = H[f(x,y)]
```

Por linearidade:

```text
g(x,y) =
  integral integral f(alpha,beta)
  H[delta(x-alpha,y-beta)] d alpha d beta
```

Definindo a resposta ao impulso:

```text
h(x,alpha,y,beta) = H[delta(x-alpha,y-beta)]
```

então:

```text
g(x,y) =
  integral integral f(alpha,beta) h(x,alpha,y,beta) d alpha d beta
```

Se também houver invariância no espaço:

```text
h(x,alpha,y,beta) = h(x-alpha,y-beta)
```

logo:

```text
g(x,y) = h(x,y) * f(x,y)
```

## Por Que Isso Importa

- Sem linearidade, não dá para decompor a imagem em impulsos e somar respostas.
- Sem invariância no espaço, a PSF muda de região para região, e uma única `H(u,v)` não descreve a imagem inteira.
- Com as duas hipóteses, a restauração vira um problema tratável por filtros no domínio da frequência.

## Pontos De Prova

- Definir linearidade e invariância no espaço.
- Explicar por que a PSF caracteriza o sistema.
- Transformar o modelo espacial para o domínio da frequência.
- Relacionar restauração linear com deconvolução.
