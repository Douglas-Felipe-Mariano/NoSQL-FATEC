# 📚 Revisão Redis — Comandos Principais

---

## 🔌 Conexão

```bash
# Acessar o redis-cli dentro do container Docker
docker exec -it redis-fatec redis-cli

# Testar conexão
PING
# Resposta: PONG

# Selecionar banco (0 a 15)
SELECT 1
```

---

## 🔑 Strings (tipo mais básico)

```bash
SET nome "João"          # Salva chave-valor
GET nome                 # Retorna o valor
DEL nome                 # Remove a chave
EXISTS nome              # Verifica se existe (1 = sim, 0 = não)
APPEND nome " Silva"     # Concatena ao valor existente

SET contador 10
INCR contador            # Incrementa em 1
INCRBY contador 5        # Incrementa em N
DECR contador            # Decrementa em 1
DECRBY contador 3        # Decrementa em N

SET chave "valor" EX 60  # Expira em 60 segundos
TTL chave                # Tempo restante de vida (-1 = sem expiração, -2 = não existe)
PERSIST chave            # Remove a expiração
EXPIRE chave 120         # Define expiração em segundos
```

---

## 📋 Lists (listas — ordem de inserção)

```bash
LPUSH lista "a"          # Insere no início
RPUSH lista "b" "c"      # Insere no fim
LRANGE lista 0 -1        # Lista todos os elementos
LLEN lista               # Tamanho da lista
LPOP lista               # Remove e retorna o primeiro
RPOP lista               # Remove e retorna o último
LINDEX lista 0           # Elemento pelo índice
LSET lista 0 "novo"      # Atualiza elemento pelo índice
LINSERT lista BEFORE "b" "x"  # Insere antes de um valor
```

---

## 🗂️ Hashes (como objetos/dicionários)

```bash
HSET user:1 nome "Maria" idade 25 email "maria@email.com"
HGET user:1 nome         # Retorna campo específico
HGETALL user:1           # Retorna todos campos e valores
HMGET user:1 nome email  # Retorna múltiplos campos
HDEL user:1 email        # Remove campo
HEXISTS user:1 nome      # Verifica se campo existe
HKEYS user:1             # Lista todas as chaves do hash
HVALS user:1             # Lista todos os valores do hash
HLEN user:1              # Quantidade de campos
HINCRBY user:1 idade 1   # Incrementa campo numérico
```

---

## 📦 Sets (conjuntos — sem duplicatas, sem ordem)

```bash
SADD frutas "maçã" "banana" "uva"   # Adiciona membros
SMEMBERS frutas                      # Lista todos membros
SCARD frutas                         # Quantidade de membros
SISMEMBER frutas "maçã"             # Verifica se é membro (1/0)
SREM frutas "uva"                    # Remove membro
SPOP frutas                          # Remove e retorna membro aleatório
SRANDMEMBER frutas 2                 # Retorna N membros aleatórios (sem remover)

# Operações entre sets
SADD a "1" "2" "3"
SADD b "2" "3" "4"
SUNION a b               # União
SINTER a b               # Interseção
SDIFF a b                # Diferença (o que está em a mas não em b)
SUNIONSTORE dest a b     # Salva união em nova chave
SINTERSTORE dest a b     # Salva interseção em nova chave
```

---

## 🏆 Sorted Sets (conjuntos ordenados por score)

```bash
ZADD ranking 100 "Alice" 200 "Bob" 150 "Carol"
ZRANGE ranking 0 -1               # Lista por score crescente
ZRANGE ranking 0 -1 WITHSCORES   # Com scores
ZREVRANGE ranking 0 -1            # Ordem decrescente
ZRANK ranking "Alice"             # Posição (0-indexed, crescente)
ZREVRANK ranking "Alice"          # Posição (decrescente)
ZSCORE ranking "Alice"            # Score de um membro
ZCARD ranking                     # Quantidade de membros
ZINCRBY ranking 50 "Alice"        # Incrementa score
ZREM ranking "Bob"                # Remove membro
ZRANGEBYSCORE ranking 100 200     # Por faixa de score
ZCOUNT ranking 100 200            # Conta membros na faixa
```

---

## 🔍 Comandos Gerais de Chaves

```bash
KEYS *                   # Lista todas as chaves (cuidado em produção!)
KEYS user:*              # Chaves com padrão
SCAN 0 MATCH user:* COUNT 10   # Iteração segura (prefira ao KEYS em produção)
TYPE chave               # Tipo da chave (string, list, set, zset, hash)
RENAME chave novaChave   # Renomeia chave
RANDOMKEY                # Retorna chave aleatória
DUMP chave               # Serializa o valor
```

---

## ⚙️ Transações

```bash
MULTI                    # Inicia transação
SET x 1
SET y 2
EXEC                     # Executa todos os comandos
DISCARD                  # Cancela a transação
WATCH chave              # Monitora chave (cancela EXEC se modificada)
```

---

## 📡 Pub/Sub (Publicar e Assinar)

```bash
# Terminal 1 - Assinar canal
SUBSCRIBE noticias

# Terminal 2 - Publicar mensagem
PUBLISH noticias "Nova aula de Redis!"

UNSUBSCRIBE noticias     # Cancelar assinatura
PSUBSCRIBE noticia*      # Assinar por padrão (glob)
```

---

## 🗄️ Administração do Servidor

```bash
INFO                     # Informações do servidor
INFO memory              # Memória usada
DBSIZE                   # Quantidade de chaves no banco atual
FLUSHDB                  # Apaga todas as chaves do banco atual ⚠️
FLUSHALL                 # Apaga TODOS os bancos ⚠️
SAVE                     # Força persistência em disco (RDB)
BGSAVE                   # Persistência em background
CONFIG GET maxmemory     # Lê configuração
CONFIG SET maxmemory 100mb  # Define configuração em tempo real
MONITOR                  # Exibe comandos em tempo real (debug)
LASTSAVE                 # Timestamp do último save
```

---

## ⏱️ Expiração — Resumo Rápido

| Comando | Descrição |
|---|---|
| `EXPIRE chave 60` | Expira em 60 segundos |
| `PEXPIRE chave 5000` | Expira em 5000 milissegundos |
| `EXPIREAT chave timestamp` | Expira em Unix timestamp |
| `TTL chave` | Tempo restante (segundos) |
| `PTTL chave` | Tempo restante (milissegundos) |
| `PERSIST chave` | Remove expiração |

---

## 🧩 Tipos de Dados — Resumo

| Tipo | Comando Base | Uso Típico |
|---|---|---|
| String | `SET / GET` | Cache, contadores, tokens |
| List | `LPUSH / RPUSH` | Filas, histórico |
| Hash | `HSET / HGET` | Objetos, perfis de usuário |
| Set | `SADD / SMEMBERS` | Tags, amigos em comum |
| Sorted Set | `ZADD / ZRANGE` | Rankings, leaderboards |
