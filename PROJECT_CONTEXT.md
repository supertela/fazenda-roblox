# Contexto do projeto para continuidade

## Identificação e origem

- Diretório local: `fazenda-roblox`.
- Nome de repositório pedido: `fazenda-roblox`.
- Place conectado e aberto no Roblox Studio: `Place1`.
- Cópia local: `Place1.rbxl`, salva do DataModel em modo Edit em 11/10/2026.
- O arquivo original é um place binário. Não foi encontrada uma pasta-fonte Roblox local antes da cópia.
- O conteúdo foi inspecionado por hierarquia no Studio e por leitura parcial dos scripts citados abaixo. Não houve auditoria completa do código, de assets ou de funcionamento em jogo.

## Estrutura observada no DataModel

- `Workspace` contém `MapaGrowAGarden`, com pastas como `Ilha`, `Caminhos`, `Canteiros`, `Lagos`, `Arvores`, `Construcoes`, `Detalhes`, `Barreira`, `Montanhas`, `Texturas` e `CatalogoAssetsPlace1`.
- `Workspace` também contém `Farm`, pastas de cultivo e efeitos/decoração como `Cherry`, `CornPlant`, `Flowers`, `Decor`, `WeatherVisuals`, `Water_Effect`, `Tutorial_Points` e `Tutorial_Arrows`.
- `ServerScriptService` tem scripts de servidor como `GardenMechanics`, `FishingServer`, `EventHandler`, `WeatherHandler`, `SeedStockHandler`, `GearStockHandler`, `Monetization`, `RewardsHandler` e outros.
- `ServerScriptService.Modules` inclui módulos chamados `CurrencyService`, `DataService`, `SeedService`, `FarmService`, `PlantService`, `InventoryService`, `QuestsService`, `WeatherService`, `ProfileService`, `GearService` e módulos de pets.
- `ReplicatedStorage` inclui pastas `Data`, `GameEvents`, `Code`, `Fruit_Spawn` e modelos/itens compartilhados.
- `StarterPlayer` contém scripts de cliente e personagem; há scripts de interface sob `StarterGui`.

Os nomes acima confirmam a presença dos objetos e scripts, mas não garantem que cada sistema funcione corretamente.

## Código lido parcialmente

- `ServerScriptService.GardenMechanics` consulta `DataStoreService` com o nome `Place1Garden_v1`, prepara `Workspace.MapaGrowAGarden.Canteiros` e a barraca em `Construcoes.Barraca`, cria/usa `ReplicatedStorage.GardenEvent` e define dados de cultivo para Cenoura, Morango e Tomate. O script também mantém dados de moeda, sementes e colheita em tabelas de runtime.
- No trecho lido de `GardenMechanics`, `onPlayerAdded` tenta carregar dados com `GetAsync` e `savePlayer` tenta gravar moedas, sementes, frutos, seleção e plantas com `SetAsync`, usando `pcall`. O fluxo foi confirmado no código, mas não testado em runtime; erros de gravação não são tratados no trecho observado.
- `ServerScriptService.Modules.FarmService` procura um canteiro com `Owner.Value == "None"` e atribui o nome do jogador.
- `ServerScriptService.Modules.DataService:GetPlayerDataAsync()` retorna uma tabela vazia no trecho lido. O papel esperado desse módulo e a relação com outros sistemas de salvamento precisam ser verificados.

## Sincronização e desenvolvimento

- Não foram encontrados `default.project.json`, `rojo.json`, arquivos Luau separados ou outro mapeamento de sincronização na cópia local.
- O projeto está preservado como `Place1.rbxl`; alterações feitas no Studio precisam ser salvas nesse arquivo antes de serem adicionadas ao Git.
- Rojo ainda não foi configurado. Antes de migrar, mapear o DataModel atual, dependências e assets; não assumir que uma exportação automática reproduzirá o place fielmente.
- A cópia local não confirma se o Studio consegue executar todos os serviços externos, como DataStores, nem se o place publicado corresponde ao arquivo salvo.

## Pendências para quem continuar

1. Abrir a cópia local e confirmar que os principais sistemas iniciam sem erros.
2. Auditar os scripts completos, começando pelos serviços de dados, plantio/colheita, inventário e inicialização.
3. Confirmar o comportamento de persistência e a relação entre `GardenMechanics`, `DataService` e `ProfileService`.
4. Decidir, com cópia de segurança, se o fluxo continuará como place binário ou se será migrado para arquivos sincronizados com Rojo.
5. Atualizar a documentação quando houver evidência de testes ou implementação nova.
