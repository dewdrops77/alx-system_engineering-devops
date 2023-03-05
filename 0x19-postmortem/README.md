POSTMORTEM

When the System Engineering & Dev Ops project 0x19 from ALX School was made public, an outage happened on a lone Ubuntu 14.04 container operating the Apache web server. When a simple HTML file defining a Holberton WordPress site was anticipated as a response to GET requests, the server returned 500 Internal Server Errors instead.

Debugging Process

* ps aux was used to check active processes. Root and www-data were two apache2 processes that were successfully operating.
* looked in the /etc/apache2/sites-available directory's subdirectory. discovered that /var/www/html/ was the location of the material being served by the web server.
* Run strace on the PID of the main Apache process in one terminal. The server folded in another. Great things were anticipated, but underwhelmed. No helpful information was provided by strace.
* Step 3 was repeated, but this time used the PID for the www-data function. lowered standards this time, and it paid off! When trying to reach the file /var/www/html/wp-includes/class-wp-locale.phpp, strace revealed a -1 ENOENT (No such file or directory) error.
* I used Vim pattern matching to go through each file in the /var/www/html/ directory in an effort to find the incorrect.phpp file suffix. the wp-settings.php file is where you can find it. (Line 137, require once(ABSPATH. WPINC. "/class-wp-locale.php");).
* Removed the line's final p
* A different curl on the host was tested. 200 A-ok!
* I created a puppet manifest to orchestrate the error's correction.
Summary 

* Simply put, a mistake. Have to adore 'em. Specifically, when attempting to load the file class-wp-locale.phpp, the WordPress app was running into a crucial error in wp-settings.php. Class-wp-locale.php was the right file name, and it was located in the wp-content directory of the application folder.
* The ending p was simply removed as part of the typo's patch.

Prevention 
* This outage was caused by an application error, not a web server issue. Please bear the following in mind going forward to avoid any more outages of this nature.
* Before deploying, test the program. If the program had been tested, this error would have occurred and could have been fixed sooner.



