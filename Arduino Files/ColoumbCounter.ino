#include <Wire.h>
#include <Adafruit_INA219.h>

Adafruit_INA219 ina219;

float shuntvoltage = 0;
float orishuntvoltage = 0;
  float busvoltage = 0;
  long current_mA = 0;
  float loadvoltage = 0;
  float power_mW = 0;
  float cur=381092;
  float coul = 0;
  float s = 0;
  long samplet = 0;
  long countt = 0;
  float sample[200];
int i;
int ni;
int str = 123;
double x = 0;
long time_toSend = 0;
int reset_status = 1;
long Senddelay = 0;
const byte numChars = 32;
char receivedChars[numChars]; 
char tempChars[numChars];       
char messageFromPC[numChars] = {0};
int integerFromPC = 0;
char V0;
int V1;
//float floatFromPC = 0.0;

boolean newData = false;



void setup(void) 
{
  Serial.begin(9600);
  while (!Serial) {
      // will pause Zero, Leonardo, etc until serial console opens
      delay(1);
  }

  uint32_t currentFrequency;
    
//  Serial.println("Hello!");
  
  // Initialize the INA219.
  // By default the initialization will use the largest range (32V, 2A).  However
  // you can call a setCalibration function to change this range (see comments).
  if (! ina219.begin()) {
//    Serial.println("Failed to find INA219 chip");
    while (1) { delay(10); }
  }
  // To use a slightly lower 32V, 1A range (higher precision on amps):
  //ina219.setCalibration_32V_1A();
  // Or to use a lower 16V, 400mA range (higher precision on volts and amps):
  //ina219.setCalibration_16V_400mA();

//  Serial.println("Measuring voltage and current with INA219 ...");
}

void loop(void) 
{ 
  orishuntvoltage = ina219.getShuntVoltage_mV();
  sample[i] = (0.54 * orishuntvoltage) + orishuntvoltage;
  //Serial.print("Sample: "); Serial.print(sample[i]); 
  //delay(5);  
 i++;
/*____________________________________________________________________*/

if ( (millis()-countt) > 250)
{
//  Serial.print("CountT: "); Serial.println(millis()-countt); 
  shuntvoltage = 0;
//  int str = 1234;
  for ( ni = 0 ; ni<200 ; ni++ )
  {
    shuntvoltage=sample[ni]+shuntvoltage;
    //Serial.print("Sample: "); Serial.print(sample[ni]); 
  } 
  shuntvoltage = (shuntvoltage / 200) + 0.15;
  cur = ( 1.36 * shuntvoltage ); 
  coul = coul + cur;
  countt=millis();
}
/*____________________________________________________________________*/
  if(Serial.available())
  {
   char str = Serial.read();
    time_toSend = millis();
    if(str == 's')
    {
      Serial.print(reset_status);Serial.print(";");Serial.print(coul);Serial.print(";");Serial.print(cur);
//      delay(250);
      reset_status = 2;
    } 
    else {
      process();
      if (newData == true) {
        strcpy(tempChars, receivedChars);
        parseData();
        showNewData();
        showParsedData();
        newData = false;
      }
     }  
    }
/*____________________________________________________________________*/
if ((millis()-time_toSend) > 5000)
  {
   delay(20);
    Serial.print("0");Serial.print(";");Serial.print("0");Serial.print(";");Serial.print("0");
  }

if (i == 200)
{
  i=0;
}

}
/*____________________________________________________________________*/
  
  void process(){
    static byte ndx = 0;
    char endMarker = '\n';
    char rc;
      while(Serial.available() && newData == false){
        rc = Serial.read();

        if(rc != endmarker){
          receivedChars[ndx] = rc;
          ndx++;
          if(ndx >= numChars){
            ndx = numChars - 1;
          }
        }
        else{
            receivedChars[ndx] = '\0'; 
            ndx = 0;
            newData = true;
        }
      } 
    }
/*___s1:1,s2:10,s3:5987.23,_________________________________________________________________*/

void parseData() {      // split the data into its parts

    char * strtokIndx; // this is used by strtok() as an index

    strtokIndx = strtok(tempChars,":");      // get the first part - the string
    strcpy(messageFromPC, strtokIndx); // copy it to messageFromPC
 
    strtokIndx = strtok(NULL, ","); // this continues where the previous call left off
    integerFromPC = atof(strtokIndx);     // convert this part to a float

//    strtokIndx = strtok(NULL, ",");
//    floatFromPC = atof(strtokIndx);     // convert this part to a float
}
/*____________________________________________________________________*/

void showNewData() {
    if (newData == true) {
   //     Serial.print("This just in ... ");
        Serial.println(receivedChars);
        Serial.print("\n");
        newData = false;
    }
}

/*____________________________________________________________________*/


void showParsedData() {
    Serial.print("Message ");
    Serial.println(messageFromPC);
    Serial.print("Integer ");
    Serial.println(integerFromPC);
    Serial.print("V1: ");
    Serial.println(V1);
    Serial.print("----------");
    Serial.print("\n");
//    Serial.print("Float ");
//    Serial.println(floatFromPC);
}
/*____________________________________________________________________*/
