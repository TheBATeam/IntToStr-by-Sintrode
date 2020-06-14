# IntToStr-by-Sintrode
IntToStr is a script that converts integers to their word equivalents. 1000 becomes one thousand, 256 becomes two hundred and fifty-six, and so forth. Coming in at just over 6KB, this script is mostly comments and some hard-coded arrays. A previous version of the script dynamically generated the arrays, but the script took three times as long to run.
# FEATURES OF INTTOSTR BY SINTRODE
To convert numbers to words – The script starts with basic user input to confirm that an integer was actually provided. Once it’s been determined that one was, the script breaks the number into chunks of three digits, and the highest power of 1000 is determined. The number is then printed one chunk at a time with its corresponding power of 1000.
## PERFORMANCE ANALYSIS – INTTOSTR BY SINTRODE
IntToStr can handle integers up to sixty-six digits long. A number this big takes about 330 milliseconds to display. A simple five-digit number takes around 100 milliseconds to display. (Of course, this will vary based on your PC’s specs.)

If the script is revisited in the future, a help screen will be included if invalid input is provided, and the code to validate that user input is actually a number will handle dashes better – right now, the script thinks that 123-456 is a valid number and is read “one million two hundred thirty- thousand four hundred and fifty-six.“

(Read Complete Article)[https://www.thebateam.org/2020/06/convert-numbers-to-words-with-cmd/]
