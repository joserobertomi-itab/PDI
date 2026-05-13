# Seção 5.9 - Filtragem Por Mínimos Quadráticos Com Restrição

Páginas usadas: livro 235-237, PDF 253-255.

## Ideia Central

- O filtro de Wiener exige informação sobre espectros de potência, que raramente são conhecidos.
- O método de mínimos quadráticos com restrição usa uma medida de suavidade da imagem restaurada e uma restrição baseada no ruído.
- O resultado ótimo depende de um único parâmetro escalar `gamma`.

## Forma Vetorial Do Modelo

```text
g = Hf + eta
```

- `g`, `f` e `eta` são vetores com `MN x 1` elementos.
- `H` é uma matriz `MN x MN`.
- Na prática, manipular essa matriz diretamente é caro; por isso a solução é formulada no domínio da frequência.

## Função De Critério

Minimizar a energia do laplaciano da estimativa:

```text
C = sum_x sum_y [nabla^2 f(x,y)]^2
```

sujeito à restrição:

```text
||g - H f_hat||^2 = ||eta||^2
```

- A restrição força o resíduo da restauração a ser compatível com a energia do ruído.
- A suavidade é medida pelo laplaciano.

## Solução No Domínio Da Frequência

```text
F_hat(u,v) =
  [ H*(u,v) / ( |H(u,v)|^2 + gamma |P(u,v)|^2 ) ] G(u,v)
```

- `gamma` é ajustado para satisfazer a restrição.
- `P(u,v)` é a DFT do operador laplaciano:

```text
p(x,y) =
[  0 -1  0
  -1  4 -1
   0 -1  0 ]
```

- Se `gamma = 0`, a expressão se reduz à filtragem inversa.

## Ajuste Iterativo De Gamma

Defina o resíduo:

```text
r = g - H f_hat
```

e:

```text
phi(gamma) = r^T r = ||r||^2
```

Como `phi(gamma)` cresce monotonicamente com `gamma`, ajusta-se `gamma` até:

```text
||r||^2 = ||eta||^2 +/- a
```

Procedimento:

```text
1. Escolha gamma inicial.
2. Calcule F_hat e r.
3. Se ||r||^2 estiver dentro da tolerância, pare.
4. Se ||r||^2 < ||eta||^2 - a, aumente gamma.
5. Se ||r||^2 > ||eta||^2 + a, reduza gamma.
```

## Cálculo Da Energia Do Ruído

Variância do ruído:

```text
sigma_eta^2 =
  (1/MN) sum_x sum_y [eta(x,y) - m_eta]^2
```

Média do ruído:

```text
m_eta = (1/MN) sum_x sum_y eta(x,y)
```

Energia total:

```text
||eta||^2 = MN [sigma_eta^2 + m_eta^2]
```

- Isso é útil porque basta estimar média e variância do ruído.

## Comparação Com Wiener

| Aspecto | Wiener | Mínimos quadráticos com restrição |
|---|---|---|
| Informação exigida | `H`, `S_eta/S_f` ou `K` | `H`, média e variância do ruído |
| Critério | Minimiza MSE estatístico | Minimiza suavidade com restrição de ruído |
| Parâmetro prático | `K` | `gamma` |
| Se parâmetro é pequeno demais | Aproxima inverso e amplifica ruído | Aproxima inverso e amplifica ruído |
| Se parâmetro é grande demais | Suaviza demais | Suaviza demais |

## Roteiro De Implementação

```text
1. Estime ou conheça H(u,v).
2. Monte P(u,v), a DFT do laplaciano preenchido com zeros.
3. Estime m_eta e sigma_eta^2.
4. Calcule ||eta||^2 = MN(sigma_eta^2 + m_eta^2).
5. Escolha gamma inicial.
6. Calcule F_hat.
7. Calcule r por R = G - H F_hat e IDFT.
8. Ajuste gamma até ||r||^2 ~= ||eta||^2.
```

## Interpretação

- O método pode superar Wiener quando `gamma` é bem ajustado.
- A otimização matemática não garante melhor percepção visual.
- Parâmetros errados de ruído geram restauração ruim, normalmente borrada ou com artefatos.

## Pontos De Prova

- Escrever a função de critério e a restrição.
- Explicar o papel do laplaciano.
- Mostrar que `gamma = 0` vira filtragem inversa.
- Calcular `||eta||^2` por média e variância.
- Descrever o ajuste iterativo de `gamma`.
