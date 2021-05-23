# CarUI
CarUI is a QT application can be used in the EV to monitor various factors.
To use this Application:
One should buuld or Cross-Complie this project for the particular Arm device that you are using in the Vehicle.

During testing of this Application, I have used Arduino and INA219 chip for sensing real time current consumption from the battery pack.
To use Software Serial use test.ino file and to use Hardware Serial use ColoumbCounter.ino file.
In the Arduino files all the INA219 configurations are done.

To test my project, I have cross-compiled my Qt project for the Raspberry Pi 3B module.

Functionalities of Appliction:
i)Read the Battery Percentage by CoulombCounter Method.
ii)Changing of Gears from the Application.
iii)Monitoring Real time Current Consumption -- During Charging and Discharging

For the Cross-Compilation:
I have cross-compiled Qt 5.15.0 verion on the Raspberry pi 3B
Refer to the Steps to Configure file for the help.
for the successfull cross-compilation some symbolic links should be changed in the Raspbian.
for changing symbolic links refer to Symbolic links files.

Data Flow for the Application will be like:
Car's Battery Pack --> INA219 chip Board --> Arduino --> Raspberry Pi 3b !!

Thanks.


