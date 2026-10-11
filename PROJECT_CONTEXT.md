# Contexto do projeto para continuidade

## Identificação

- Jogo aberto no Roblox Studio: **Place1**.
- Repositório privado: [supertela/fazenda-roblox](https://github.com/supertela/fazenda-roblox).
- Diretório local: `fazenda-roblox`.
- Place salvo em `Place1.rbxl`, formato binário do Roblox Studio.
- A configuração atual não usa Rojo.

## Exportação de scripts

Em 2026-10-11, os scripts foram lidos do DataModel **Place1** no modo **Edit** do Studio e exportados para `script-sources/`, sem modificar o conteúdo do place. Contagem observada:

- 769 `Script`
- 152 `LocalScript`
- 678 `ModuleScript`
- Total: 1.599 instâncias `LuaSourceContainer`

Os arquivos usam os sufixos `.server.lua` para `Script`, `.client.lua` para `LocalScript` e `.lua` para `ModuleScript`. Os diretórios espelham os ancestrais no DataModel; instâncias com nomes repetidos no mesmo local recebem `__dupNN`. Consulte `script-sources/manifest.json` para o caminho Roblox original, classe e arquivo correspondente. Um dos scripts tem fonte vazia no Studio e foi exportado como arquivo vazio.

Esta exportação é uma fotografia e não sincroniza alterações entre Studio e arquivos. O `.rbxl` continua sendo a cópia completa do jogo. Atualize a exportação depois de alterações feitas no Studio. Codex pode ler os arquivos exportados; editar apenas esses arquivos não altera o place. Uma sincronização Rojo exigiria mapear e validar o DataModel e não foi configurada.

## Estrutura observada no DataModel

- `Workspace` contém `MapaGrowAGarden`, com pastas como `Ilha`, `Caminhos`, `Canteiros`, `Lagos`, `Arvores`, `Construcoes`, `Detalhes`, `Barreira`, `Montanhas`, `Texturas` e `CatalogoAssetsPlace1`.
- `Workspace` também contém `Farm`, pastas de cultivo e efeitos/decoração como `Cherry`, `CornPlant`, `Flowers`, `Decor`, `WeatherVisuals`, `Water_Effect`, `Tutorial_Points` e `Tutorial_Arrows`.
- `ServerScriptService` tem código de servidor para plantio, pesca, eventos, clima, estoque, monetização, recompensas e outros sistemas.
- `ReplicatedStorage` inclui `Data`, `GameEvents`, `Code`, `Fruit_Spawn` e modelos/itens compartilhados.
- `StarterPlayer` contém scripts de cliente e personagem; há scripts de interface sob `StarterGui`.

A presença de scripts e objetos não confirma que os sistemas funcionem corretamente.

## Código inspecionado anteriormente

- `ServerScriptService.GardenMechanics` consulta o DataStore `Place1Garden_v1`, prepara `Workspace.MapaGrowAGarden.Canteiros` e a barraca em `Construcoes.Barraca`, cria/usa `ReplicatedStorage.GardenEvent` e define dados de cultivo para Cenoura, Morango e Tomate.
- Nesse script, `onPlayerAdded` tenta carregar dados com `GetAsync`; `savePlayer` tenta gravar moedas, sementes, frutos, seleção e plantas com `SetAsync`, usando `pcall`. O fluxo não foi testado em runtime.
- `ServerScriptService.Modules.FarmService` procura um canteiro com `Owner.Value == "None"` e atribui o nome do jogador.
- `ServerScriptService.Modules.DataService:GetPlayerDataAsync()` retorna uma tabela vazia no trecho lido; o papel esperado e a relação com outros sistemas de dados precisam ser verificados.

## Git e continuidade

- Branch: `main`.
- Commit inicial da cópia do place: `f4ff036e46ed38914e09aa014769331fe09ebe9c` (`Initial Place1 project snapshot`).
- Remoto `origin`: GitHub privado `supertela/fazenda-roblox`.
- Mantenha o place e a exportação sincronizados manualmente até que uma migração Rojo seja explicitamente planejada.

## Pendências

1. Abrir e testar a cópia local no Roblox Studio.
2. Revisar logs e corrigir somente erros reproduzidos.
3. Confirmar persistência e a relação entre `GardenMechanics`, `DataService` e `ProfileService`.
4. Reexportar scripts após alterações feitas no Studio.
5. Avaliar Rojo em uma migração isolada, preservando `Place1.rbxl` como backup.
