# Fazenda — Place1

Repositório local para preservar e desenvolver o projeto Roblox aberto no Studio como **Place1**. O nome do repositório solicitado é `fazenda-roblox`; o título observado no Roblox Studio continua sendo `Place1`.

## Estado atual

- `Place1.rbxl` é uma cópia local salva do place aberto no Roblox Studio em 11/10/2026.
- O arquivo é um place binário do Roblox Studio. Os scripts e modelos estão dentro dele; ainda não foram exportados para arquivos Luau individuais.
- Não foi encontrada configuração ou sincronização Rojo na pasta do projeto.
- O repositório Git local foi inicializado na branch `main`. O primeiro commit aguarda a configuração do autor.
- Não há repositório remoto configurado. Nada foi enviado ao GitHub.

## Abrir e executar

1. Abra `Place1.rbxl` no Roblox Studio.
2. Use **Play** no Studio para iniciar uma sessão de teste.
3. Salve alterações no Studio e revise `git status` antes de registrar uma versão.

O comportamento do jogo e os serviços externos não foram validados nesta preparação. Consulte [BUGS.md](BUGS.md) e [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md) antes de assumir que uma funcionalidade está pronta.

## Estrutura do repositório

```text
fazenda-roblox/
├── Place1.rbxl
├── README.md
├── PROJECT_CONTEXT.md
├── ROADMAP.md
├── CHANGELOG.md
├── BUGS.md
└── .gitignore
```

## Primeiro commit

Configure o nome e o e-mail que devem aparecer no histórico. Use o endereço de e-mail configurado na sua conta GitHub ou o endereço privado `noreply` fornecido pelo próprio GitHub; nunca coloque tokens ou senhas no repositório.

```powershell
git config user.name "Seu nome"
git config user.email "seu-email-ou-noreply"
git add .
git status
git commit -m "Initial Place1 project snapshot"
```

## Versionar alterações

Depois de salvar no Roblox Studio:

```powershell
git status
git add Place1.rbxl
git add README.md PROJECT_CONTEXT.md ROADMAP.md CHANGELOG.md BUGS.md .gitignore
git diff --cached --stat
git commit -m "Descreva a alteração"
```

Para consultar versões anteriores, use `git log --oneline`. Para restaurar somente o arquivo do jogo a partir de um commit específico, primeiro preserve qualquer trabalho atual e então use `git restore --source=<commit> -- Place1.rbxl`.

## GitHub

O remoto não foi criado nem configurado. Para publicar, primeiro autorize a criação do repositório privado `fazenda-roblox` e conclua a autenticação pelo fluxo seguro do GitHub CLI (`gh auth login`) ou pelo Git Credential Manager. Depois de criar o remoto privado, configure `origin` e faça o primeiro `git push -u origin main`. Não digite tokens em comandos, arquivos do projeto ou mensagens.

## Rojo

Rojo não foi detectado nesta cópia. A migração exige mapear serviços, scripts, modelos e assets do place para uma estrutura de arquivos; isso pode alterar como o Studio carrega e sincroniza o projeto. A cópia binária preserva o estado atual enquanto essa decisão fica pendente.
