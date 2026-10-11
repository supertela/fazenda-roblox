# Problemas e pontos para investigar

## Confirmados por inspeção estática limitada

- `ServerScriptService.Modules.DataService:GetPlayerDataAsync()` retorna `{}` no código lido. Isso pode ser intencional ou incompleto; verificar os chamadores antes de tratar como defeito.
- `ServerScriptService.GardenMechanics` tenta ler e gravar no DataStore `Place1Garden_v1`. As chamadas usam `pcall`; o resultado das gravações não foi validado em runtime.

## Limitações conhecidas de desenvolvimento

- `script-sources/` é uma fotografia e pode ficar desatualizada em relação a `Place1.rbxl` se scripts forem alterados no Studio sem nova exportação.
- Não foi executado playtest nesta preparação, nem auditados os logs. Não há base para afirmar que o projeto esteja livre de erros.
- Não foi validado se todos os assets referenciados estão disponíveis ou se serviços externos e DataStores funcionam no ambiente publicado.

Registre defeitos reproduzidos com passos, resultado esperado e observado. Marque como corrigido apenas depois de validar a correção.
