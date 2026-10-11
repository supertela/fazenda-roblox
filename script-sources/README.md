# Exportacao de scripts do Place1

Esta pasta contem uma fotografia dos `Script`, `LocalScript` e `ModuleScript` lidos do Place1 no Roblox Studio em modo Edit, em 2026-10-11. O manifesto relaciona cada arquivo com o caminho e a classe da instancia no DataModel.

O arquivo `Place1.rbxl` continua sendo a copia completa do jogo e a referencia para abrir no Roblox Studio. Esta exportacao nao esta conectada ao Studio e nao usa Rojo: editar um arquivo aqui nao altera o place. Ao mudar scripts no Studio, gere uma nova exportacao antes de criar o proximo commit.

Os sufixos `.server.lua`, `.client.lua` e `.lua` identificam, respectivamente, `Script`, `LocalScript` e `ModuleScript`. Nomes duplicados sob o mesmo caminho recebem `__dupNN`; consulte `manifest.json` para mapear esses casos.
