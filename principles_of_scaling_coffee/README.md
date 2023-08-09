# principles of scaling coffee #

Consider this classic Italian math problem: eight out-of-town relatives are coming for dinner, as well as two friends and their three children, joining a family of four. Five want white wine as an apertif, four want red, and three want both. All of them eat the lasagne except for the rebellious vegetarian child. When the dinner is over, most of them enjoyed it and all but two want coffee. How many different coffee makers are needed?

![moka_sizes.jpg](https://github.com/wrf/misc-analyses/blob/master/principles_of_scaling_coffee/images/moka_sizes.jpg)

The answer is four. But you always need an extra just in case someone else shows up.

As long as the coffee makers scale in size in a binary fashion, then any number of people can be accommodated, up to 15. Thus 7 is 1+2+4, requiring only three stove burners, 9 is 8+1, and so forth. After 15, you have to borrow an additional coffee maker from the neighbor whose children have moved away to Rome and never call, so they no longer need the big one.

Bonus question: how many coffee makers are needed so that there is enough espresso left to drink cold at 6am when extremely hungover?
