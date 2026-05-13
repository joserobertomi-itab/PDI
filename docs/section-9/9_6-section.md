# Seção 9.6 - Morfologia Em Imagens Em Níveis De Cinza

Páginas usadas: livro 437-453, PDF 455-471.

## Ideia Central

- As operações morfológicas binárias se estendem para níveis de cinza tratando a imagem como uma superfície.
- Com elementos estruturantes planos, erosão vira mínimo local e dilatação vira máximo local.
- Abertura remove detalhes claros pequenos; fechamento remove detalhes escuros pequenos.

## Representação

- `f(x,y)`: imagem em níveis de cinza.
- `b(x,y)`: elemento estruturante.
- Coordenadas `(x,y)` pertencem a `Z^2`.
- Intensidades podem ser reais ou inteiras.
- Elementos estruturantes podem ser:
  - planos: todos os valores têm mesma altura;
  - não planos: possuem valores de intensidade próprios.

## Tradução Binário Para Cinza

| Ideia binária | Versão em níveis de cinza |
|---|---|
| Objeto cabe no ES | mínimo local preserva intensidades baixas |
| ES toca objeto | máximo local propaga intensidades altas |
| Erosão contrai objeto claro | erosão reduz picos claros |
| Dilatação expande objeto claro | dilatação expande picos claros |
| Abertura remove objetos claros pequenos | abertura corta picos claros estreitos |
| Fechamento preenche buracos escuros | fechamento preenche vales escuros estreitos |

## 9.6.1 Erosão E Dilatação

### Erosão Com ES Plano

```text
[f ⊖ b](x,y) = min { f(x+s, y+t) | (s,t) in b }
```

- Calcula o mínimo na vizinhança definida pelo ES.
- Escurece a imagem.
- Reduz objetos claros.
- Aumenta regiões escuras.

### Dilatação Com ES Plano

```text
[f ⊕ b](x,y) = max { f(x-s, y-t) | (s,t) in b }
```

- Calcula o máximo na vizinhança definida pelo ES.
- Clareia a imagem.
- Aumenta objetos claros.
- Reduz regiões escuras.

### ES Não Plano

Erosão:

```text
[f ⊖ b_N](x,y) = min { f(x+s,y+t) - b_N(s,t) }
```

Dilatação:

```text
[f ⊕ b_N](x,y) = max { f(x-s,y-t) + b_N(s,t) }
```

- A erosão subtrai o ES não plano antes do mínimo.
- A dilatação soma o ES não plano antes do máximo.
- Na prática, ES planos são mais comuns.

## Dualidade Em Cinza

Com complemento definido como:

```text
f^c(x,y) = -f(x,y)
```

temos:

```text
(f ⊖ b)^c = f^c ⊕ b_hat
(f ⊕ b)^c = f^c ⊖ b_hat
```

## 9.6.2 Abertura E Fechamento

Abertura:

```text
f o b = (f ⊖ b) ⊕ b
```

Fechamento:

```text
f . b = (f ⊕ b) ⊖ b
```

Dualidade:

```text
(f . b)^c = f^c o b_hat
(f o b)^c = f^c . b_hat
```

## Interpretação Geométrica

- Veja a imagem como uma superfície 3-D.
- Abertura: empurra o ES por baixo da superfície.
- Fechamento: empurra o ES por cima da superfície.
- Abertura corta picos claros estreitos.
- Fechamento preenche vales escuros estreitos.

Propriedades da abertura:

```text
f o b <= f
se f1 <= f2, então f1 o b <= f2 o b
(f o b) o b = f o b
```

Propriedades do fechamento:

```text
f <= f . b
se f1 <= f2, então f1 . b <= f2 . b
(f . b) . b = f . b
```

## 9.6.3 Algoritmos Morfológicos Em Cinza

### Suavização Morfológica

```text
suavizacao = fechamento(abertura(f))
```

- Abertura remove detalhes claros pequenos.
- Fechamento remove detalhes escuros pequenos.
- Usar ES maior remove estruturas maiores, mas pode borrar mais.
- Filtragem sequencial alternada repete abertura/fechamento com resultados intermediários.

Decisão prática:

- Comece com abertura se o ruído principal for claro.
- Comece com fechamento se o ruído principal for escuro.
- Use sequência abertura-fechamento para remover ambos.
- Aumente o ES apenas até remover o ruído; depois disso você começa a remover estrutura útil.

### Gradiente Morfológico

```text
g = (f ⊕ b) - (f ⊖ b)
```

- Dilatação engrossa regiões claras.
- Erosão afina regiões claras.
- A diferença destaca fronteiras.
- Áreas homogêneas tendem a ser canceladas.

### Top-Hat

```text
T_hat(f) = f - (f o b)
```

- Destaca objetos claros menores que o ES.
- Útil para corrigir iluminação não uniforme.
- A abertura estima o fundo; subtrair esse fundo realça os objetos claros.

### Bottom-Hat

```text
B_hat(f) = (f . b) - f
```

- Destaca objetos escuros menores que o ES.
- É o análogo do top-hat para estruturas escuras.

## Top-Hat Como Correção De Fundo

Para objetos claros sobre fundo lentamente variável:

```text
fundo_estimado = f o b
imagem_corrigida = f - fundo_estimado
```

O ES deve ser:

- maior que os objetos que devem ser removidos na abertura;
- grande o suficiente para seguir o fundo;
- pequeno o bastante para não apagar variações relevantes de iluminação.

### Granulometria

Objetivo:

- Estimar distribuição de tamanhos de partículas sem medir cada partícula individualmente.

Roteiro:

```text
1. Suavize a imagem se houver textura/ruído interno.
2. Aplique aberturas com ES de tamanhos crescentes.
3. Para cada abertura, some os valores dos pixels.
4. Calcule diferenças entre somas sucessivas.
5. Picos no gráfico indicam tamanhos dominantes.
```

- A área de superfície diminui conforme o ES cresce.
- Quedas grandes indicam remoção de partículas daquele tamanho.

### Segmentação De Texturas

Roteiro do exemplo:

```text
1. Use fechamento para remover bolhas pequenas escuras.
2. Use abertura para remover espaços claros entre bolhas grandes.
3. Aplique gradiente morfológico para obter a fronteira entre regiões.
4. Sobreponha a fronteira à imagem original.
```

## 9.6.4 Reconstrução Morfológica Em Níveis De Cinza

Use:

- marcador `f`;
- máscara `g`;
- condição `f <= g`.

## Por Que Usar Reconstrução Em Cinza

- A abertura comum pode alterar a forma e a intensidade de objetos sobreviventes.
- A abertura por reconstrução remove o que foi eliminado pela erosão inicial, mas reconstrói com base na máscara original.
- Isso preserva melhor contornos e níveis dos objetos que ficaram marcados.
- Em fundos complexos, top-hat por reconstrução costuma produzir resultado mais limpo que top-hat comum.

### Dilatação Geodésica

Tamanho 1:

```text
D_g^1(f) = (f ⊕ b) ∧ g
```

- `∧` é mínimo pontual.

Tamanho `n`:

```text
D_g^n(f) = D_g^1[D_g^{n-1}(f)]
D_g^0(f) = f
```

Reconstrução por dilatação:

```text
R_g^D(f) = D_g^k(f)
```

com estabilidade:

```text
D_g^k(f) = D_g^{k+1}(f)
```

### Erosão Geodésica

Tamanho 1:

```text
E_g^1(f) = (f ⊖ b) ∨ g
```

- `∨` é máximo pontual.

Tamanho `n`:

```text
E_g^n(f) = E_g^1[E_g^{n-1}(f)]
E_g^0(f) = f
```

Reconstrução por erosão:

```text
R_g^E(f) = E_g^k(f)
```

## Abertura E Fechamento Por Reconstrução

Abertura por reconstrução:

```text
O_R^n(f) = R_f^D(f ⊖ nb)
```

Fechamento por reconstrução:

```text
C_R^n(f) = R_f^E(f ⊕ nb)
```

- Abertura por reconstrução preserva a forma dos componentes que sobrevivem à erosão.
- Fechamento por reconstrução preserva a forma dos componentes que sobrevivem à dilatação.

## Top-Hat Por Reconstrução

```text
top_hat_reconstrucao = f - O_R^n(f)
```

- Remove fundo complexo preservando melhor a forma dos objetos que o top-hat comum.
- Útil para texto sobre fundo irregular, reflexos e iluminação não uniforme.

## Tabela Comparativa Em Níveis De Cinza

| Operação | Fórmula | Efeito |
|---|---|---|
| Erosão plana | mínimo local | escurece, reduz regiões claras |
| Dilatação plana | máximo local | clareia, expande regiões claras |
| Abertura | erosão depois dilatação | remove detalhes claros pequenos |
| Fechamento | dilatação depois erosão | remove detalhes escuros pequenos |
| Gradiente | dilatação - erosão | destaca bordas |
| Top-hat | `f - abertura` | destaca objetos claros |
| Bottom-hat | `fechamento - f` | destaca objetos escuros |
| Abertura por reconstrução | erosão + reconstrução | remove objetos pequenos preservando forma dos sobreviventes |

## Guia De Escolha Em Cinza

| Problema | Operação |
|---|---|
| Pontos claros pequenos | Abertura |
| Pontos escuros pequenos | Fechamento |
| Bordas fortes | Gradiente morfológico |
| Fundo não uniforme com objetos claros | Top-hat ou top-hat por reconstrução |
| Fundo não uniforme com objetos escuros | Bottom-hat |
| Distribuição de tamanhos | Granulometria |
| Separar regiões por textura/tamanho | Fechamento/abertura + gradiente |
| Preservar forma após filtragem | Reconstrução morfológica |

## Pontos De Prova

- Saber que erosão em cinza é mínimo e dilatação é máximo para ES plano.
- Explicar abertura e fechamento pela analogia da superfície.
- Diferenciar top-hat e bottom-hat.
- Explicar granulometria por aberturas de tamanho crescente.
- Escrever dilatação/erosão geodésica em níveis de cinza.
- Diferenciar reconstrução comum em binário da reconstrução em níveis de cinza.
