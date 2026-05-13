# Seção 5.11 - Reconstrução De Imagens A Partir De Projeções

Páginas usadas: livro 238-258, PDF 256-276.

## Ideia Central

- Reconstrução a partir de projeções busca recuperar uma imagem 2-D ou volume 3-D a partir de medições feitas em várias direções.
- A aplicação central é tomografia computadorizada.
- Retroprojeção simples reconstrói a forma geral, mas gera borramento em halo.
- Retroprojeção filtrada corrige esse borramento usando filtragem no domínio da frequência ou convolução equivalente no espaço.

## 5.11.1 Introdução À Retroprojeção

- Uma projeção é formada somando a absorção ao longo de raios.
- Uma retroprojeção espalha essa projeção 1-D de volta pela imagem 2-D na direção de aquisição.
- Somar retroprojeções de vários ângulos reforça as regiões onde os raios se cruzam.
- Projeções separadas por 180 graus são espelhadas; por isso um intervalo angular de 0 a 180 graus é suficiente em feixes paralelos.

## 5.11.2 Princípios De CT

- CT de raios X busca representar a estrutura interna de um objeto a partir de projeções obtidas em vários ângulos.
- Em vez de obter uma projeção 2-D completa do corpo, CT trabalha com fatias.
- Empilhar fatias permite formar uma representação 3-D.

Gerações de scanners:

- G1: feixe em lápis, um detector, translação e rotação; geometria de feixes paralelos.
- G2: feixe em leque com múltiplos detectores; menos translações.
- G3: banco de detectores cobre todo o campo; rotação sem translação.
- G4: anel de detectores; só a fonte gira.
- G5/EBCT: feixe de elétrons, sem movimento mecânico.
- G6/helicoidal: rotação contínua enquanto o paciente se move.
- G7/multislice: múltiplas fileiras de detectores e fatias volumétricas.

## 5.11.3 Projeções E Transformada De Radon

### Linha Em Forma Normal

```text
x cos(theta) + y sen(theta) = rho
```

- `theta` define a orientação da linha.
- `rho` define a distância da linha à origem.

### Transformada De Radon Contínua

```text
g(rho,theta) =
  integral integral f(x,y)
  delta[x cos(theta) + y sen(theta) - rho] dx dy
```

- A função delta força a integral a ocorrer ao longo da linha especificada.
- `g(rho,theta)` é a projeção de `f(x,y)` naquele ângulo.

### Forma Discreta

```text
g(rho,theta) =
  sum_x sum_y f(x,y)
  delta[x cos(theta) + y sen(theta) - rho]
```

- Para `theta` fixo, variar `rho` gera uma projeção completa.
- Variar `theta` gera o conjunto de projeções.

### Senograma

- Exibir `g(rho,theta)` como imagem, com eixos `rho` e `theta`, produz um senograma.
- Um ponto fora da origem vira uma curva senoidal no senograma.

### Conta Clássica - Projeção De Um Disco

Para um disco centrado na origem:

```text
f(x,y) = A,  x^2 + y^2 <= r^2
f(x,y) = 0,  caso contrário
```

Por simetria, a projeção independe de `theta`. Para uma linha a distância `rho` da origem, o comprimento da corda dentro do disco é:

```text
2 sqrt(r^2 - rho^2)
```

Logo:

```text
g(rho,theta) = 2A sqrt(r^2 - rho^2),  |rho| <= r
g(rho,theta) = 0,                     |rho| > r
```

- Essa conta é importante porque mostra que a transformada de Radon soma intensidades ao longo de retas.

## 5.11.4 Teorema Da Fatia De Fourier

### Transformada 1-D Da Projeção

```text
G(w,theta) = integral g(rho,theta) exp(-j2pi w rho) d rho
```

### Resultado Do Teorema

```text
G(w,theta) = F(w cos(theta), w sen(theta))
```

- A transformada de Fourier 1-D de uma projeção é uma fatia radial da transformada de Fourier 2-D da imagem.
- O ângulo da fatia é o mesmo ângulo da projeção.

## 5.11.5 Retroprojeção Filtrada Por Feixes Paralelos

### Por Que Filtrar

- Retroprojeção simples acumula energia fora do objeto, produzindo halo/borramento.
- A reconstrução correta inclui um filtro rampa `|w|`.

### Fórmula Base

```text
f(x,y) =
  integral_0^pi [
    integral_{-infty}^{infty}
      |w| G(w,theta) exp(j2pi w rho) dw
  ]_{rho = x cos(theta) + y sen(theta)} d theta
```

- A integral interna filtra uma projeção.
- A integral externa soma as retroprojeções filtradas.

### Passos De Cálculo

```text
1. Para cada projeção g(rho,theta), calcule a FFT 1-D.
2. Multiplique pelo filtro rampa |w|.
3. Aplique uma janela, se necessário, para limitar banda e reduzir ringing.
4. Calcule a IFFT 1-D da projeção filtrada.
5. Retroprojete a projeção filtrada no ângulo correspondente.
6. Some todas as retroprojeções filtradas.
```

### Filtro Rampa E Janelas

- O filtro rampa ideal é `|w|`.
- Como a rampa ideal não é limitada em banda, usa-se janelamento na prática.
- Janela de Hamming/Hann:

```text
h(w) = c + (c - 1) cos(2pi w/(M-1)),  0 <= w <= M-1
h(w) = 0,                             caso contrário
```

- `c = 0.54`: Hamming.
- `c = 0.5`: Hann.
- Hamming reduz ringing, mas pode introduzir leve borramento.

### Forma Por Convolução

Se `s(rho)` é a transformada inversa do filtro rampa:

```text
f(x,y) =
  integral_0^pi [ s(rho) * g(rho,theta) ]_{rho = x cos(theta) + y sen(theta)} d theta
```

Forma expandida:

```text
f(x,y) =
  integral_0^pi [
    integral g(rho,theta)
    s(x cos(theta) + y sen(theta) - rho) d rho
  ] d theta
```

- Na prática, muitos sistemas CT usam convolução espacial por eficiência.
- Não é necessário armazenar todas as retroprojeções; basta manter uma soma acumulada.

## 5.11.6 Retroprojeção Filtrada Por Feixes Em Leque

### Geometria

- Sistemas modernos usam feixes em formato de leque.
- Um raio do feixe em leque pode ser convertido para a forma de feixes paralelos.

Relações geométricas:

```text
theta = beta + alpha
rho = D sen(alpha)
```

- `D`: distância da fonte à origem.
- `alpha`: posição angular do detector em relação ao raio central.
- `beta`: ângulo da fonte.

### Reconstrução Por Feixe Em Leque

Fórmula fundamental:

```text
f(r,phi) =
  (1/2) integral_0^{2pi} integral_{-alpha_m}^{alpha_m}
    p(alpha,beta)
    s[r cos(beta + alpha - phi) - D sen(alpha)]
    D cos(alpha) d alpha d beta
```

- `p(alpha,beta)` é a projeção em formato de leque.
- `alpha_m` é o maior ângulo necessário para cobrir a região de interesse.

### Forma Com Ponderações

Definições:

```text
q(alpha,beta) = p(alpha,beta) D cos(alpha)
h(alpha) = (1/2) [alpha/sen(alpha)]^2 s(alpha)
```

- A reconstrução pode ser implementada como convolução entre `q` e `h`.
- Diferente do feixe paralelo, surge um fator de ponderação relacionado à distância da fonte.

### Alternativa Prática

```text
1. Converter projeções de feixe em leque para geometria de feixes paralelos.
2. Aplicar retroprojeção filtrada paralela.
```

- Essa abordagem é comum em simulações e implementações didáticas.

## Questões De Amostragem

- Número de raios determina amostras por projeção.
- Número de ângulos determina quantas retroprojeções são somadas.
- Subamostragem gera aliasing e artefatos, como listras.
- Mais projeções reduzem halo e melhoram a reconstrução.

## Retroprojeção Simples Versus Filtrada

| Característica | Retroprojeção simples | Retroprojeção filtrada |
|---|---|---|
| Operação | Espalha e soma projeções | Filtra cada projeção antes de espalhar |
| Resultado | Forma geral com halo | Reconstrução mais nítida |
| Problema | Borramento acumulado | Pode ter ringing |
| Correção | Aumentar projeções ajuda, mas não resolve tudo | Janela no filtro rampa controla ringing |

## Erros Comuns

- Confundir projeção com retroprojeção: projeção mede somas; retroprojeção espalha essas somas de volta.
- Esquecer que 180 graus bastam para feixes paralelos.
- Usar rampa sem janelamento e aceitar ringing forte como se fosse estrutura real.
- Subamostrar ângulos: aparecem listras/artefatos.
- Esquecer que feixe em leque precisa de conversão geométrica ou fórmula própria.

## Pontos De Prova

- Definir projeção, retroprojeção e raysum.
- Escrever a transformada de Radon.
- Explicar o senograma.
- Enunciar o teorema da fatia de Fourier.
- Explicar por que retroprojeção simples borra.
- Listar os passos da retroprojeção filtrada.
- Explicar o papel do filtro rampa e do janelamento.
- Converter geometria de feixe em leque para feixe paralelo usando `theta = beta + alpha` e `rho = D sen(alpha)`.
