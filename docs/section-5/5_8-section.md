# Seção 5.8 - Filtragem De Mínimo Erro Quadrático Médio (Wiener)

Páginas usadas: livro 232-235, PDF 250-253.

## Ideia Central

- O filtro de Wiener melhora a filtragem inversa ao incorporar estatísticas do ruído e da imagem.
- Ele busca minimizar o erro quadrático médio entre a imagem original e a estimativa restaurada.
- Quando não há ruído, o filtro se reduz ao filtro inverso.

## Critério De Erro

```text
e^2 = E{(f - f_hat)^2}
```

- `E{}` é valor esperado.
- Assume-se que imagem e ruído não são correlacionados.
- Também se assume média zero para ruído ou imagem e uma restauração linear.

## Filtro De Wiener

Forma geral:

```text
F_hat(u,v) =
  [ H*(u,v) / ( |H(u,v)|^2 + S_eta(u,v)/S_f(u,v) ) ] G(u,v)
```

Forma equivalente:

```text
F_hat(u,v) =
  [ (1/H(u,v)) *
    ( |H(u,v)|^2 / ( |H(u,v)|^2 + S_eta(u,v)/S_f(u,v) ) )
  ] G(u,v)
```

Termos:

- `H*(u,v)`: conjugado complexo de `H`.
- `|H(u,v)|^2 = H*(u,v)H(u,v)`.
- `S_eta(u,v) = |N(u,v)|^2`: espectro de potência do ruído.
- `S_f(u,v) = |F(u,v)|^2`: espectro de potência da imagem não degradada.

## Aproximação Prática

Quando `S_eta/S_f` não é conhecido, usa-se uma constante `K`:

```text
F_hat(u,v) =
  [ H*(u,v) / ( |H(u,v)|^2 + K ) ] G(u,v)
```

- `K` controla o compromisso entre restauração e supressão de ruído.
- `K` pequeno aproxima filtragem inversa.
- `K` grande reduz amplificação de ruído, mas aumenta suavização.

## Por Que Wiener É Mais Estável Que O Inverso

Compare:

```text
Filtro inverso:  1/H
Wiener:          H* / (|H|^2 + S_eta/S_f)
```

- No filtro inverso, se `H` é pequeno, `1/H` fica enorme.
- No Wiener, o termo `S_eta/S_f` impede o denominador de ficar pequeno demais.
- Onde o ruído domina o sinal, `S_eta/S_f` aumenta e o filtro reduz a confiança naquela frequência.
- Onde o sinal domina o ruído, o filtro se aproxima da inversão.

## Casos-Limite

Sem ruído:

```text
S_eta = 0
F_hat = [H*/|H|^2]G = G/H
```

Ruído muito alto:

```text
S_eta/S_f grande
=> filtro reduz magnitude da restauração
=> menos ruído amplificado, mais suavização
```

## Métricas

SNR no domínio da frequência:

```text
SNR = [sum_u sum_v |F(u,v)|^2] / [sum_u sum_v |N(u,v)|^2]
```

MSE no domínio espacial:

```text
MSE = (1/MN) sum_x sum_y [f(x,y) - f_hat(x,y)]^2
```

SNR usando imagem restaurada:

```text
SNR =
  [sum_x sum_y f_hat(x,y)^2]
  --------------------------------
  [sum_x sum_y (f(x,y)-f_hat(x,y))^2]
```

## Interpretação Dos Exemplos

- A filtragem inversa pode remover borramento, mas deixa uma "cortina" de ruído.
- O Wiener costuma produzir resultado visual melhor quando há ruído, porque evita divisões explosivas por `H`.
- Quanto menor o ruído, mais o resultado se aproxima da inversão ideal.

## Pontos De Prova

- Escrever o filtro de Wiener.
- Explicar o papel de `S_eta/S_f`.
- Mostrar que, se `S_eta = 0`, Wiener vira filtro inverso.
- Diferenciar MSE e SNR.
- Explicar o papel prático da constante `K`.
