# Seção 9.5 - Alguns Algoritmos Morfológicos Básicos

Páginas usadas: livro 424-437, PDF 442-455.

## Ideia Central

- Operações morfológicas simples podem ser combinadas para extrair atributos de forma.
- A seção apresenta algoritmos para fronteiras, buracos, componentes conexos, fecho convexo, afinamento, espessamento, esqueleto, poda e reconstrução.
- O padrão recorrente é aplicar uma operação iterativa e limitar seu crescimento por uma máscara.

## Padrão Recorrente Dos Algoritmos

Muitos algoritmos desta seção seguem a mesma ideia:

```text
novo = operação(corrente) limitada_por_máscara
repita até novo = corrente
```

- Em preenchimento de buracos, o marcador cresce dentro de `A^c`.
- Em componentes conexos, o marcador cresce dentro de `A`.
- Em reconstrução, o marcador cresce ou diminui sem ultrapassar a máscara.
- A estabilidade é a condição de parada.

## 9.5.1 Extração De Fronteiras

```text
beta(A) = A - (A ⊖ B)
```

- `B` normalmente é um ES pequeno, como `3 x 3` com todos 1s.
- A erosão remove a borda do objeto.
- A diferença entre o objeto original e o objeto erodido deixa apenas a fronteira.
- ES maior gera fronteira mais espessa.

Leitura operacional:

```text
fronteira = objeto original - interior preservado pela erosão
```

## 9.5.2 Preenchimento De Buracos

Um buraco é uma região de fundo cercada por pixels de frente conectados.

Com um ponto inicial dentro de cada buraco:

```text
X_k = (X_{k-1} ⊕ B) intersect A^c,  k = 1,2,3,...
```

Condição de parada:

```text
X_k = X_{k-1}
```

Resultado final:

```text
buracos preenchidos = X_k union A
```

Interpretação:

- `X_0` contém um pixel marcador dentro do buraco.
- A dilatação expande o marcador.
- A interseção com `A^c` impede a expansão de atravessar a fronteira do objeto.
- É uma dilatação condicional.

Falhas típicas:

- Se o ponto inicial estiver na fronteira, o crescimento pode não representar o buraco.
- Se o ponto inicial estiver fora do objeto, o algoritmo cresce pelo fundo externo.
- Se a fronteira não estiver fechada, o marcador pode vazar.

## 9.5.3 Extração De Componentes Conexos

Com um ponto inicial conhecido em cada componente:

```text
X_k = (X_{k-1} ⊕ B) intersect A,  k = 1,2,3,...
```

Condição de parada:

```text
X_k = X_{k-1}
```

- É semelhante ao preenchimento de buracos.
- A diferença é que agora a máscara é `A`, não `A^c`.
- O ES define a conectividade:
  - cruz: conectividade-4;
  - matriz `3 x 3` de 1s: conectividade-8.

Roteiro automatizado quando os marcadores não são conhecidos:

```text
1. Encontre um pixel de A ainda não rotulado.
2. Use esse pixel como X_0.
3. Aplique X_k = (X_{k-1} ⊕ B) intersect A até estabilidade.
4. Rotule o componente encontrado.
5. Remova/ignore esse componente de A.
6. Repita até não sobrar pixel de frente sem rótulo.
```

## 9.5.4 Fecho Convexo

- Um conjunto é convexo se o segmento de reta entre quaisquer dois pontos do conjunto fica todo dentro dele.
- O fecho convexo `C(A)` é o menor conjunto convexo que contém `A`.
- A deficiência convexa é:

```text
H - A
```

onde `H` é o fecho convexo.

Algoritmo morfológico:

```text
X_k^i = (X_{k-1}^i hit B_i) union A
i = 1,2,3,4
k = 1,2,3,...
X_0^i = A
```

Após convergência:

```text
D_i = X_k^i
C(A) = union_{i=1}^{4} D_i
```

- Os `B_i` são elementos estruturantes direcionais.
- O crescimento pode ultrapassar o fecho convexo mínimo; por isso pode ser necessário limitar por dimensões máximas do objeto.

Uso prático:

- Descrição de forma.
- Medida de deficiência convexa.
- Identificação de concavidades.
- Comparação entre objeto real e seu menor invólucro convexo.

## 9.5.5 Afinamento

Definição por hit-or-miss:

```text
A thin B = A - (A hit B)
```

Forma equivalente:

```text
A thin B = A intersect (A hit B)^c
```

Afinamento por sequência de ES:

```text
{B} = {B1, B2, ..., Bn}
A thin {B} = (((A thin B1) thin B2) ... thin Bn)
```

- Cada `B_i` é uma rotação do anterior.
- Repete-se a sequência até não haver mais alteração.
- Útil para produzir versões finas de objetos preservando estrutura geral.

## 9.5.6 Espessamento

```text
A thick B = A union (A hit B)
```

Por sequência:

```text
A thick {B} = (((A thick B1) thick B2) ... thick Bn)
```

- É o complemento morfológico do afinamento.
- Em muitas aplicações, faz-se o espessamento por afinamento do fundo e complementação.

## 9.5.7 Esqueletos

O esqueleto é uma representação fina da forma, relacionada aos centros de discos máximos contidos no objeto.

Formulação:

```text
S(A) = union_{k=0}^{K} S_k(A)
```

com:

```text
S_k(A) = (A ⊖ kB) - [(A ⊖ kB) o B]
```

e:

```text
K = max { k | (A ⊖ kB) != vazio }
```

Reconstrução:

```text
A = union_{k=0}^{K} [S_k(A) ⊕ kB]
```

Interpretação:

- Erode-se sucessivamente o objeto.
- Em cada nível, a abertura remove partes que ainda podem ser descritas pelo ES.
- A diferença deixa pontos do esqueleto daquele nível.
- O esqueleto morfológico nem sempre é conectado ou com um pixel de espessura.

Diferença importante:

- Esqueleto morfológico é uma formulação por erosões e aberturas.
- Esqueleto "bom" para reconhecimento muitas vezes precisa ser conectado, fino e estável.
- Por isso, esqueletização prática costuma precisar de poda e pós-processamento.

## 9.5.8 Poda

- Afinamento e esqueletização podem gerar ramos parasitas.
- A poda remove ramificações pequenas, normalmente por detecção de extremidades.

Roteiro típico:

```text
1. Afine A por uma sequência de ES detectores de extremidade.
2. Repita o afinamento tantas vezes quanto o tamanho máximo do ramo parasita.
3. Extraia as extremidades restantes.
4. Dilate condicionalmente essas extremidades dentro de A.
5. Una o resultado ao objeto afinado.
```

Fórmulas do procedimento do livro:

```text
X1 = A thin {B}
X2 = union_{k=1}^{8} (X1 hit B_k)
X3 = (X2 ⊕ H) intersect A
X4 = X1 union X3
```

- `H` é um ES `3 x 3` de 1s.
- A interseção com `A` impede que a dilatação saia da forma original.

## 9.5.9 Reconstrução Morfológica

Reconstrução usa:

- marcador `F`: pontos de partida.
- máscara `G`: limite da transformação.
- ES `B`: define conectividade.

## Marcador Versus Máscara

| Papel | O que faz |
|---|---|
| Marcador `F` | indica onde a reconstrução começa |
| Máscara `G` | limita onde a reconstrução pode chegar |
| ES `B` | define quais vizinhos são alcançáveis |

Regra mental:

```text
o marcador tenta crescer; a máscara decide até onde ele pode crescer
```

### Dilatação Geodésica Binária

Tamanho 1:

```text
D_G^1(F) = (F ⊕ B) intersect G
```

Tamanho `n`:

```text
D_G^n(F) = D_G^1[D_G^{n-1}(F)]
D_G^0(F) = F
```

Reconstrução por dilatação:

```text
R_G^D(F) = D_G^k(F)
```

com `k` tal que:

```text
D_G^k(F) = D_G^{k+1}(F)
```

### Erosão Geodésica Binária

Tamanho 1:

```text
E_G^1(F) = (F ⊖ B) union G
```

Tamanho `n`:

```text
E_G^n(F) = E_G^1[E_G^{n-1}(F)]
E_G^0(F) = F
```

Reconstrução por erosão:

```text
R_G^E(F) = E_G^k(F)
```

## Aplicações Da Reconstrução

### Abertura Por Reconstrução

```text
O_R^n(F) = R_F^D(F ⊖ nB)
```

- Primeiro erode para remover componentes.
- Depois reconstrói por dilatação usando a imagem original como máscara.
- Preserva exatamente a forma dos componentes que sobreviveram à erosão.

### Preenchimento Automático De Buracos

Marcador:

```text
F(x,y) = 1 - I(x,y), se (x,y) estiver na borda de I
F(x,y) = 0,          caso contrário
```

Resultado:

```text
H = [ R_{I^c}^D(F) ]^c
```

- `H` é a imagem `I` com buracos preenchidos.

### Limpeza Das Bordas

Marcador:

```text
F(x,y) = I(x,y), se (x,y) estiver na borda de I
F(x,y) = 0,      caso contrário
```

Resultado:

```text
X = I - R_I^D(F)
```

- Remove objetos que tocam a borda da imagem.

## Como Escolher Entre Algoritmos

| Se você precisa... | Use |
|---|---|
| apenas borda do objeto | extração de fronteiras |
| preencher regiões internas escuras | preenchimento de buracos |
| contar ou medir objetos separados | componentes conexos |
| medir concavidade | fecho convexo e deficiência convexa |
| reduzir objeto à estrutura central | esqueleto ou afinamento |
| limpar ramos pequenos | poda |
| preservar forma após remover objetos pequenos | reconstrução |
| remover objetos tocando a borda | limpeza por reconstrução |

## Tabela De Algoritmos

| Tarefa | Fórmula-chave | Ideia |
|---|---|---|
| Fronteira | `A - (A ⊖ B)` | retirar interior erodido |
| Buracos | `(X ⊕ B) intersect A^c` | crescer marcador dentro do fundo interno |
| Componentes | `(X ⊕ B) intersect A` | crescer marcador dentro do objeto |
| Fecho convexo | hit-or-miss iterativo | expandir até convexidade |
| Afinamento | `A - (A hit B)` | remover padrões de borda |
| Espessamento | `A union (A hit B)` | adicionar padrões |
| Esqueleto | erosões + aberturas | centros de discos máximos |
| Poda | afinamento + extremidades + reconstrução | remover ramos pequenos |
| Reconstrução | geodésica até estabilidade | crescer marcador limitado por máscara |

## Pontos De Prova

- Saber escrever fronteira, buracos e componentes conexos.
- Explicar a diferença entre máscara e marcador.
- Explicar por que a reconstrução converge.
- Diferenciar abertura comum de abertura por reconstrução.
- Saber que esqueletos morfológicos podem não ser conectados.
