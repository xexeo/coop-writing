# pacote LaTeX coop-writing v1.5.4

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

## Organização do repositório

A raiz contém o fonte de desenvolvimento atual. Historicamente, `dist/`, `CTAN/` e `tests/` também mantiveram arquivos gerados ou cópias do pacote. O projeto está migrando para uma única fonte canônica e artefatos reproduzíveis; as propostas correspondentes estão registradas nos issues.

## Desenvolvimento e compatibilidade

Compatibilidade com classes LaTeX é um requisito central. A matriz de testes proposta cobre as classes padrão do LaTeX, `memoir`, KOMA-Script, templates editoriais importantes e as classes UFRJ/COPPE/Poli mantidas no GitHub.

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
