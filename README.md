# tum-live-recorder
Mit diesen Bash-Skripten kann der aktuell laufende Livestream aus den MW0001/MW2001 Hörsälen von live.rbg.tum.de lokal aufgezeichnet werden.    
Für andere Hörsäle und/oder Perspektiven kann das `URL_REGEX` in _\_saveCurrentStream.sh_ abgeändert werden.


# VORAUSSETZUNGEN:
- _ffmpeg_ muss installiert sein
  - macOS mit Homebrew:  `$ brew install ffmpeg`
  - Linux:               `$ sudo apt install ffmpeg` bzw. `$ brew install ffmpeg`
- NUR macOS: _gdate_ (GNU date) muss installiert sein (nur notwendig für _record.sh_ Skript)
  - mit Homebrew:        `$ brew install coreutils`
(für macOS-User, die noch kein Homebrew installiert haben —> https://brew.sh)

Um die Skripte ausführbar zu machen, einfach in den Ordner (in der diese Datei liegt) navigieren und `$ chmod +x *.sh`
ausführen.


# BEISPIELE:
- `$ ./record.sh now`    
  Startet die Aufnahme sofort und speichert die Datei unter _./saved/YYYY-MM-DD.mp4_

- `$ ./record.sh "tomorrow 08:30"`    
  Wartet bis zum nächsten Tag um 08:30 Uhr und startet dann die Aufnahme

- `$ ./record.sh 13:30`    
  Wartet bis um 13:30 Uhr (am selben Tag) und startet dann die Aufnahme

- `$ ./record.sh "wed 8:15"`    
  Wartet bis zum nächsten Mittwoch um 08:30 Uhr und startet dann die Aufnahme

- `$ ./record.sh 10min LA`    
  Wartet 10 Minuten, startet dann die Aufnahme und speichert die Datei unter _./saved/LA.mp4_ (oder _./saved/LA_2.mp4_ falls die Datei schon existiert)


Der Ausgabe-Ordner ist standardmäßig _./saved_, dieser kann aber über `OUTPUT_DIR` in _record.sh_ angepasst werden.

Die Aufnahme stoppt automatisch, wenn der Stream beendet wird oder nach spätestens 3 Stunden (konfigurierbar in _\_saveCurrentStream.sh_).
Um die Aufnahme manuell zu beenden, einfach mit `CTRL-C` einen Interrupt schicken.   
**ACHTUNG**: nur _EINMAL_ (nicht mehrfach!) `CTRL-C` drücken und warten bis _ffmpeg_ sich beendet! Andernfalls kann der Header der MP4-Datei beschädigt und die Datei damit nicht abgespielt werden!

Unter macOS geht der Computer zudem nicht in den Ruhezustand während das Skript läuft (Bildschirmruhezustand wird nicht beeinflusst).


Wer den tum-live-recorder in einem eigenen Skript/Programm einbauen will oder das Planen von Aufzeichnungen lieber [Cron](https://de.wikipedia.org/wiki/Cron) überlassen will, kann dies einfach mit Hilfe des _\_saveCurrentStream.sh_ Skriptes machen.



# tum-live-recorder (english)
These Bash-Skripts may be used to record the currently available livestreams of MW0001/MW2001 at live.rbg.tum.de locally.
To record different rooms or video feeds the property `URL_REGEX` in _\_saveCurrentStream.sh_ may be changed.


# Requirements:
- _ffmpeg_ has to be installed
  - macOS using Homebrew:  `$ brew install ffmpeg`
  - Linux:               `$ sudo apt install ffmpeg` or `$ brew install ffmpeg`
- ONLY macOS: _gdate_ (GNU date) has to be installed (only needed for _record.sh_ script)
  - using Homebrew:        `$ brew install coreutils`
(to macOS-Users, who do not have Homebrew yet —> https://brew.sh)

To allow execution of the scripts, navigate inside the folder (containing this file) and execute `$ chmod +x *.sh`


# Example calls:
- `$ ./record.sh now`    
  Immediatly start recoding and save to _./saved/YYYY-MM-DD.mp4_

- `$ ./record.sh "tomorrow 08:30"`    
  Wait until 08:30 AM tomorrow to start recording

- `$ ./record.sh 13:30`    
  Wait until 01:30 PM (on the same day) to start recoding

- `$ ./record.sh "wed 8:15"`    
  Wait until the next wednesdas 08:30 AM to start recording

- `$ ./record.sh 10min LA`    
  Wait for 10 minutes to start recodring and save to _./saved/LA.mp4_ (or _./saved/LA_2.mp4_ if already exists)


The output folder is _./saved_ by default. May be changed using the parameter `OUTPUT_DIR` in _record.sh_.

Recording stops if the stream ends or after 3 hours (delay defined in _\_saveCurrentStream.sh_).
To manually stop recording use `CTRL-C` once to interrupt the program.   
**ATTENTION**: only press `CTRL-C` _ONCE_ (not multiple times!) and wait until _ffmpeg_ terminates! Interrupting _ffmpeg_ may cause damage to the header of the MP4 file and prevent it from being played!

MacOS is prevented from sleeping while the script is running (screensaver not influenced).


If you want to integrate the tum-live-recorder into your own script/program or you rather want to leave the scheduling job to [Cron](https://en.wikipedia.org/wiki/Cron), you can simply do that by using the _\_saveCurrentStream.sh_ script!
