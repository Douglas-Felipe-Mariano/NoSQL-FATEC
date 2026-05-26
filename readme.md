# 🐳 Redis com Docker — Ambiente de Estudos FATEC

---

## ✅ Pré-requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado e em execução

---

## 🚀 Subindo o ambiente Redis

### Opção A — Com docker-compose (recomendado)

```bash
docker-compose up -d
```

### Opção B — Com docker manualmente

#### 1. Build da imagem

```bash
docker build -t redis-fatec .
```

#### 2. Subir o container

```bash
docker run -d --name redis-fatec -p 6379:6379 redis-fatec
```

> O Redis estará disponível em `localhost:6379`

### 3. Verificar se está rodando

```bash
docker ps
```

---

## 🖥️ Acessar o Redis CLI no container

```bash
docker exec -it redis-fatec redis-cli
```

Teste a conexão:

```bash
PING
# Resposta esperada: PONG
```

---

## 🔁 Gerenciar o container

```bash
# Parar o container
docker stop redis-fatec

# Iniciar novamente
docker start redis-fatec

# Remover o container
docker rm -f redis-fatec

# Ver logs
docker logs redis-fatec
```

---

## 🧹 Reconstruir do zero

```bash
docker rm -f redis-fatec
docker build -t redis-fatec .
docker run -d --name redis-fatec -p 6379:6379 redis-fatec
```

---

## 📚 Revisão de Comandos

Consulte o arquivo [revisao.md](revisao.md) para todos os comandos principais do Redis organizados por categoria.
