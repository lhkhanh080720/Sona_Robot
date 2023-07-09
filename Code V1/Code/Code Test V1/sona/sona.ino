#include <Wire.h>

const int R_PWM1 = 2;
const int L_PWM1 = 3;
const int R_EN1 = 30;
const int L_EN1 = 30;
const int R_PWM2 = 4;
const int L_PWM2 = 5;
const int R_EN2 = 32;
const int L_EN2 = 32;
unsigned long value = 0;
char dataC[8];
int j = 0;
bool flag = false;
String dataS = "";
String command = "";
char buff[6] = "";
int i = 0;
unsigned char p1, p2; 
unsigned char d1, d2; 
unsigned char e1, e2;

#define DISABLE LOW
#define ENABLE HIGH

void setup() 
{ 
	Serial.begin(9600);
	Serial.println(" Start Sona");
  Wire.begin(8);                /* join i2c bus with address 8 */
  Wire.onReceive(receiveEvent); /* register receive event */
  pinMode(L_PWM1, OUTPUT);
  pinMode(R_EN1, OUTPUT);
  pinMode(L_EN1, OUTPUT);
  pinMode(L_PWM2, OUTPUT);
  pinMode(R_EN2, OUTPUT);
  pinMode(L_EN2, OUTPUT);
  pinMode(36, OUTPUT);
  p1 = 0; p2 = 0;
  d1 = LOW; d2 = HIGH;
  e1 = DISABLE; e2 = DISABLE;Serial.println("======>From ESP<======");
  digitalWrite(36, ENABLE);
//  digitalWrite(R_EN1, ENABLE);
//  digitalWrite(L_EN1, ENABLE);
//  digitalWrite(L_PWM1, LOW);
//  analogWrite(R_PWM1, 250);
}
void loop()
{
  
  if(flag == true) 
  {
    DC(1);
    DC(2);
    flag = false;
  }
}

void receiveEvent(int howMany) 
{
  for(int i = 0; i < 6; i++) buff[i] = '\0';
  Serial.println("Da nhan duoc data");
  digitalWrite(36, !digitalRead(36));
  i=0;
  while (0 < Wire.available() && i < 6) 
    buff[i++] = Wire.read();      /* receive byte as a character */
  Serial.println("======>From ESP<======");
  Serial.println(buff);
  if(buff[0] == 'f')
  {
    d1 = HIGH; d2 = LOW;
    e1 = ENABLE; e2 = ENABLE;
  }
  else if(buff[0] == 'b')
  {
    d1 = LOW; d2 = HIGH;
    e1 = ENABLE; e2 = ENABLE;
  }
  else if(buff[0] == 'r')
  {
    d2 = HIGH;
    e2 = ENABLE;
    DC(2);
    d1 = HIGH;
    e1 = ENABLE;
    DC(1);
  }
  else if(buff[0] == 'l')
  {
    d1 = LOW;
    e1= ENABLE;
    DC(1);
    d2 = LOW;
    e2= ENABLE;
    DC(2);
  }
  else if(buff[0] == 'p')
  {
    String cmdStr = "";
    for(int j = 3; j < 6; j++) cmdStr += buff[j];
    if(buff[1] == '1')
    {
      p1 = cmdStr.toInt();
    }
    else if(buff[1] == '2')
    {
      p2 = cmdStr.toInt();
    }
  }
  else if(buff[0] == 's')
  {
    e1 = DISABLE; e2 = DISABLE;
    flag = true;
    Serial.println("p = 0");
  }
  else
  {
    flag = false;
    return;
  }
  flag = true;
}

void DC(int index)
{
  if(index == 1)
  {
    digitalWrite(R_EN1, e1);
    digitalWrite(L_EN1, e1);
    digitalWrite(L_PWM1, d1);
    if(d1 == LOW)    analogWrite(R_PWM1, p1 );
    else            analogWrite(R_PWM1, 255 - p1 );
  }
  else if(index == 2)
  {
    digitalWrite(R_EN2, e2);
    digitalWrite(L_EN2, e2);
    digitalWrite(L_PWM2, d2);
    if(d2 == LOW)    analogWrite(R_PWM2, p2);
    else            analogWrite(R_PWM2, 255 - p2);
  }
}
