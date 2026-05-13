# Seção 3.2 - Funções Básicas De Transformação De Intensidade

Páginas usadas: PDF 88-96.

## Ideia Central

- Transformações de intensidade mapeiam cada valor de entrada `r` para um valor de saída `s`.
- São operações ponto a ponto: cada pixel é processado independentemente.
- Em imagens digitais, o mapeamento pode ser implementado por tabela indexada.

## Fórmulas / Relações Importantes

```text
s = T(r)
```

```text
s = L - 1 - r
```

- Negativo de imagem.

```text
s = c log(1 + r)
```

- Transformação logarítmica.

```text
s = c r^gamma
```

- Transformação de potência, também chamada de transformação gama.

## Conceitos Principais

- Função identidade: não altera a imagem.
- Negativo: inverte os níveis de intensidade; útil para realçar detalhes claros em regiões escuras.
- Log: expande níveis escuros e comprime níveis claros; útil para comprimir faixa dinâmica.
- Potência/gama:
  - `gamma < 1`: clareia regiões escuras;
  - `gamma > 1`: escurece/comprime regiões claras;
  - usada em correção gama de dispositivos.
- Funções lineares por partes permitem controlar faixas específicas de intensidade.

![Figura 3.3 - Funções básicas de transformação de intensidade](images/fig-3-3-funcoes-basicas-intensidade.png)

![Figura 3.4 - Negativo de uma mamografia](images/fig-3-4-negativo-mamografia.png)

![Figura 3.5 - Transformação logarítmica no espectro de Fourier](images/fig-3-5-transformacao-log-fourier.png)

![Figura 3.6 - Curvas de transformação gama](images/fig-3-6-curvas-gama.png)

![Figura 3.7 - Correção gama](images/fig-3-7-correcao-gama.png)

## Alargamento, Fatiamento E Planos De Bits

- Alargamento de contraste aumenta a faixa ocupada pelos níveis de intensidade.
- Limiarização é o caso extremo que transforma a imagem em binária.
- Fatiamento de níveis realça uma faixa `[A, B]` de intensidades.
- Fatiamento por planos de bits separa uma imagem de 8 bits em 8 imagens binárias.
- Planos de bits mais significativos concentram mais informação visual.
- Planos menos significativos carregam detalhes sutis e ruído.

![Figura 3.10 - Alargamento de contraste](images/fig-3-10-alargamento-contraste.png)

![Figura 3.11 - Fatiamento de níveis de intensidade](images/fig-3-11-fatiamento-intensidade.png)

![Figura 3.12 - Fatiamento em angiograma](images/fig-3-12-fatiamento-angiograma.png)

![Figura 3.13 - Representação em planos de bits](images/fig-3-13-planos-de-bits.png)

![Figura 3.14 - Planos de bits de uma imagem de 8 bits](images/fig-3-14-planos-de-bits-dolar.png)

![Figura 3.15 - Reconstrução usando planos de bits](images/fig-3-15-reconstrucao-planos-bits.png)

## Pontos De Prova

- O que significa mapear `r` em `s`?
- Qual é a fórmula do negativo de imagem?
- Para que serve uma transformação logarítmica?
- O que acontece quando `gamma < 1`?
- O que acontece quando `gamma > 1`?
- O que é correção gama?
- O que é alargamento de contraste?
- O que é limiarização?
- O que é fatiamento de níveis de intensidade?
- O que é fatiamento por planos de bits?
- Por que os planos de bits mais significativos são mais importantes visualmente?
