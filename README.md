# OD Radio Sync
OD Radio Sync is a bash script used to update the radio station memory for certain standalone internet radio devices based on a provided csv file.  If you keep track of your favorite radio stations in a spreadsheet, complete with title and url, then you can just sort them into the order in which you want them to be listed on your radio, export to csv, and then run the script to update your radio with the stations in the file.

I wrote it for use with my GOSO MA-80 and Ocean Digital WR-220 radios, both of which use the same atrocious web interface.  It should work for any other radio which also uses the same interface.  Your mileage may vary, of course.

![Radio Web Interace](https://raw.githubusercontent.com/pfbrowning/od-radio-sync/master/web-interface.png)
If your radio hosts this web interface, then this script will probably work for you.

# Dependencies
The script depends on curl and csvkit, and the easiest way to install csvkit is via pip.  The following should get you set up on modern Debian-based distros:
```console
apt-get install python-pip curl
pip install csvkit
```
# CSV Structure
The script expects a *.csv file which contains one column entitled "Title" and another entitled "URL".  If these two columns don't exist, or are titled something else, then you're going to have a bad time.  They can be in any order, and you can also have any number of other columns as well.  [sample-stations.csv](https://raw.githubusercontent.com/pfbrowning/od-radio-sync/master/sample-stations.csv) is included as an example.
# Usage
In order to run the script, simply pass it the hostname of your radio and the absolute path to your stations *.csv file.  For example:
```console
./od-radio-sync.sh 192.168.0.5 /home/patrick/git/od-radio-sync/stations.csv
```