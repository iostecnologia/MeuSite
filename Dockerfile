# Use nginx como servidor web
FROM nginx:alpine

# Copiar arquivo HTML para o diretório do nginx
COPY index.html /usr/share/nginx/html/

# Exposar porta 80
EXPOSE 80

# Iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
