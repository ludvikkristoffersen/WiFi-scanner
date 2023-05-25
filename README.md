# WiFi scanner
This is taken from David Bombal's YouTube video regarding how to crack a WiFi password using hashcat and hcxdumptool, so all credit goes to him. If you have not watched the video I would advise you to do so since this script does not crack any password, I took the commands showed in the video of capturing the WiFi handshake and converting the pcapng file to a hc22000 file and created a script making the whole process faster and easier:

[![David Bombal](https://img.youtube.com/vi/Usw0IlGbkC4/0.jpg)](https://www.youtube.com/watch?v=Usw0IlGbkC4)

## Tools in script
<p>The tools used in this script are created by ZerBea, if you want to learn more about the tools visit the links below!</p>
<p>These are the tools used in the script:</p>

   • [hcxdumptool](https://github.com/ZerBea/hcxdumptool) by ZerBea
 
   • [hcxtools](https://github.com/ZerBea/hcxtools) by ZerBea

## Installation and usage
Getting the source:
```bash
git clone https://github.com/Luudde/WiFi-scanner.git
cd WiFi-scanner
```
Make the file executable:
```bash
sudo chmod +x WiFi-scanner.sh
```
Run the script:
```bash
sudo ./WiFi-scanner.sh
```


