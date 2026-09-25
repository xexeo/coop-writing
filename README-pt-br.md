# pacote LaTeX coop-writing v1.8

Copyright (c) 2024–2026 Geraldo Xexéo

**coop-writing** é um pacote LaTeX para administrar o ciclo editorial de um documento de forma independente da interface de edição. Comentários, inserções/remoções/substituições propostas, TODOs, material de rascunho, anonimização e conteúdo dependente do modo permanecem no fonte LaTeX; assim, o mesmo fluxo pode ser usado no Overleaf, em um editor local ou em colaboração por Git.

O pacote se organiza em torno de modos editoriais como `edicao`, `submeter`, `publicar` e `publicaraceitando`. O fonte permanece como registro autoritativo, enquanto o documento gerado muda de acordo com a etapa do processo editorial.

## Documentação

Para começar, use:

- [Referência Rápida — Português do Brasil (PT-BR)](quickref-pt-br.tex)
- [Exemplo Máximo — Português do Brasil (PT-BR)](max-exemplo-pt-br.tex)

Documentação em inglês:

- [Quick Reference — English (EN-US)](quickref-en-us.tex)
- [Maximal Example — English (EN-US)](max-example-en-us.tex)

O manual completo está em [coop-writing.pdf](coop-writing.pdf), gerado a partir de [coop-writing.dtx](coop-writing.dtx).

Informações de versão:

- [Novidades da v1.8](new.md)
- [Histórico completo de versões](changes.md)

## Uso mínimo

```latex
\usepackage[edicao]{coop-writing}

\cwautor{alice}{blue}{Alice}

Esta frase \alice{Verifique esta afirmação.} está sendo revisada.

\aliceswap[Melhorar a precisão]
  {redação antiga}
  {redação nova}
```

Para gerar uma versão limpa de submissão ou publicação, altere o modo principal do pacote em vez de apagar comandos editoriais do fonte.

## UTF-8 e engines

Os fontes do projeto devem ser UTF-8. O LaTeX atual usa UTF-8 como codificação de entrada padrão. O projeto está sendo organizado para testar explicitamente **pdfLaTeX** e **LuaLaTeX** e para evitar interfaces deprecadas quando o LaTeX atual oferece uma alternativa mantida.

## API moderna de workflow

Para documentos novos, a interface preferencial usa configuração explícita por chave/valor:

```latex
\usepackage[mode=editing]{coop-writing}
\cwsetup{layout=margin-footnote, log=summary, view=coautores}

\cwitem[id=metodo-1,type=comment,author=alice,severity=warning]
  {Explicar a estratégia de amostragem.}

\cwchange[id=mudanca-metodo,author=alice]
  {redação antiga}{redação nova}
\cwaccept{mudanca-metodo}
\cwresolve{metodo-1}
```

A camada semântica da v1.8 também cobre respostas/threads, revisões longas, tipos e estilos editoriais definidos pelo usuário, filtros por autor, metadados de estado do documento, visões nomeadas, placeholders, resposta a revisores, errata, relatórios, exportação estruturada e materialização externa do fonte. A API histórica continua compatível.

## Organização do repositório

`coop-writing.dtx` e `coop-writing.ins` são as fontes canônicas. O arquivo de estilo, PDFs, `dist/` e o staging do CTAN são gerados a partir deles. O CI regenera o style antes de cada teste, impedindo que cópias antigas sejam usadas. A árvore histórica `CTAN/` e o antigo snapshot `tests/coop-writing.sty` foram removidos.

## Desenvolvimento e compatibilidade

A suíte regressiva usa `l3build` com pdfTeX e LuaTeX e também testa o kernel de desenvolvimento do LaTeX. Outro workflow cobre classes padrão, `memoir`, KOMA-Script, templates editoriais disponíveis e fontes canônicas UFRJ/COPPE/Poli obtidas diretamente do GitHub.

Veja [a política de compatibilidade](COMPATIBILITY.md), [a auditoria de dependências](DEPENDENCIES.md) e [a matriz issue→teste](ISSUE-TEST-MATRIX.md).

Ao relatar uma incompatibilidade, inclua um exemplo mínimo e informe:

- versão do coop-writing;
- engine e distribuição TeX;
- classe do documento e versão;
- modo do pacote;
- menor fonte capaz de reproduzir o problema.

## Issues, sugestões e discussões

Repositório: https://github.com/xexeo/coop-writing

Issues: https://github.com/xexeo/coop-writing/issues

Discussões: https://github.com/xexeo/coop-writing/discussions

## Licença

Este pacote é distribuído sob a licença MIT.
