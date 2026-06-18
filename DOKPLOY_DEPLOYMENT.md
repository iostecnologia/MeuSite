# Guia de Deployment no Dokploy

Este site é um WordPress com banco de dados MySQL. Siga os passos abaixo para fazer o deploy no Dokploy.

## 📋 Pré-requisitos

- Conta no Dokploy (https://dokploy.com)
- Repositório Git com este código
- Domínio configurado (opcional, você pode usar um subdomínio do Dokploy)

## 🚀 Passo a Passo

### 1. **Prepare os arquivos localmente**

```bash
# Copie o arquivo .env
cp .env.example .env

# Edite o .env com suas credenciais (IMPORTANTE: altere as senhas!)
# Mude MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD e outras credenciais
```

### 2. **Teste localmente com Docker Compose**

```bash
# Verifique se o Docker está instalado
docker --version
docker-compose --version

# Inicie os containers
docker-compose up -d

# Aguarde ~30 segundos para o banco de dados inicializar
sleep 30

# Acesse http://localhost
# Ou http://localhost/wp-admin para o painel do WordPress
```

### 3. **Commit e Push para o repositório Git**

```bash
git add .
git commit -m "Adicionar configuração do Dokploy para WordPress com MySQL"
git push origin main
```

⚠️ **Importante**: Não commite o arquivo `.env` real - apenas `.env.example`!

### 4. **Crie o projeto no Dokploy**

1. Acesse seu dashboard do Dokploy
2. Clique em "New Project" → "Docker Compose"
3. Conecte seu repositório GitHub/GitLab
4. Configure os detalhes:
   - **Projeto**: MeuSite WordPress
   - **Ramo**: main
   - **Arquivo Docker Compose**: docker-compose.yml
5. Clique em "Create"

### 5. **Configure as variáveis de ambiente**

No Dokploy, vá para **Settings** → **Environment Variables** e adicione:

```
MYSQL_ROOT_PASSWORD=sua_senha_root_super_secreta
MYSQL_DATABASE=sefandb001
MYSQL_USER=sefanuser001
MYSQL_PASSWORD=sua_senha_mysql_secreta
```

### 6. **Configure o domínio (opcional)**

Se você tiver um domínio:

1. No Dokploy, vá para **Settings** → **Domains**
2. Adicione seu domínio
3. Configure os registros DNS conforme as instruções do Dokploy
4. Ative SSL/HTTPS automático

Se não tiver domínio, use o URL temporário do Dokploy fornecido.

### 7. **Deploy**

1. Clique em "Deploy"
2. Monitore os logs
3. Aguarde a conclusão (levará ~5-10 minutos na primeira execução)
4. Acesse seu site em `seu-dominio.com` ou na URL do Dokploy

### 8. **Restaure o banco de dados (Importante!)**

O arquivo SQL será automaticamente restaurado na primeira execução, mas se precisar restaurar novamente:

```bash
# Via terminal do servidor Dokploy
docker exec wordpress_db mysql -u sefanuser001 -p < db/SEFAN_2023_07_09_1688940967_8abfb88_wpdb.sql
```

### 9. **Acesse o WordPress**

- **Admin**: https://seu-dominio.com/wp-admin
- **Usuário**: verifique suas credenciais do backup
- **Senha**: você pode resetar em wp-admin se necessário

## ⚙️ Configurações importantes após o deploy

### 1. **Altere a URL do WordPress**

Se mudou de domínio, acesse o banco de dados e execute:

```sql
UPDATE wp_options SET option_value = 'https://novo-dominio.com' WHERE option_name IN ('siteurl', 'home');
```

Ou via WordPress Admin:
1. Vá para **Settings** → **General**
2. Atualize **WordPress Address** e **Site Address**

### 2. **Configure permissões**

No terminal do Dokploy:

```bash
docker exec wordpress_app chown -R www-data:www-data /var/www/html
docker exec wordpress_app chmod -R 755 /var/www/html
```

### 3. **Instale SSL (Let's Encrypt)**

O Dokploy oferece SSL automático. Configure em **Settings** → **SSL**.

### 4. **Backups regulares**

Configure backups automáticos no Dokploy:
1. Vá para **Settings** → **Backups**
2. Ative backups automáticos diários

## 🐛 Troubleshooting

### Erro: "Connection refused" ao conectar ao banco

- Verifique se o serviço `db` está rodando: `docker ps`
- Aguarde mais tempo para o MySQL inicializar
- Verifique as variáveis de ambiente no .env

### Erro: "Cannot access wp-admin"

- Verifique a URL do WordPress nas opções do banco
- Limpe o cache do navegador
- Verifique os logs: `docker logs wordpress_app`

### Erro: "Permission denied" em uploads

```bash
docker exec wordpress_app chown -R www-data:www-data /var/www/html/wp-content
```

### Banco de dados não foi restaurado

```bash
# Verifique o status
docker exec wordpress_db mysql -u root -p -e "SHOW DATABASES;"

# Restaure manualmente
docker exec -i wordpress_db mysql -u sefanuser001 -p sefandb001 < db/SEFAN_2023_07_09_1688940967_8abfb88_wpdb.sql
```

## 📚 Referências

- [Dokploy Docs](https://docs.dokploy.com)
- [Docker Compose Docs](https://docs.docker.com/compose/)
- [WordPress Docker Docs](https://hub.docker.com/_/wordpress)
- [MySQL Docker Docs](https://hub.docker.com/_/mysql)

## 💡 Dicas de segurança

1. ✅ Altere todas as senhas padrão
2. ✅ Não commit o `.env` real no repositório
3. ✅ Use HTTPS em produção (SSL)
4. ✅ Mantenha WordPress e plugins atualizados
5. ✅ Configure firewall no Dokploy
6. ✅ Faça backups regulares
7. ✅ Desative o XML-RPC em WordPress se não usar
8. ✅ Instale um plugin de segurança (Wordfence, Sucuri)

---

Dúvidas? Verifique os logs do Dokploy ou contate o suporte.
