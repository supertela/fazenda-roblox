# Problemas e pontos para investigar

## Confirmados por inspeção estática limitada

- `ServerScriptService.Modules.DataService:GetPlayerDataAsync()` retorna `{}` no código lido. Isso pode ser intencional ou incompleto; verificar os chamadores antes de tratar como defeito.
- `ServerScriptService.GardenMechanics` tenta ler e gravar no DataStore `Place1Garden_v1`, mas erros são envolvidos por `pcall` e o resultado da gravação não é verificado no trecho observado. Confirmar no Studio/runtime se a persistência funciona e se falhas precisam de registro ou tratamento.

## Ainda não verificados

- Nenhum playtest foi executado nesta preparação e os logs não foram auditados. Não há base para afirmar que o projeto esteja livre de erros.
- Não foi validado se todos os assets referenciados estão disponíveis ou se serviços externos e DataStores funcionam no ambiente de teste/publicado.
- Não foi verificada a relação entre `DataService`, `ProfileService` e a lógica própria de dados de `GardenMechanics`.

Registre aqui somente problemas reproduzidos, com passos para reproduzir, resultado esperado e resultado observado. Remova itens quando a correção for confirmada.
