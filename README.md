# Place1 — projeto Roblox

Repositório privado para preservar e desenvolver o jogo Roblox **Place1**. O nome do repositório GitHub é `fazenda-roblox`.

## Conteúdo

- `Place1.rbxl`: cópia completa do place para abrir no Roblox Studio.
- `script-sources/`: fotografia em arquivos Lua dos scripts encontrados no DataModel. `manifest.json` relaciona cada arquivo ao caminho e à classe original no Studio.
- `PROJECT_CONTEXT.md`: arquitetura observada, estado da exportação e informações para continuidade por outra IA.
- `ROADMAP.md`, `CHANGELOG.md` e `BUGS.md`: planejamento, histórico e pontos de investigação.
- `.gitignore`: arquivos temporários e locais que não devem ser versionados.

A exportação atual contém 1.599 scripts: 769 `Script`, 152 `LocalScript` e 678 `ModuleScript`. Instâncias com o mesmo nome e caminho recebem sufixos `__dupNN`; consulte o manifesto para identificar cada uma.

## Abrir e desenvolver

1. Abra `Place1.rbxl` no Roblox Studio.
2. Faça e teste alterações no Studio.
3. Salve o place em `Place1.rbxl`.
4. Se scripts mudaram no Studio, peça ao Codex para atualizar a fotografia em `script-sources/` antes de registrar a versão. Confira o diff entre os scripts e o place.
5. No GitHub Desktop, revise **Changes**, escreva um resumo e selecione **Commit to main**.
6. Use **Push origin** para enviar o commit ao repositório privado.

**Importante:** `script-sources/` é uma exportação de leitura, não uma pasta conectada ao Studio. Editar um arquivo Lua exportado não altera o place. Para aplicar mudanças, faça-as no Studio e atualize a exportação. Rojo não está configurado; qualquer migração para sincronização automática exige planejamento separado.

O funcionamento do jogo e os serviços externos não foram validados por playtest nesta preparação.

## Versões anteriores

A aba **History** do GitHub Desktop permite examinar commits. Para desfazer um commit sem apagar o histórico, clique nele com o botão direito e escolha **Revert this commit**. Para recuperar uma cópia antiga do place ou de scripts específicos, identifique o commit na History e peça ao Codex para restaurar os arquivos necessários.

## GitHub

O remoto privado `origin` aponta para [supertela/fazenda-roblox](https://github.com/supertela/fazenda-roblox). A branch local `main` acompanha `origin/main`.
