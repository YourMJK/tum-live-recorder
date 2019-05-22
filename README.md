# tum-live-recorder
Mit diesen Bash-Skripten kann der aktuell laufende Livestream aus den MW0001/MW2001 Hörsälen von live.rbg.tum.de aufgezeichnet werden.    
Für andere Hörsäle und/oder Perspektiven kann das `URL_REGEX` in _\_saveCurrentStream.sh_ abgeändert werden.


# VORAUSSETZUNGEN:
- ffmpeg muss installiert sein
  - macOS mit Homebrew:  `$ brew install ffmpeg`
  - Linux:               `$ sudo apt install ffmpeg`
- NUR macOS: gdate (GNU date) muss installiert sein
  - mit Homebrew:        `$ brew install coreutils`
(für macOS-User, die kein Homebrew installiert haben: schämt euch —> https://brew.sh)

Um die Skripte ausführbar zu machen, einfach in diesen Ordner (in der diese Datei liegt) navigieren und
$ chmod +x *.sh
ausführen.


# BEISPIELE:
- `$ ./record.sh now`
  Startet die Aufnahme sofort und speichert die Datei unter ./saved/YYYY-MM-DD.mp4

- `$ ./record.sh "tomorrow 08:30"`
  Wartet bis zum nächsten Tag um 08:30 Uhr und startet dann die Aufnahme

- `$ ./record.sh 13:30`
  Wartet bis um 13:30 Uhr (am selben Tag) und startet dann die Aufnahme

- `$ ./record.sh "wed 8:15"`
  Wartet bis zum nächsten Mittwoch um 08:30 Uhr und startet dann die Aufnahme

- `$ ./record.sh 10min LA`
  Wartet 10 Minuten, startet dann die Aufnahme und speichert die Datei unter _./saved/LA.mp4_ (oder _./saved/LA_2.mp4_ falls die Datei schon existiert)


Die Aufnahme stoppt automatisch, wenn der Stream beendet wird oder nach spätestens 2 Stunden (konfigurierbar in _\_saveCurrentStream.sh_).
Um die Aufnahme manuell zu beenden, einfach mit CTRL-C einen Interrupt schicken.   
**ACHTUNG**: nur _EINMAL_ (nicht mehrfach!) CTRL-C drücken und warten bis ffmpeg sich beendet! Andernfalls kann der Header der MP4-Datei beschädigt und die Datei damit nicht abgespielt werden!

Unter macOS geht der Computer nicht in den Ruhezustand während das Skript läuft (Bildschirmruhezustand wird nicht beeinflusst).
