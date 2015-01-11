 
GNUKhata
========
**GNUKhata is FOSS accounting web application**

Here you can add accounts, create vouchers download reports etc.


Commandline
~~~~~~~~~~~
Take clone of this repo.

Initially go to core_engine directory by:
$cd core_engine

Then run the command:
$sudo gkstart
This command starts the core logic of the project including the database and backend

Then open a new tab on the terminal by pressing Ctrl+Alt+T keys simultaneously.

Then go to webapp directory:
$cd webapp

Later run the command:
$paster serve --reload development.ini
This command starts the daemon and the frontend of the project.

Go to your browser and visit the url:
http://127.0.0.1:8080

This setup will start GNUKhata on your browser.

There is javascript code for automatic "to-date" when you enter "from-date" with all the validations in file webapp/gnukhata/templates/start-up.mako
and many more...

