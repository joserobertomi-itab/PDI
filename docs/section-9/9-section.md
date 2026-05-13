# Seção 9 - Processamento Morfológico De Imagens

Páginas usadas: livro 415-453, PDF 433-471.

## Ideia Central

- Morfologia matemática processa imagens a partir da forma dos objetos.
- Em imagens binárias, objetos são conjuntos de pixels em `Z^2`.
- Em imagens em níveis de cinza, a imagem pode ser vista como uma superfície 3-D: coordenadas `(x,y)` mais intensidade.
- O elemento estruturante é a "sonda" que examina a imagem e define quais formas, tamanhos e conexões serão preservados, removidos ou destacados.

## Como Pensar Morfologia

- A imagem binária é um conjunto `A`.
- O elemento estruturante é um conjunto pequeno `B`.
- A origem de `B` é movida pela imagem.
- A resposta depende de encaixe, interseção, complemento e conectividade.
- O formato e o tamanho de `B` controlam o efeito da operação.

## Convenção De Notação

| Notação | Leitura |
|---|---|
| `A` | conjunto de pixels do objeto |
| `A^c` | complemento de `A`, normalmente o fundo |
| `B` | elemento estruturante |
| `B_hat` | reflexão de `B` |
| `(B)_z` | translação de `B` para a posição `z` |
| `⊖` | erosão |
| `⊕` | dilatação |
| `o` | abertura |
| `.` | fechamento |
| `hit` | transformada hit-or-miss |
| `F` | marcador em reconstrução morfológica |
| `G` | máscara em reconstrução morfológica |

## Mapa Das Subseções

- [9.1](9_1-section.md): definições básicas, reflexão, translação e elementos estruturantes.
- [9.2](9_2-section.md): erosão, dilatação e dualidade.
- [9.3](9_3-section.md): abertura e fechamento.
- [9.4](9_4-section.md): transformada hit-or-miss.
- [9.5](9_5-section.md): algoritmos morfológicos binários.
- [9.6](9_6-section.md): morfologia em níveis de cinza.

## Mapa De Decisão

| Objetivo | Operação principal |
|---|---|
| Afinar/remover detalhes pequenos claros em binário | Erosão |
| Engrossar/unir lacunas em binário | Dilatação |
| Remover saliências, istmos e ilhas pequenas | Abertura |
| Fechar pequenas quebras e buracos | Fechamento |
| Detectar padrões exatos de frente/fundo | Hit-or-miss |
| Extrair fronteira | `A - (A ⊖ B)` |
| Preencher buracos | Dilatação condicional ou reconstrução |
| Extrair componentes conexos | Dilatação condicional limitada por `A` |
| Obter fecho convexo | Hit-or-miss iterativo com ES direcionais |
| Esqueletizar | Erosões e aberturas sucessivas |
| Remover ramificações parasitas | Poda |
| Corrigir iluminação desigual | Top-hat |
| Destacar bordas em cinza | Gradiente morfológico |
| Separar texturas por tamanho | Fechamento/abertura com ES adequado |

## Formulário Essencial

```text
Reflexão:
B_hat = {w | w = -b, b in B}

Translação:
(B)_z = {c | c = b + z, b in B}

Erosão:
A ⊖ B = {z | (B)_z subset A}

Dilatação:
A ⊕ B = {z | (B_hat)_z intersect A != vazio}

Dualidade:
(A ⊖ B)^c = A^c ⊕ B_hat
(A ⊕ B)^c = A^c ⊖ B_hat

Abertura:
A o B = (A ⊖ B) ⊕ B

Fechamento:
A . B = (A ⊕ B) ⊖ B

Hit-or-miss:
A hit B = (A ⊖ B1) intersect (A^c ⊖ B2)

Fronteira:
beta(A) = A - (A ⊖ B)
```

## Leituras Importantes

- Erosão e dilatação são primitivas.
- Abertura e fechamento são compostas e idempotentes.
- Reconstrução morfológica usa duas imagens: marcador e máscara.
- Em níveis de cinza, erosão vira mínimo local e dilatação vira máximo local quando o ES é plano.

## Checklist Senior Para Resolver Questões

1. Identifique se a imagem é binária ou em níveis de cinza.
2. Identifique se o alvo é objeto claro, objeto escuro, fundo, borda, buraco ou textura.
3. Escolha o ES pelo tamanho e formato da estrutura que deve sobreviver ou ser removida.
4. Decida se a operação deve remover, crescer, conectar, destacar ou reconstruir.
5. Verifique se a conectividade esperada é 4 ou 8.
6. Se houver iteração, defina a máscara e a condição de parada.
7. Depois da operação, interprete o resultado como conjunto: o que foi removido, adicionado ou preservado?

## Erros Que Mais Custam Pontos

- Tratar morfologia como convolução linear. A analogia ajuda na varredura, mas as operações são de conjuntos, mínimos e máximos.
- Escolher um ES sem justificar tamanho, forma e origem.
- Confundir abertura com erosão simples. Abertura erode e depois dilata, mas não restaura tudo.
- Confundir fechamento com dilatação simples. Fechamento dilata e depois erode.
- Esquecer que reconstrução usa marcador e máscara; não é uma operação de uma única imagem.
- Em níveis de cinza, esquecer que ES plano transforma erosão em mínimo local e dilatação em máximo local.

## Pontos De Prova

- Definir reflexão, translação e elemento estruturante.
- Diferenciar erosão, dilatação, abertura e fechamento.
- Explicar dualidade por complemento e reflexão.
- Saber montar algoritmos iterativos com dilatação/erosão condicionais.
- Relacionar operações binárias com suas versões em níveis de cinza.
