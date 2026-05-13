# Seção 5.4 - Redução De Ruído Periódico Pela Filtragem No Domínio Da Frequência

Páginas usadas: livro 220-225, PDF 238-243.

## Ideia Central

- Ruído periódico aparece como energia concentrada em pontos ou regiões específicas do espectro de Fourier.
- A estratégia é localizar essas frequências e usar filtros seletivos para rejeitar ou isolar o ruído.
- Os filtros principais são rejeita-banda, passa-banda, rejeita-notch, passa-notch e notch ótimo.

## Filtros Rejeita-Banda

- Removem uma faixa circular de frequências.
- São úteis quando os componentes de ruído estão aproximadamente em uma mesma distância da origem.
- Podem ser ideal, Butterworth ou gaussiano, como na Seção 4.10.

## Filtros Passa-Banda

- Operação complementar ao rejeita-banda:

```text
H_BP(u,v) = 1 - H_BR(u,v)
```

- Normalmente não são usados diretamente para restaurar a imagem, porque removem detalhes demais.
- São úteis para visualizar/estimar o padrão de ruído isolado.

## Filtros Notch

- Rejeitam ou passam frequências em vizinhanças localizadas.
- Devem aparecer em pares simétricos em torno da origem da transformada, exceto quando o notch está na origem.
- O número e o formato dos notches podem ser escolhidos conforme o espectro.

Relação entre passa-notch e rejeita-notch:

```text
H_PN(u,v) = 1 - H_RN(u,v)
```

- `H_RN`: rejeita as frequências selecionadas.
- `H_PN`: preserva apenas as frequências selecionadas, ajudando a visualizar o padrão removido.

## Filtragem Notch Ótima

### Passo 1 - Isolar O Ruído

```text
N(u,v) = H_PN(u,v)G(u,v)
```

```text
eta(x,y) = F^{-1}{H_PN(u,v)G(u,v)}
```

- `eta(x,y)` é uma estimativa espacial do padrão periódico.
- O filtro passa-notch costuma ser construído interativamente olhando o espectro.

### Passo 2 - Subtrair Uma Parcela Ponderada

```text
f_hat(x,y) = g(x,y) - w(x,y) eta(x,y)
```

- `w(x,y)` controla quanto do padrão estimado será subtraído localmente.
- A ideia é minimizar a variância local da estimativa restaurada.

### Variância Local

Para uma vizinhança `(2a+1) x (2b+1)`:

```text
sigma^2(x,y) =
  1/[(2a+1)(2b+1)] *
  sum_{s=-a}^{a} sum_{t=-b}^{b}
  [f_hat(x+s,y+t) - mean_local(f_hat)]^2
```

Média local:

```text
mean_local(f_hat) =
  1/[(2a+1)(2b+1)] *
  sum_{s=-a}^{a} sum_{t=-b}^{b} f_hat(x+s,y+t)
```

### Peso Ótimo Local

Assumindo `w(x,y)` aproximadamente constante na vizinhança, minimiza-se a variância local:

```text
d sigma^2(x,y) / d w(x,y) = 0
```

Resultado:

```text
w(x,y) =
  [ mean(g eta) - mean(g) mean(eta) ]
  -----------------------------------
  [ mean(eta^2) - mean(eta)^2 ]
```

- O numerador mede correlação local entre imagem degradada e padrão estimado.
- O denominador mede variância local do padrão estimado.
- Em vez de calcular `w` pixel a pixel, pode-se calculá-lo por blocos/vizinhanças não sobrepostas.

## Interpretação Dos Exemplos

- Ruído senoidal forte: aparece como pares de pontos claros no espectro; rejeita-banda pode funcionar bem se os pontos estiverem em uma faixa circular.
- Linhas de varredura: um passa-notch ajuda a isolar o padrão no espaço; o rejeita-notch correspondente remove a interferência.
- Interferência múltipla sutil: notch ótimo preserva mais informação que uma rejeição agressiva.

## Roteiro Prático Para Remover Ruído Periódico

```text
1. Calcule a DFT da imagem degradada.
2. Centralize e visualize log(1 + |G(u,v)|).
3. Procure picos simétricos fora da origem.
4. Se os picos estiverem em uma faixa circular, teste rejeita-banda.
5. Se estiverem localizados, use rejeita-notch.
6. Use passa-notch para visualizar o padrão removido.
7. Ajuste largura/ordem do filtro para remover o mínimo necessário.
8. Aplique IDFT e reajuste a faixa de intensidades.
```

## Band-Reject Versus Notch

| Caso | Use |
|---|---|
| Muitos picos aproximadamente no mesmo raio | Rejeita-banda |
| Poucos picos localizados | Rejeita-notch |
| Quer ver o ruído isolado | Passa-banda ou passa-notch |
| Picos sutis/múltiplos com risco de perder detalhe | Notch ótimo |

## Leitura Do Espectro

- Um seno 2-D puro gera dois impulsos conjugados no domínio da frequência.
- Vários senos geram vários pares de picos.
- Picos mais largos indicam interferência menos ideal ou com variação espacial.
- Notches largos removem mais ruído, mas também removem conteúdo útil.
- Notches estreitos preservam mais imagem, mas podem deixar ruído residual.

## Pontos De Prova

- Explicar por que ruído periódico aparece como picos no espectro.
- Diferenciar rejeita-banda, passa-banda, rejeita-notch e passa-notch.
- Justificar pares simétricos de notches.
- Escrever a relação `H_PN = 1 - H_RN`.
- Descrever a filtragem notch ótima: isolar `eta`, calcular `w`, subtrair `w eta`.
