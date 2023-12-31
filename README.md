# INTRODUCE
Design hardware to control the Sona robot used to clean solar panels.
![example1](Images/img1.jpg)
***
# HARDWARE 
#### List of main devices
- **Arduino Mega2560**: to control engine by bridge ciruit H.
- **Esp8266**: to receive the signal from the controller and transmit the signal to the Arduino.
- **BTS7960**: bridge ciruit H.
#### Using "Altium Designer" to make a circuit
![example1](Images/pic1.png)
- Source link: [schematic file][1]

#### Result    
![example1](Images/pic2.png)

Actual image (the circuit here is just the lower layer wiring circuit, not the PCB circuit as designed above).
![example1](Images/pic3.png)
![example1](Images/pic4.png)
***
# SOFTWARE 
**APP**: Using Flutter language

![example1](Images/pic5.png)
|Button|Function|
|---|----------------------------|
|Up|Robot goes forward|
|Down|Robot goes backwards|
|Left|Robot goes left|
|Right|Robot goes right|
|Sweep|Robot cleans up|
|connected/disconnected|to connect as well as notify the connection status between the phone and the robot|
|Send|send the speed of the robot down from the phone (the speed is adjusted by the slide bar)|
- Source link: 
  - [flutter file][2]
  - [esp file][3]
  - [arduino file][4]
***
**Detailed report**: [link][5]

[1]: <https://github.com/lhkhanh080720/Sona_Robot/tree/main/Schematic>
[2]: <https://github.com/lhkhanh080720/Sona_Robot/tree/main/Code%20V1/Code/(Main)%20Code/Flutter/flutter_application_1>
[3]: <https://github.com/lhkhanh080720/Sona_Robot/blob/main/Code%20V1/Code/(Main)%20Code/esp8266/esp8266.ino>
[4]: <https://github.com/lhkhanh080720/Sona_Robot/blob/main/Code%20V1/Code/(Main)%20Code/sona/sona.ino>
[5]: <https://github.com/lhkhanh080720/Sona_Robot/blob/main/Report/SONA%20ROBOT%20v1%20Document.docx>

