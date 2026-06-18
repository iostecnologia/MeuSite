# SEFAN WordPress Site

Este é um site WordPress restaurado com banco de dados MySQL, pronto para ser publicado no **Dokploy**.

## 📁 Estrutura do Projeto

```
├── html/                    # Arquivos do WordPress
├── db/                      # Backup do banco de dados MySQL
├── docker-compose.yml       # Orquestração de containers (WordPress + MySQL)
├── Dockerfile              # Imagem Docker otimizada
├── nginx.conf              # Configuração do Nginx
├── default.conf            # Virtual host do Nginx para WordPress
├── .env.example            # Exemplo de variáveis de ambiente
├── .gitignore              # Arquivos ignorados pelo Git
└── DOKPLOY_DEPLOYMENT.md   # Guia completo de deployment
```

## 🚀 Quick Start

### Localmente

```bash
# 1. Configure as variáveis de ambiente
cp .env.example .env

# 2. Inicie os containers
docker-compose up -d

# 3. Acesse
# Frontend: http://localhost
# Admin: http://localhost/wp-admin
```

### Dokploy

Veja as instruções detalhadas em [DOKPLOY_DEPLOYMENT.md](DOKPLOY_DEPLOYMENT.md)

## 🛠 Tecnologias

- **WordPress** - CMS
- **MySQL 8.0** - Banco de dados
- **Nginx** - Servidor web
- **PHP 8.1** - Runtime (via WordPress image)
- **Docker** - Containerização
- **Docker Compose** - Orquestração

## 📊 Serviços

| Serviço | Porta | Container |
|---------|-------|-----------|
| WordPress | 80 | wordpress |
| MySQL | 3306 | db |
| Nginx (opcional) | 80 | nginx |

## 🔐 Segurança

- ✅ Use senhas fortes em produção
- ✅ Ative SSL/HTTPS via Dokploy
- ✅ Não commite `.env` real no Git
- ✅ Faça backups regulares
- ✅ Mantenha WordPress atualizado
- ✅ Use plugins de segurança (Wordfence, Sucuri)

## 📝 Variáveis de Ambiente

Copie `.env.example` para `.env` e altere:

```env
MYSQL_ROOT_PASSWORD=       # Senha root do MySQL
MYSQL_DATABASE=            # Nome do banco (padrão: sefandb001)
MYSQL_USER=               # Usuário MySQL (padrão: sefanuser001)
MYSQL_PASSWORD=           # Senha do usuário MySQL
```

## 🐛 Troubleshooting

**Erro: "Erro ao conectar ao banco de dados"**
- Aguarde ~30 segundos para o MySQL inicializar
- Verifique se as credenciais estão corretas no `.env`

**Erro: "Permissão negada ao fazer upload"**
```bash
docker exec wordpress_app chown -R www-data:www-data /var/www/html
```

**Erro: "Página não encontrada (404)"**
- Verifique a URL do WordPress em `wp_options`
- Regenere as URLs amigáveis em WP Admin

Mais dicas em [DOKPLOY_DEPLOYMENT.md](DOKPLOY_DEPLOYMENT.md)

## 📚 Documentação

- [Dokploy](https://docs.dokploy.com)
- [WordPress](https://wordpress.org/support/)
- [Docker](https://docs.docker.com/)
- [MySQL](https://dev.mysql.com/doc/)

## 📞 Suporte

Para dúvidas sobre o deployment, consulte:
1. [DOKPLOY_DEPLOYMENT.md](DOKPLOY_DEPLOYMENT.md) - Guia passo a passo
2. Logs do Docker: `docker logs wordpress_app`
3. Documentação oficial do Dokploy

---

Pronto para fazer deploy? Siga o guia em [DOKPLOY_DEPLOYMENT.md](DOKPLOY_DEPLOYMENT.md)! 🚀
