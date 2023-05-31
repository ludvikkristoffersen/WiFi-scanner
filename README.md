# WiFi scanner
Inspiration is taken from David Bombal's YouTube video regarding how to crack a WiFi password using hashcat and hcxdumptool, so all credit goes to him for the idea. If you have not watched the video I would advise you to do so since this script does not show or do any cracking of passwords. The script is made to automate the process of capturing the four-way handshake using the hcxdumptool, then converting the output of the hcxdumptool to a hashcat readable format using the hcxpcapngtool.

[![David Bombal](https://img.youtube.com/vi/Usw0IlGbkC4/0.jpg)](https://www.youtube.com/watch?v=Usw0IlGbkC4)



# Tools in script
<p>The tools used in this script are created by ZerBea, if you want to learn more about the tools visit the links below!</p>

   • [hcxdumptool](https://github.com/ZerBea/hcxdumptool) by ZerBea
 
   • [hcxtools](https://github.com/ZerBea/hcxtools) by ZerBea



# Installation
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

# Usage
After running the script you should have three files: <name>.pcapng, <name>.hc22000, and ESSID list. You could now go into the <name>.hc22000 file and select which WiFi network you want to crack by filtering out the MAC address of your target. To obtain the MAC address of your target you could do this command, this shows you the both the ESSID and MAC addresses to make it easier to find:
```bash
sudo hcxdumptool --do_rcascan -i <wlan_name>
```



