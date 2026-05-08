# 👨‍💻 Integrantes

> RM561650 - Gustavo Sartori
> RM562267 - Gutemberg Rocha

# 🌡️ Monitoramento Inteligente com IoT

> Link do Youtube: 
> Projeto de monitoramento de máquina/ambiente utilizando ESP32, sensores, protocolo MQTT, dashboard em tempo real com Node-RED e persistência em banco de dados MySQL na nuvem.

---

## 📋 Descrição do Projeto

Este projeto implementa uma solução completa de **monitoramento IoT** que coleta dados de sensores físicos conectados a um ESP32, transmite via protocolo MQTT para um broker na nuvem (HiveMQ), processa e exibe as informações em um dashboard em tempo real com Node-RED, armazena os dados em um banco MySQL hospedado no Clever Cloud e ainda consome dados externos da API do OpenWeather para exibir as condições climáticas de São Paulo.

O sistema monitora **temperatura ambiente** e **distância** de objetos, emite alertas automáticos quando os valores ultrapassam limites definidos, e cruza esses dados com informações climáticas externas em tempo real.

---

## 📁 Estrutura do Repositório

```
📦 iot-monitoramento/
├── 📄 README.md                  # Documentação do projeto
├── 📂 esp32/
│   └── 📄 main.ino               # Código fonte do ESP32
├── 📂 node-red/
│   └── 📄 flow.json              # Fluxo completo para importar no Node-RED
├── 📂 database/
│   └── 📄 schema.sql             # Script de criação das tabelas MySQL
└── 📂 docs/
    └── 📄 dashboard.png          # Print do dashboard funcionando
```

---

## ⚙️ Instruções de Execução

### Pré-requisitos

- Conta no [Wokwi](https://wokwi.com) (simulação do ESP32)
- Conta no [HiveMQ Cloud](https://www.hivemq.com/mqtt-cloud-broker/) (broker MQTT gratuito)
- [Node-RED](https://nodered.org/) instalado localmente ou em servidor
- Conta no [Clever Cloud](https://www.clever-cloud.com/) com um add-on MySQL criado
- Chave de API gratuita no [OpenWeather](https://openweathermap.org/api)

---

### 1️⃣ Configurar o Banco de Dados (Clever Cloud)

1. Acesse o painel do Clever Cloud → seu add-on MySQL → **phpMyAdmin**
2. Selecione seu banco no menu esquerdo
3. Clique na aba **SQL**, cole o conteúdo de `database/schema.sql` e clique em **Executar**
4. Confirme que as 3 tabelas foram criadas: `leituras_temperatura`, `leituras_distancia`, `clima_saopaulo`

---

### 2️⃣ Configurar o Node-RED

**Instalar os pacotes necessários:**

Acesse `Menu ≡ → Manage Palette → Install` e instale:
```
node-red-dashboard
node-red-node-mysql
```

**Importar o fluxo:**

1. Acesse `Menu ≡ → Import → Clipboard`
2. Cole o conteúdo de `node-red/flow.json`
3. Clique em **Import**

**Configurar a conexão MySQL:**

1. Dê duplo clique em qualquer nó MySQL roxo no fluxo
2. Clique no ícone de lápis ✏️ ao lado do campo Database
3. Preencha com as credenciais do Clever Cloud:

```
Host:     SEU_HOST.mysql.services.clever-cloud.com
Port:     3306
Database: SEU_NOME_DB
Username: SEU_USUARIO
Password: SUA_SENHA
Timezone: America/Sao_Paulo
```

4. Clique em **Update → Done → Deploy**
5. Verifique se aparece `connected` em verde nos nós MySQL

---

### 3️⃣ Configurar o ESP32 no Wokwi

1. Acesse [wokwi.com](https://wokwi.com) e crie um novo projeto ESP32
2. Cole o conteúdo de `esp32/main.ino` no editor
3. Monte o circuito no simulador:

| Componente | Pino ESP32 |
|---|---|
| Sensor NTC (Termistor) | GPIO 14 (analógico) |
| HC-SR04 TRIG | GPIO 13 |
| HC-SR04 ECHO | GPIO 12 |

4. Clique em **▶ Play** para iniciar a simulação
5. Abra o **Serial Monitor** — você deve ver as leituras a cada 3 segundos:
```
Dist: 23.50 cm | Temp: 28.30 C
```

---

### 4️⃣ Acessar o Dashboard

Com o Node-RED rodando e o Wokwi simulando, acesse:

```
http://localhost:1880/ui
```

O dashboard exibirá:
- **Sensores ESP32** — Gauge de temperatura e distância em tempo real
- **Histórico de Leituras** — Gráficos de linha com o histórico
- **Clima Externo SP** — Temperatura, umidade, condição e vento de São Paulo (atualiza a cada 60s)

---

## 🗄️ Estrutura do Banco de Dados

### `leituras_temperatura`
| Campo | Tipo | Descrição |
|---|---|---|
| id | INT AUTO_INCREMENT | Chave primária |
| temperatura | FLOAT | Temperatura em °C (sensor NTC) |
| criado_em | DATETIME | Data e hora da leitura |

### `leituras_distancia`
| Campo | Tipo | Descrição |
|---|---|---|
| id | INT AUTO_INCREMENT | Chave primária |
| distancia | FLOAT | Distância em cm (sensor HC-SR04) |
| criado_em | DATETIME | Data e hora da leitura |

### `clima_saopaulo`
| Campo | Tipo | Descrição |
|---|---|---|
| id | INT AUTO_INCREMENT | Chave primária |
| temperatura | FLOAT | Temperatura externa em °C |
| sensacao | FLOAT | Sensação térmica em °C |
| umidade | INT | Umidade relativa em % |
| descricao | VARCHAR(100) | Descrição do clima (ex: clear sky) |
| vento | FLOAT | Velocidade do vento em m/s |
| criado_em | DATETIME | Data e hora da consulta |

---

## 🚨 Alertas Automáticos

O sistema emite notificações toast no dashboard nas seguintes situações:

| Condição | Gatilho |
|---|---|
| ⚠️ Temperatura elevada | Temperatura do sensor > **40°C** |
| ⚠️ Objeto muito próximo | Distância do sensor < **10 cm** |

---

## 📡 Tópicos MQTT

| Tópico | Dado publicado | Frequência |
|---|---|---|
| `maquina1/temperatura` | Temperatura em °C (float) | A cada 3 segundos |
| `maquina1/distancia` | Distância em cm (float) | A cada 3 segundos |

---

## 🔧 Configurações do Broker HiveMQ

```
Host:     SEU_CLUSTER.s1.eu.hivemq.cloud
Porta:    8883 (TLS/SSL obrigatório)
Usuário:  SEU_USUARIO
Senha:    SUA_SENHA
```

---

## 📌 Observações

- O projeto foi desenvolvido e testado usando o simulador **Wokwi**.
- A chave da API OpenWeather é gratuita e permite até **60 chamadas/minuto** no plano free, mais que suficiente para o intervalo de 60 segundos configurado.
- O Clever Cloud pode bloquear conexões externas por IP. Em caso de erro `ETIMEDOUT`, libere o IP da máquina onde o Node-RED está rodando nas configurações do add-on.

---

