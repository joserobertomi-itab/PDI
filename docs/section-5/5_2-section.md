# Seção 5.2 - Modelos De Ruído

Páginas usadas: livro 205-211, PDF 223-229.

## Ideia Central

- Ruído em imagens digitais surge principalmente na aquisição e transmissão.
- O capítulo modela o ruído, em geral, como aleatório, aditivo, independente da posição e não correlacionado com a imagem.
- A exceção importante é o ruído periódico, que é dependente da posição e aparece como picos no espectro de Fourier.

## Propriedades Do Ruído

- Propriedades espaciais: distribuição dos valores de intensidade do ruído.
- Propriedades de frequência: distribuição de energia do ruído no domínio de Fourier.
- Ruído branco: espectro de Fourier aproximadamente constante.
- Ruído periódico: normalmente produzido por interferência elétrica/eletromecânica; no espectro, aparece como pares de picos conjugados.

## PDFs De Ruído

### Gaussiano

```text
p(z) = 1/(sqrt(2*pi)*sigma) * exp[-(z - z_bar)^2/(2*sigma^2)]
```

- Média: `z_bar`.
- Variância: `sigma^2`.
- Aproximadamente 70% dos valores ficam em `[z_bar - sigma, z_bar + sigma]`.
- Aproximadamente 95% ficam em `[z_bar - 2sigma, z_bar + 2sigma]`.
- Comum em circuitos eletrônicos, sensores e baixa iluminação.

### Rayleigh

```text
p(z) = (2/b)(z-a) exp[-(z-a)^2/b],  z >= a
p(z) = 0,                           z < a
```

```text
z_bar = a + sqrt(pi*b/4)
sigma^2 = b(4 - pi)/4
```

- Útil para histogramas assimétricos deslocados para a direita.
- Aparece em contextos como imagens de profundidade.

### Erlang / Gama

```text
p(z) = (a^b z^(b-1) exp(-az))/(b-1)!,  z >= 0
p(z) = 0,                              z < 0
```

```text
z_bar = b/a
sigma^2 = b/a^2
```

- `a > 0`, `b` inteiro positivo.
- Usada em alguns modelos de aquisição por laser.

### Exponencial

```text
p(z) = a exp(-az),  z >= 0
p(z) = 0,           z < 0
```

```text
z_bar = 1/a
sigma^2 = 1/a^2
```

- Caso especial da Erlang com `b = 1`.

### Uniforme

```text
p(z) = 1/(b-a),  a <= z <= b
p(z) = 0,        caso contrário
```

```text
z_bar = (a+b)/2
sigma^2 = (b-a)^2/12
```

- Menos comum como modelo físico direto, mas útil em simulações.

### Impulsivo / Sal E Pimenta

```text
p(z) = Pa,  z = a
p(z) = Pb,  z = b
p(z) = 0,   caso contrário
```

- Se `b > a`, `b` aparece como ponto claro e `a` como ponto escuro.
- Se `Pa` ou `Pb` for zero, o ruído é unipolar.
- Em imagens de 8 bits, normalmente `a = 0` e `b = 255`.
- É associado a transientes rápidos, falhas de chaveamento e erros de transmissão.

## Estimativa De Parâmetros

- Para uma subimagem `S` de intensidade quase constante, com histograma normalizado `pS(zi)`:

```text
z_bar = sum_{i=0}^{L-1} zi pS(zi)
sigma^2 = sum_{i=0}^{L-1} (zi - z_bar)^2 pS(zi)
```

- O formato do histograma sugere a PDF.
- Para ruído gaussiano, média e variância especificam o modelo.
- Para Rayleigh, Erlang, exponencial e uniforme, média e variância ajudam a estimar `a` e `b`.
- Para ruído impulsivo, estimam-se `Pa` e `Pb` pelos picos nos níveis preto e branco.

## Contas Úteis Para Recuperar Parâmetros

Quando a prova der média `m` e variância `sigma^2`, você pode inverter algumas relações:

### Uniforme

```text
m = (a+b)/2
sigma^2 = (b-a)^2/12

b - a = sqrt(12 sigma^2)
a = m - sqrt(12 sigma^2)/2
b = m + sqrt(12 sigma^2)/2
```

### Exponencial

```text
m = 1/a
sigma^2 = 1/a^2

a = 1/m
sigma = m
```

### Erlang

```text
m = b/a
sigma^2 = b/a^2

a = m/sigma^2
b = m^2/sigma^2
```

- Como `b` precisa ser inteiro positivo no modelo de Erlang do livro, arredondamentos precisam ser justificados pelo contexto.

### Rayleigh

```text
m = a + sqrt(pi b / 4)
sigma^2 = b(4-pi)/4

b = 4 sigma^2/(4-pi)
a = m - sqrt(pi b / 4)
```

### Impulsivo

```text
Pa ~= numero de pixels com intensidade a / total de pixels
Pb ~= numero de pixels com intensidade b / total de pixels
```

## Como Reconhecer Pelo Histograma

| Ruído | Assinatura no histograma |
|---|---|
| Gaussiano | Sino simétrico em torno da média |
| Rayleigh | Assimétrico, deslocado, cauda à direita |
| Erlang/gama | Assimétrico, começa em zero, controlado por `a` e `b` |
| Exponencial | Decai rapidamente a partir de zero |
| Uniforme | Distribuição quase plana entre `a` e `b` |
| Sal e pimenta | Picos nos extremos preto/branco |
| Periódico | Mais evidente no espectro do que no histograma |

## Pontos De Prova

- Reconhecer PDFs pelos seus parâmetros e formatos.
- Saber quando ruído periódico aparece como picos no espectro.
- Calcular média e variância a partir de um histograma.
- Explicar por que o ruído sal e pimenta costuma saturar em preto/branco.
