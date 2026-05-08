#include <WiFi.h>
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <math.h>

// ===== WIFI =====
const char* ssid = "Wokwi-GUEST";
const char* password = "";

// ===== MQTT (HiveMQ Cloud) =====
const char* mqtt_server = "3f3a91da234e4351bfbad9f9e86a145c.s1.eu.hivemq.cloud";
const int   mqtt_port   = 8883;
const char* mqtt_user   = "gustavostr";
const char* mqtt_pass   = "260207Gu";

// ===== PINOS =====
#define TRIG_PIN 13
#define ECHO_PIN 12
#define TEMP_PIN 14

const float BETA = 3950;


WiFiClientSecure espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;

// ===== WIFI =====
void setup_wifi() {
  delay(10);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
}

// ===== MQTT =====
void reconnect() {
  while (!client.connected()) {
    if (client.connect("ESP32_GUSTAVO", mqtt_user, mqtt_pass)) {
      Serial.println("MQTT conectado!");
    } else {
      Serial.print("Erro MQTT: ");
      Serial.println(client.state());
      delay(2000);
    }
  }
}

// ===== DISTANCIA =====
float getDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  long duration = pulseIn(ECHO_PIN, HIGH, 30000);
  if (duration == 0) return -1;
  return duration * 0.034 / 2;
}

// ===== TEMPERATURA (NTC) =====
float getTemperature() {
  int analogValue = analogRead(TEMP_PIN);
  if (analogValue == 0) return -100;
  float resistance = (4095.0 / analogValue) - 1.0;
  float celsius = 1 / (log(resistance) / BETA + 1.0 / 298.15) - 273.15;
  return celsius;
}

// ===== SETUP =====
void setup() {
  Serial.begin(115200);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  setup_wifi();

  // LINHA ADICIONADA: desativa verificacao de certificado (necessario no Wokwi)
  espClient.setInsecure();

  client.setServer(mqtt_server, mqtt_port);
}

// ===== LOOP =====
void loop() {
  if (!client.connected()) reconnect();
  client.loop();

  if (millis() - lastMsg > 3000) {
    lastMsg = millis();
    float dist = getDistance();
    float temp = getTemperature();

    Serial.print("Dist: "); Serial.print(dist);
    Serial.print(" cm | Temp: "); Serial.print(temp);
    Serial.println(" C");

    char d[10], t[10];
    dtostrf(dist, 1, 2, d);
    dtostrf(temp, 1, 2, t);

    client.publish("maquina1/distancia", d);
    client.publish("maquina1/temperatura", t);
  }
}