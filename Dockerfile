FROM redis:7.2-alpine

# Expõe a porta padrão do Redis
EXPOSE 6379

# Comando padrão
CMD ["redis-server"]
