# Seção 5 - Restauração e Reconstrução de Imagens

Páginas usadas: livro 204-258, PDF 222-276.

## Ideia Central

- Restauração tenta recuperar uma imagem degradada usando um modelo explícito da degradação.
- Diferente de realce, que é mais subjetivo, restauração é guiada por hipóteses sobre ruído, borramento, função de degradação e critérios de erro.
- O capítulo trabalha com dois blocos principais:
  - restauração de imagens degradadas por ruído;
  - reconstrução de imagens a partir de projeções, com foco em tomografia computadorizada.

## Modelo Mental Do Capítulo

- A imagem observada `g(x,y)` é uma versão degradada da imagem original `f(x,y)`.
- A degradação pode envolver:
  - uma função de borramento/degradação `h(x,y)` ou `H(u,v)`;
  - ruído aditivo `eta(x,y)` ou `N(u,v)`.
- Quando a degradação é linear e invariante no espaço, o modelo vira uma convolução no espaço e uma multiplicação no domínio da frequência.
- A restauração procura estimar `f(x,y)`, geralmente indicada por `f_hat(x,y)`.

## Mapa Das Subseções

- [5.1](5_1-section.md): modelo degradação/restauração.
- [5.2](5_2-section.md): modelos probabilísticos de ruído.
- [5.3](5_3-section.md): filtragem espacial quando há apenas ruído.
- [5.4](5_4-section.md): redução de ruído periódico no domínio da frequência.
- [5.5](5_5-section.md): degradações lineares invariantes no espaço.
- [5.6](5_6-section.md): estimativa da função de degradação.
- [5.7](5_7-section.md): filtragem inversa.
- [5.8](5_8-section.md): filtragem de Wiener.
- [5.9](5_9-section.md): mínimos quadráticos com restrição.
- [5.10](5_10-section.md): filtro de média geométrica.
- [5.11](5_11-section.md): reconstrução a partir de projeções.

## Fórmulas Base

```text
g(x,y) = h(x,y) * f(x,y) + eta(x,y)
G(u,v) = H(u,v)F(u,v) + N(u,v)
```

- `*` indica convolução.
- `H(u,v)` é a função de transferência da degradação.
- `N(u,v)` é a transformada do ruído.
- Se `H` for identidade, o problema vira redução de ruído.
- Se `eta = 0`, o problema vira inversão/deconvolução ideal.

## Como Estudar A Seção

1. Domine o modelo `g = h*f + eta`; ele reaparece em quase todas as fórmulas.
2. Separe mentalmente dois problemas:
   - só ruído: use filtros espaciais ou filtros seletivos se o ruído for periódico;
   - borramento + ruído: use deconvolução, Wiener ou mínimos quadráticos com restrição.
3. Para cada filtro, sempre pergunte:
   - que tipo de ruído/degradação ele assume?
   - que informação ele exige?
   - o que ele sacrifica: detalhe, borda, ruído residual ou estabilidade?

## Mapa De Decisão

| Situação | Melhor ponto de partida | Motivo |
|---|---|---|
| Ruído gaussiano ou uniforme | Média geométrica, média aritmética, adaptativo local | Suavizam variações aleatórias |
| Ruído sal e pimenta | Mediana ou mediana adaptativa | Remove impulsos preservando bordas |
| Só ruído de sal | Mínimo ou contra-harmônico com `Q < 0` | Suprime pixels claros |
| Só ruído de pimenta | Máximo ou contra-harmônico com `Q > 0` | Suprime pixels escuros |
| Ruído misto | Média alfa cortada | Remove extremos e ainda faz média |
| Ruído periódico | Rejeita-notch ou rejeita-banda | O ruído aparece como picos no espectro |
| Borramento conhecido e pouco ruído | Filtragem inversa limitada | Simples, mas instável |
| Borramento com ruído | Wiener | Controla amplificação de ruído |
| H conhecido e média/variância do ruído conhecidas | Mínimos quadráticos com restrição | Usa restrição baseada na energia do ruído |
| Projeções de CT | Retroprojeção filtrada | Corrige o halo da retroprojeção simples |

## Formulário Essencial

```text
Modelo espacial:
g(x,y) = h(x,y) * f(x,y) + eta(x,y)

Modelo frequência:
G(u,v) = H(u,v)F(u,v) + N(u,v)

Somente ruído:
g(x,y) = f(x,y) + eta(x,y)

Filtro inverso:
F_hat = G/H = F + N/H

Wiener:
F_hat = [H* / (|H|^2 + S_eta/S_f)] G

Wiener prático:
F_hat = [H* / (|H|^2 + K)] G

Mínimos quadráticos com restrição:
F_hat = [H* / (|H|^2 + gamma |P|^2)] G

Radon:
g(rho,theta) = integral integral f(x,y) delta[x cos(theta)+y sen(theta)-rho] dxdy

Fatia de Fourier:
G(w,theta) = F(w cos(theta), w sen(theta))
```

## Pontos De Prova

- Diferença entre realce e restauração.
- Papel de `H`, `h`, `eta` e `N`.
- Por que ruído aditivo aleatório costuma ser tratado no espaço.
- Por que borramento é tratado com mais força no domínio da frequência.
- Por que restauração ótima em métrica matemática nem sempre é a melhor visualmente.
