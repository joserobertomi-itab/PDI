# Seção 5.7 - Filtragem Inversa

Páginas usadas: livro 230-232, PDF 248-250.

## Ideia Central

- A filtragem inversa tenta desfazer diretamente a degradação dividindo por `H(u,v)`.
- É conceitualmente simples, mas muito sensível a ruído e a valores pequenos ou nulos de `H`.

## Fórmulas / Relações Importantes

Estimativa direta:

```text
F_hat(u,v) = G(u,v) / H(u,v)
```

Substituindo o modelo degradado:

```text
G(u,v) = H(u,v)F(u,v) + N(u,v)
```

temos:

```text
F_hat(u,v) = F(u,v) + N(u,v)/H(u,v)
```

## Interpretação

- Mesmo conhecendo exatamente `H`, a presença de ruído impede recuperação perfeita.
- Se `H(u,v)` for pequeno, `N(u,v)/H(u,v)` pode explodir.
- Se `H(u,v) = 0`, a informação naquela frequência foi perdida e a inversão direta é impossível.

## Filtragem Inversa Limitada

- Uma solução prática é aplicar a inversão apenas perto da origem do espectro.
- Normalmente `H(0,0)` é grande, e os problemas de divisão por valores pequenos aumentam em frequências mais altas.
- Pode-se limitar radialmente a razão `G/H` com um passa-baixa.

## Trade-Off

- Raio pequeno: menos ruído amplificado, mas resultado mais borrado.
- Raio grande: mais detalhe recuperado, mas ruído amplificado.
- Raio excessivo: a imagem pode ser dominada por ruído.

## Roteiro De Uso

```text
1. Estime ou conheça H(u,v).
2. Calcule G(u,v).
3. Evite dividir onde |H(u,v)| é zero ou muito pequeno.
4. Aplique G/H apenas em uma região segura do espectro.
5. Use IDFT para voltar ao espaço.
6. Reescale intensidades.
```

## O Que A Prova Costuma Explorar

Se a questão perguntar por que a filtragem inversa falha, responda pela equação:

```text
F_hat = F + N/H
```

- O problema não é apenas desconhecer `H`.
- Mesmo com `H` exata, o termo `N/H` amplifica ruído.
- Quanto menor `H`, maior a amplificação.
- Zeros em `H` significam perda completa daquelas componentes de frequência.

## Relação Com Os Próximos Filtros

- Wiener adiciona um termo de controle no denominador.
- Mínimos quadráticos com restrição adiciona um termo de suavidade `gamma |P|^2`.
- O filtro de média geométrica combina a inversão com uma forma Wiener.

## Pontos De Prova

- Explicar por que `F_hat = G/H` não resolve o problema com ruído.
- Identificar o termo que amplifica ruído: `N/H`.
- Explicar o efeito de zeros de `H`.
- Justificar o uso de inversão limitada por raio.
