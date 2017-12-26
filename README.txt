FFXI Starlight Celebration Job Guessing Game Solver

This Windows script uses a Mastermind solver to brute force the Starlight Celebration Job Guessing Game answers.

Launch the .bat file and choose Advanced or not, then follow the prompts for setting jobs and entering the CH and H results.

This is an edited version of smd111's original fork, with the only change being to accomodate the same job being used multiple times.

Tested good for the 2017 celebration.

Best of luck!

- Kriz (Valefor)

Original README.txt file below...

---------------------------------------------------
Super Fuck This Mind v2.0
               by Tritonio

 Copyright 2008-2009 Konstantinos Asimakis
       http://inshame.blogspot.com



Q: What is it?
A: SFTM is a small Lua program that finds hidden Mastermind combinations.

Q: Why do I need it?
A: To see how much humans suck at Mastermind and to cheat on online Mastermind games. Har har har!

Q: How do I run it?
A: Just run the batch file SuperFuckThisMind.bat. (The one with the gear in its icon)

Q: Are there any settings?
A: When you run SFTM it will ask some question like how many colors are allowed and the length (places) of the combination and if colors are allowed to appear twice (or more times) in the combination. It will also ask you if you want to play the suggestions.

Q: "Play the suggestions"?
A: Yes, SFTM will suggest moves on every try and by default will play them automatically.

Q: Why shouldn't I want it to play the suggestions automatically?
A: Because when you cheat on an online game you can give make mistakes. Then you will have to close SFTM, re-run it and tell it not to play the suggestions so that you can play again the old moves without restarting the game and raising suspicions.

Q: I am bored to type in these settings every time. Make my life easier, will ya?
A: You can also write these numbers in files named: colors.txt places.txt usecolorstwice.txt play.txt. I have never tried this though, I find it highly unnecessary and still wonder if _I_ did put that code in there...

Q: Where are the colors??? I can only see numbers!
A: Because printing colors in the command line is not that easy and for other reasons too. If you still
want to rename the digits to color names then edit the colornames.txt file. Normally it will contain the numbers from 1-20 so that the numbering will start from 1. If you delete this file the numbers will start from 0!

Q: Why does it tell me that it is "not possible"?
A: Because it is not. Your human opponent is either lying or made a mistake. Or you made a mistake typing in the answers of you opponent. If the first is the case then tell your opponent to tell you the correct combination and SFTM will find his/her mistakes.

Q: Things go wrong when I use SFTM. It closes with an error or behaves strangely. Why?
A: SFTM is very sensitive about data input. I was too bored to make error tolerant code but you are free
to do it yourself. So try to enter what you are asked exactly. For example if you have customized the 
colors make sure you type then in the correct case!

Q: Can I edit the source code?
A: Yeap. That .lua file is the source code for SFTM. Beautiful, uncommented code. Edit it as long as you keep that copyright notice. Unless you are a copyright hater like me...

Q: I found a comment in the source code.
A: Yes there is one comment. Deleting it might cause SFTM to realize it's existence.

Q: Why should I cheat afterall???
A: You shouldn't. It's unethical for you to cheat. But not for me since I made this program. So at least try to understand the source code (Buahaha!).
