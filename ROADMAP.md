# Roadmap

Este roadmap registra evidências encontradas no place. Presença de código ou objetos não significa que uma funcionalidade foi testada ou concluída.

## Infraestrutura do projeto

- [x] Salvar a cópia local do place como `Place1.rbxl`.
- [x] Inicializar Git na branch `main` e registrar o commit inicial.
- [x] Criar documentação de continuidade, planejamento, histórico e problemas conhecidos.
- [x] Criar o repositório GitHub privado `supertela/fazenda-roblox` e configurar `origin`.
- [x] Exportar os 1.599 scripts visíveis no DataModel para `script-sources/` e gerar o manifesto.
- [ ] Definir um processo repetível para atualizar a exportação depois de mudanças no Studio.
- [ ] Avaliar uma migração Rojo separada; não alterar o place automaticamente.

## Presente no projeto; funcionamento ainda não validado

- [ ] Mapa de fazenda e canteiros em `Workspace`.
- [ ] Código para ciclo de cultivo e economia em `GardenMechanics`.
- [ ] Scripts e módulos para sementes, plantas, inventário, pets, clima, eventos, quests e pesca.
- [ ] Interface e scripts de cliente em `StarterGui` e `StarterPlayer`.

## Validação pendente

- [ ] Abrir a cópia local no Roblox Studio e executar um playtest.
- [ ] Revisar logs e reproduzir problemas antes de registrar defeitos.
- [ ] Auditar o fluxo de salvamento de dados e o propósito de `DataService` e `ProfileService`.
- [ ] Atualizar o changelog e a documentação a cada alteração confirmada.
