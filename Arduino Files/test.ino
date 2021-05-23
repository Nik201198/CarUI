#include <SoftwareSerial.h>
#include <Wire.h>
#include <Adafruit_INA219.h>

SoftwareSerial mySerial(12, 11); //RX ,Tx

Adafruit_INA219 ina219;

float shuntvoltage = 0;
float orishuntvoltage = 0;
float busvoltage = 0;
long current_mA = 0;
float loadvoltage = 0;
float power_mW = 0;
float cur = 0;
float coul = 0;
//float s = 0;
long samplet = 0;
unsigned long countt = 0;
float sample[200];
int i;
int ni;
//int str = 123;
double x = 0;
//long time_toSend = 0;
int reset_status = 0;
//long Senddelay = 0;
const byte numChars = 32;
char tempChars[numChars];
char receivedChars[numChars];
boolean newData = false;
float coulFromRpi = 0;
int integer1 = 0;
char start;
int KSI = 1;
int R, F, N;
int t = 1;
int c1, c;
int K_S_I, F_Gear, R_Gear;
int front, reverse, switchh;
unsigned long limit = 4294967045;

void setup() {
  Serial.begin(4800);
  while(!Serial){
    delay(1);
  }
//  Serial.println(F("Hello"));
  uint32_t currentFrequency;
  if (! ina219.begin()) {
    while (1) {
      delay(10);
    }
  }


  mySerial.begin(4800);

  pinMode(8, INPUT);//For KSI
  pinMode(2, OUTPUT);//For Forward gear
  pinMode(3, OUTPUT);//For Reverse gear
  pinMode(9, INPUT);//for charger status
}
void loop() {
  Serial.println(F("Hello"));

  orishuntvoltage = ina219.getShuntVoltage_mV();
  sample[i] = (0.54 * orishuntvoltage) + orishuntvoltage;
  i++;

  if ( millis() > countt )
  {
    shuntvoltage = 0;
    for ( ni = 0 ; ni < 200 ; ni++ )
    {
      shuntvoltage = sample[ni] + shuntvoltage;
    }
    shuntvoltage = (shuntvoltage / 200) + 0.1;
    Serial.print(F("Shunt Voltage:")); Serial.println(shuntvoltage);
    cur = ( 1.36 * shuntvoltage );
    coul = coul + cur;
    countt = countt + 250;
    if (countt >= limit) {
      countt = 0;
    }
  }
  recvWithEndMarker(); // Reads the serialport and extract it into the receivedchars
  if (newData == true) {
    strcpy(tempChars, receivedChars);
    Serial.print(F("Received:")) ; Serial.println(tempChars);
    String val1 = getValue(tempChars, ',', 0);
    String val2 = getValue(tempChars, ',', 1);
    String val3 = getValue(tempChars, ',', 2);
    String val11 = getValue(tempChars, ',', 3);
    String val4 = val1.substring(3);
    String val5 = val2.substring(3);
    String val6 = val3.substring(3);
    String val7 = val11.substring(3);

    start = val5.charAt(0);
    Serial.print(F("Status from RPI:")); Serial.println(start);
    integer1 = val7.toInt();
    coulFromRpi = val6.toFloat();

    gears();

    if (start == '1') {
      reset_status = 1;
      mySerial.print(reset_status); mySerial.print(F(";")); mySerial.print(coul); mySerial.print(F(";")); mySerial.print(cur); mySerial.print(F(";")); mySerial.print(KSI); mySerial.print(F); mySerial.print(R); mySerial.print(F(";")); mySerial.print(F(";"));
      Serial.print(F("Sent:")); Serial.print(reset_status); Serial.print(F(";")); Serial.print(coul); Serial.print(F(";")); Serial.print(cur); Serial.print(F(";")); Serial.print(KSI); Serial.print(F); Serial.print(R); Serial.print(F(";")); Serial.println(F(";"));
      Serial.println(F("__________________________"));
      delay(100);
    }
    if (start == '2') {
      reset_status = 2;
      mySerial.print(reset_status); mySerial.print(F(";")); mySerial.print(coul); mySerial.print(F(";")); mySerial.print(cur); mySerial.print(F(";")); mySerial.print(KSI); mySerial.print(F); mySerial.print(R); mySerial.print(F(";")); mySerial.print(F(";"));
      Serial.print(F("Sent:")); Serial.print(reset_status); Serial.print(F(";")); Serial.print(coul); Serial.print(F(";")); Serial.print(cur); Serial.print(F(";")); Serial.print(KSI); Serial.print(F); Serial.print(R); Serial.print(F(";")); Serial.println(F(";"));
      Serial.println(F("__________________________"));
      coul = coul + (coulFromRpi);
      reset_status = 2;
    }
    if (start == '3') {
      mySerial.print(reset_status); mySerial.print(F(";")); mySerial.print(coul); mySerial.print(F(";")); mySerial.print(cur); mySerial.print(F(";")); mySerial.print(KSI); mySerial.print(F); mySerial.print(R); mySerial.print(F(";")); mySerial.print(F(";"));
      Serial.print(F("Sent:")); Serial.print(reset_status); Serial.print(F(";")); Serial.print(coul); Serial.print(F(";")); Serial.print(cur); Serial.print(F(";")); Serial.print(KSI); Serial.print(F); Serial.print(R); Serial.print(F(";")); Serial.println(F(";"));
      Serial.println(F("__________________________"));
    }

    newData = false;
  }

  if (i == 200)
  {
    i = 0;
  }
  //    Serial.print(mySerial.read());
  //    Serial.print(mySerial.write());
}
//__________________________ Receive Data ___________________________//

void recvWithEndMarker() {
  static byte ndx = 0;
  char endMarker = '#';
  char rc;

  while (mySerial.available() > 0 && newData == false) {
    //        delay(100);
    mySerial.flush();
    rc = mySerial.read();
    //        time_toSend = millis();
    if (rc != endMarker) {
      receivedChars[ndx] = rc;
      ndx++;
      if (ndx >= numChars) {
        ndx = numChars - 1;
      }
    }
    else {
      receivedChars[ndx] = '\0'; // terminate the string
      ndx = 0;
      newData = true;
    }
  }
}

//_____________________ Parse Received Data __________________________//

String getValue(String data, char separator, int index)
{
  int found = 0;
  int strIndex[] = { 0, -1 };
  int maxIndex = data.length() - 1;

  for (int i = 0; i <= maxIndex && found <= index; i++) {
    if (data.charAt(i) == separator || i == maxIndex) {
      found++;
      strIndex[0] = strIndex[1] + 1;
      strIndex[1] = (i == maxIndex) ? i + 1 : i;
    }
  }
  return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

//____________________ Gear Relays Settings ___________________________//

void gears() {
  KSI = integer1 / 100;
  F = (integer1 - (KSI * 100)) / 10;
  if (F == 1) {
    R = 0;
    //    setgears(KSI,F,R);
  }
  else {
    R = integer1 - ((KSI * 100) + (F * 10));
    //  setgears(KSI,F,R);
  }
}
////____________________ Gear Relays Settings Writing___________________________//
////
//void setgears(int &ksi, int &f, int &r) {
//  if (ksi == 1) {
//    digitalWrite(2, HIGH);
//  }
//  else {
//    digitalWrite(2, LOW);
//  }
//  if (f == 1) {
//    digitalWrite(3, HIGH);
//  }
//  else {
//    digitalWrite(3, LOW);
//  }
//  if (r == 1) {
//    digitalWrite(4, HIGH);
//  }
//  else {
//    digitalWrite(4, LOW);
//  }
//}
//__________________check gear relay status_____________________________//

void readSwitch() {

  switchh = digitalRead(8);
  front = digitalRead(2);
  reverse = digitalRead(3);
  if (switchh == 1) {
    K_S_I = 1;
    readGears();
  }
  else {
    K_S_I = 0;
    F_Gear = 0;
    R_Gear = 0;
  }
}
//______________________________________________________________________//
void readGears() {
  if (front == 1) {
    F_Gear = 1;
  }
  else {
    F_Gear = 0;
  }
  if (reverse == 1) {
    R_Gear = 1;
  }
  else {
    R_Gear = 0;
  }
}
//___________________charging status_____________________________________//
void charging_status() {
  c1 = digitalRead(9);
  if (c1 == 1) {
    c = 1;
  }
  else {
    c = 0;
  }
}
