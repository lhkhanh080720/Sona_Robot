#include <Arduino.h>
#include <WebSocketsServer.h> //import for websocket
#include <Wire.h>

const char *ssid =  "esp8266";   //Wifi SSID (Name)
const char *pass =  "123456789"; //wifi password

WebSocketsServer webSocket = WebSocketsServer(81); //websocket init with port 81

//float counter = 0;
unsigned long t = 0;
String json;
char pData[10];

void setup() {
  Serial.begin(9600); //serial start

  Serial.println("Connecting to wifi");

  IPAddress apIP(192, 168, 99, 100);   //Static IP for wifi gateway
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0)); //set Static IP gateway on NodeMCU
  WiFi.softAP(ssid, pass); //turn on WIFI

  webSocket.begin(); //websocket Begin
  webSocket.onEvent(webSocketEvent); //set Event for websocket
  Serial.println("Websocket is started");
  Wire.begin(D1, D2); /* join i2c bus with SDA=D1 and SCL=D2 of NodeMCU */
}

void loop() {
  webSocket.loop(); //keep this line on loop method
}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
  //webscket event method
  String cmd = "";
  switch (type) {
    case WStype_DISCONNECTED:
      Serial.println("Websocket is disconnected");
      break;
    case WStype_CONNECTED: {
        Serial.println("Websocket is connected");
        Serial.println(webSocket.remoteIP(num).toString());//Add IP Flutter connect to esp
        webSocket.sendTXT(num, "connected");//send event "connected" to Flutter
      }
      break;
    case WStype_TEXT: //receive data from Flutter
      cmd = "";
      for (int i = 0; i < length; i++) {
        cmd = cmd + (char) payload[i];
      } //merging payload to single string
      Serial.print("Data from flutter:");
      cmd.toCharArray(pData, cmd.length() + 1);
      Wire.beginTransmission(8); /* begin with device address 8 */
      for (size_t i = 0; i < cmd.length(); i++)
      {
        Wire.write(pData[i]);
      }
      Wire.endTransmission();    /* stop transmitting */
      Serial.println(pData);
      break;
    case WStype_FRAGMENT_TEXT_START:
      break;
    case WStype_FRAGMENT_BIN_START:
      break;
    case WStype_BIN:
      hexdump(payload, length);
      break;
    default:
      break;
  }
}
