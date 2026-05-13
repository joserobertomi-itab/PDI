# Seção 5.10 - Filtro De Média Geométrica

Páginas usadas: livro 237-238, PDF 255-256.

## Ideia Central

- O filtro de média geométrica generaliza a filtragem de Wiener e a filtragem inversa em uma única família paramétrica.
- Ele combina dois fatores: um termo de inversão e um termo do tipo Wiener.

## Fórmula

```text
F_hat(u,v) =
  [ H*(u,v) / |H(u,v)|^2 ]^alpha
  *
  [ H*(u,v) / ( |H(u,v)|^2 + beta S_eta(u,v)/S_f(u,v) ) ]^(1-alpha)
  *
  G(u,v)
```

- `alpha` e `beta` são constantes reais positivas.
- O primeiro colchete é o comportamento de filtro inverso.
- O segundo colchete é o comportamento de Wiener parametrizado.

## Casos Especiais

- `alpha = 1`: filtro inverso.
- `alpha = 0`: filtro paramétrico de Wiener.
- `alpha = 0` e `beta = 1`: filtro de Wiener padrão.
- `alpha = 1/2`: média geométrica dos dois termos.
- `alpha = 1/2` e `beta = 1`: também chamado de filtro de equalização de espectro.

## Interpretação

- Aumentar peso do termo inverso tende a recuperar mais altas frequências, mas amplifica ruído.
- Aumentar peso do termo Wiener tende a estabilizar a restauração, mas pode suavizar mais.
- A expressão é útil porque reúne várias estratégias em uma única implementação.

## Leitura Dos Parâmetros

| Parâmetro | Efeito |
|---|---|
| `alpha` próximo de 1 | Mais comportamento de filtro inverso |
| `alpha` próximo de 0 | Mais comportamento de Wiener |
| `beta` maior | Mais peso para o termo de ruído |
| `beta` menor | Restauração mais agressiva |

## Como Pensar Na Fórmula

```text
resultado = (inverso)^alpha * (wiener_parametrico)^(1-alpha) * G
```

- A potência `alpha` controla a confiança na inversão.
- A potência `1-alpha` controla a confiança na regularização tipo Wiener.
- Por ser uma média geométrica, o filtro não soma os comportamentos: ele multiplica fatores ponderados por expoentes.

## Pontos De Prova

- Identificar os casos especiais por `alpha` e `beta`.
- Explicar por que a família interpola entre inversão e Wiener.
- Relacionar estabilidade com o termo `S_eta/S_f`.
