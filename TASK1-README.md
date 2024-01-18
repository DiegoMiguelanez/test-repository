# test-repository

Documentation for random_numbers.sh:

[Build Instructions]:

1) Copy and paste the script into a new file, for example, random_numbers.sh.

2) Make the script executable: chmod +x random_numbers.sh.

[Usage]:

Run the script from the terminal: 
```bash
./random_numbers.sh
```
[Description]:

This Bash script generates a random permutation of numbers from 1 to a specified maximum number (max_number). It checks if max_number is a positive integer using a regular expression. If it is valid, the script uses the shuf command to shuffle the sequence of numbers.

[Tests]:

Running the script with different max_number variable values:

1) Valid input test 1(max_number=10):
```bash
root@diego-Legion-5-15ACH6:~/objective-interview# ./random_order.sh
6
3
4
1
10
8
7
2
9
5
```
2) Invalid input test 1(max_number="abc"):
```bash
./random_numbers.sh
root@diego-Legion-5-15ACH6:~/objective-interview# ./random_order.sh
Please enter a positive valid integer for max_number...
```
3) Invalid input test 2(max_number=-10):
```bash
./random_numbers.sh
root@diego-Legion-5-15ACH6:~/objective-interview# ./random_order.sh
Please enter a positive valid integer for max_number...
```
[Known Limitations / Bugs]:

1) Dependency on shuf:
The script relies on the shuf command, which might not be available on all systems although pretty unlikely, I just thought it was cleaner than using an array and environment variable $RANDOM.

2) Range limitation:
The script is designed for generating numbers from 1 to 10 by internal variable max_number. Modifying it for a different range may require code adjustments, if asked I would have made the script interactive so user could enter different inputs when running it.
