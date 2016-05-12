[Mod] Chatcommand stopwatch [chatcommand_delays]

This mod tells the time a chatcommand took to get executed.  
So for example if you want to know how long it takes to set 100x100x100 nodes using worldedit,  
you only need to have this mod, it automatically adds the delay to the message sent to the player (if no message is returned, the delay gets sent in an own line).  
Currently the time is added in brackets at the end of the message.  
If the delay is very short, e.g. when you just teleport somewhere, the time isn't added to not cause spamming.

**Depends:** see [depends.txt](https://raw.githubusercontent.com/HybridDog/chatcommand_delays/master/depends.txt)  
**License:** see [LICENSE.txt](https://raw.githubusercontent.com/HybridDog/chatcommand_delays/master/LICENSE.txt)  
**Download:** [zip](https://github.com/HybridDog/chatcommand_delays/archive/master.zip), [tar.gz](https://github.com/HybridDog/chatcommand_delays/tarball/master)  

Obviously Worldedit doesn't use minetest.register_chatcommand correctly  
setting about 2.5 mio nodes may take longer for you, I use my own worldedit modifications  
![I'm a screenshot!](https://cloud.githubusercontent.com/assets/3192173/15223716/1dbe7632-1876-11e6-9f1c-1e8178b11e96.png)

It works with every chatcommand, e.g. the one of cave_lighting:  
![I'm a screenshot!](https://cloud.githubusercontent.com/assets/3192173/15223395/7e263b42-1874-11e6-864a-98c18ff9df00.png)

If you got ideas or found bugs, please tell them to me.

[How to install a mod?](http://wiki.minetest.net/Installing_Mods)

