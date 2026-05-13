# Seção 5.3 - Restauração Na Presença Somente De Ruído

Páginas usadas: livro 211-220, PDF 229-238.

## Ideia Central

- Quando a única degradação é ruído aditivo, o modelo se simplifica e a filtragem espacial vira a abordagem principal.
- O objetivo é reduzir ruído preservando bordas, detalhes e estruturas finas.
- A escolha do filtro depende fortemente do tipo de ruído.

## Modelo Simplificado

```text
g(x,y) = f(x,y) + eta(x,y)
G(u,v) = F(u,v) + N(u,v)
```

- Como `eta` é desconhecido, não é realista subtrair diretamente o ruído.
- Para ruído periódico, às vezes `N(u,v)` pode ser estimado no espectro.
- Para ruído aleatório aditivo, usa-se filtragem espacial.

## Filtros De Média

### Média Aritmética

```text
f_hat(x,y) = (1/mn) sum_{(s,t) in Sxy} g(s,t)
```

- Equivale a uma máscara `m x n` com todos os coeficientes iguais a `1/mn`.
- Reduz ruído por suavização.
- Custo: borra bordas e detalhes.

### Média Geométrica

```text
f_hat(x,y) = [ prod_{(s,t) in Sxy} g(s,t) ]^(1/mn)
```

- Suaviza de modo comparável à média aritmética.
- Tende a preservar mais detalhes.
- Exige cuidado com pixels zero, pois o produto pode zerar.

### Média Harmônica

```text
f_hat(x,y) = mn / sum_{(s,t) in Sxy} [1/g(s,t)]
```

- Funciona bem para ruído de sal.
- Falha para ruído de pimenta.
- Também pode funcionar razoavelmente para ruído gaussiano.

### Média Contra-Harmônica

```text
f_hat(x,y) =
  sum_{(s,t) in Sxy} g(s,t)^(Q+1)
  --------------------------------
  sum_{(s,t) in Sxy} g(s,t)^Q
```

- `Q` é a ordem do filtro.
- `Q > 0`: reduz ruído de pimenta.
- `Q < 0`: reduz ruído de sal.
- `Q = 0`: vira média aritmética.
- `Q = -1`: vira média harmônica.
- Não remove sal e pimenta ao mesmo tempo; escolher o sinal errado de `Q` degrada muito a imagem.

## Filtros De Estatística De Ordem

### Mediana

```text
f_hat(x,y) = mediana { g(s,t) | (s,t) in Sxy }
```

- Excelente para ruído impulsivo unipolar ou bipolar.
- Preserva bordas melhor que filtros lineares de média.
- Passagens repetidas removem mais impulsos, mas também aumentam borramento.

### Máximo

```text
f_hat(x,y) = max { g(s,t) | (s,t) in Sxy }
```

- Remove ruído de pimenta, pois escolhe valores altos.
- Pode engrossar regiões claras e reduzir regiões escuras.

### Mínimo

```text
f_hat(x,y) = min { g(s,t) | (s,t) in Sxy }
```

- Remove ruído de sal, pois escolhe valores baixos.
- Pode engrossar regiões escuras e reduzir regiões claras.

### Ponto Médio

```text
f_hat(x,y) = 0.5 * [ max_{Sxy} g(s,t) + min_{Sxy} g(s,t) ]
```

- Combina estatística de ordem com média.
- Mais adequado para ruído aleatório como gaussiano ou uniforme.

### Média Alfa Cortada

```text
f_hat(x,y) = (1/(mn-d)) sum_{(s,t) in Sxy} gr(s,t)
```

- Remove `d/2` menores e `d/2` maiores valores da vizinhança.
- `gr` representa os `mn-d` pixels restantes.
- `d = 0`: média aritmética.
- `d = mn - 1`: mediana.
- Útil quando há mistura de ruído gaussiano/uniforme com sal e pimenta.

## Filtros Adaptativos

### Redução De Ruído Local

O filtro usa a média e a variância locais:

```text
f_hat(x,y) = g(x,y) - (sigma_eta^2 / sigma_L^2) [g(x,y) - m_L]
```

- `sigma_eta^2`: variância global do ruído.
- `m_L`: média local em `Sxy`.
- `sigma_L^2`: variância local em `Sxy`.

Comportamento esperado:

- Se `sigma_eta^2 = 0`, retorna `g(x,y)`.
- Se `sigma_L^2` é grande, tende a preservar `g(x,y)`, pois pode haver borda.
- Se `sigma_L^2` é próxima da variância do ruído, aproxima o resultado da média local.
- Na implementação, se `sigma_eta^2 > sigma_L^2`, corta-se a razão para `1` para evitar resultados sem sentido.

### Mediana Adaptativa

Definições:

```text
z_min = mínimo em Sxy
z_max = máximo em Sxy
z_med = mediana em Sxy
z_xy  = valor em (x,y)
S_max = tamanho máximo permitido da janela
```

Estágio A:

```text
A1 = z_med - z_min
A2 = z_med - z_max
se A1 > 0 e A2 < 0: ir para Estágio B
senão: aumentar janela
```

Estágio B:

```text
B1 = z_xy - z_min
B2 = z_xy - z_max
se B1 > 0 e B2 < 0: saída = z_xy
senão: saída = z_med
```

- O Estágio A testa se a mediana é impulso.
- O Estágio B testa se o pixel central é impulso.
- Se a janela chega a `S_max` sem passar no Estágio A, retorna `z_med`.
- Preserva mais detalhes que a mediana fixa em ruído impulsivo denso.

## Guia De Escolha

- Gaussiano/uniforme: média aritmética, geométrica, ponto médio ou adaptativo local.
- Sal: harmônica, contra-harmônica com `Q < 0`, mínimo.
- Pimenta: contra-harmônica com `Q > 0`, máximo.
- Sal e pimenta bipolar: mediana ou mediana adaptativa.
- Ruído misto: média alfa cortada.
- Quando bordas importam: preferir adaptativos ou mediana em vez de média simples.

## Tabela Comparativa Dos Filtros

| Filtro | Melhor para | Preserva detalhe? | Risco principal |
|---|---|---:|---|
| Média aritmética | Ruído aleatório simples | Baixo | Borramento |
| Média geométrica | Ruído gaussiano/uniforme | Médio | Sensível a zeros |
| Média harmônica | Ruído de sal | Médio | Falha com pimenta |
| Contra-harmônica | Sal ou pimenta isolados | Médio | Sinal errado de `Q` destrói o resultado |
| Mediana | Sal e pimenta | Alto | Muitas passagens borram |
| Máximo | Pimenta | Baixo/médio | Expande regiões claras |
| Mínimo | Sal | Baixo/médio | Expande regiões escuras |
| Ponto médio | Gaussiano/uniforme | Médio | Sensível a extremos |
| Alfa cortada | Ruído misto | Alto | Escolha ruim de `d` vira média ou mediana demais |
| Adaptativo local | Gaussiano com bordas | Alto | Precisa estimar `sigma_eta^2` |
| Mediana adaptativa | Sal e pimenta denso | Alto | Mais caro computacionalmente |

## Contas Rápidas De Casos Especiais

Média contra-harmônica:

```text
Q = 0:
f_hat = sum g^(1) / sum g^0 = sum g / mn
=> média aritmética

Q = -1:
f_hat = sum g^0 / sum g^(-1) = mn / sum(1/g)
=> média harmônica
```

Mediana adaptativa:

```text
Se z_min < z_med < z_max:
  z_med não é impulso extremo, então teste z_xy.

Se z_min < z_xy < z_max:
  mantenha z_xy, preservando detalhe.
Senão:
  substitua por z_med.
```

## Erros Comuns

- Usar média aritmética para sal e pimenta forte: suaviza, mas deixa impulsos e borra detalhes.
- Usar contra-harmônica sem saber a polaridade do ruído: `Q` com sinal errado amplifica o problema.
- Aumentar indefinidamente a janela: reduz ruído, mas destrói bordas.
- Fazer várias medianas sem critério: cada passagem remove impulsos restantes, mas também remove estrutura fina.

## Pontos De Prova

- Relacionar cada filtro ao tipo de ruído mais adequado.
- Saber o efeito do sinal de `Q` na média contra-harmônica.
- Explicar por que média aritmética reduz ruído mas borra.
- Derivar os casos especiais da média contra-harmônica (`Q=0`, `Q=-1`).
- Explicar os dois estágios da mediana adaptativa.
