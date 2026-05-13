# Seção 5.6 - Estimativa Da Função De Degradação

Páginas usadas: livro 227-230, PDF 245-248.

## Ideia Central

- Para restaurar uma imagem degradada por `H`, é preciso conhecer ou estimar `H(u,v)`.
- O capítulo apresenta três caminhos: observação da imagem, experimentação e modelagem matemática.
- Quando `H` não é conhecida em sua totalidade, o problema é frequentemente chamado de deconvolução cega.

## 5.6.1 Estimativa Pela Observação

- Usa uma pequena região da imagem degradada com sinal forte e pouco ruído aparente.
- A região é processada manualmente ou com filtros de aguçamento para obter uma estimativa da subimagem original.
- A função local de degradação é estimada por:

```text
H_s(u,v) = G_s(u,v) / F_hat_s(u,v)
```

- `G_s`: transformada da subimagem degradada.
- `F_hat_s`: transformada da subimagem estimada como original.
- Depois, extrapola-se o formato de `H_s` para a imagem inteira, assumindo invariância no espaço.

## 5.6.2 Estimativa Por Experimentação

- Requer equipamento semelhante ao usado na aquisição original.
- Captura-se uma imagem de um impulso, por exemplo um pequeno ponto de luz.
- Como a transformada de Fourier de um impulso ideal é constante:

```text
H(u,v) = G(u,v) / A
```

- `A` é a intensidade do impulso.
- É o método mais direto quando o sistema físico ainda está disponível.

## 5.6.3 Estimativa Por Modelagem

### Turbulência Atmosférica

```text
H(u,v) = exp[-k (u^2 + v^2)^(5/6)]
```

- `k` controla a severidade da turbulência.
- Quanto maior `k`, maior o borramento.
- A forma lembra um passa-baixa gaussiano, mas com potência `5/6`.

### Borramento Por Movimento

Se a imagem sofre deslocamento `x0(t), y0(t)` durante a exposição `T`:

```text
g(x,y) = integral_0^T f[x - x0(t), y - y0(t)] dt
```

No domínio da frequência:

```text
G(u,v) = H(u,v)F(u,v)
```

com:

```text
H(u,v) = integral_0^T exp{-j2pi[u x0(t) + v y0(t)]} dt
```

### Movimento Linear Uniforme

Para deslocamento final `a` em `x` e `b` em `y`:

```text
x0(t) = at/T
y0(t) = bt/T
```

```text
H(u,v) =
  T/(pi(ua+vb)) * sin[pi(ua+vb)] * exp[-j pi(ua+vb)]
```

- Quando `ua + vb` se aproxima de zero, usa-se o limite para evitar divisão por zero.
- Os zeros de `H` tornam a restauração inversa especialmente instável.

## Conta Do Movimento Em Uma Direção

Se o movimento for só na direção `x`:

```text
x0(t) = at/T
y0(t) = 0
```

então:

```text
H(u,v) = integral_0^T exp[-j2pi u(at/T)] dt
```

Integrando:

```text
H(u,v) =
  T/(pi u a) * sin(pi u a) * exp(-j pi u a)
```

- Os zeros ocorrem em `u = n/a`, para `n` inteiro não nulo.
- Esses zeros são frequências perdidas pelo borramento; não há como recuperá-las perfeitamente por inversão.

## Como Escolher O Método De Estimativa

| Situação | Método |
|---|---|
| Só há a imagem degradada | Observação da imagem |
| O equipamento ainda existe | Experimentação com impulso |
| A física do problema é conhecida | Modelagem matemática |
| Borramento atmosférico | Modelo `exp[-k(u^2+v^2)^(5/6)]` |
| Borramento por câmera em movimento | Modelo de movimento linear |

## Pontos De Prova

- Diferenciar observação, experimentação e modelagem.
- Calcular `H_s = G_s/F_hat_s` para uma região observada.
- Explicar por que um impulso permite medir a resposta do sistema.
- Escrever o modelo de turbulência atmosférica.
- Derivar a ideia de `H(u,v)` para movimento linear.
