# dbx

# current version 0.1.5

An extremely simple database facility for godot

- It is not the most efficient but is written in gdscript - so no added compilation per platform
- It doesn't have a lot of error checking 
- It has no real parsing such as SQL but uses a simplified mongodb style querying
- It is very simplistic and will never be a grownup database facility
- It does not have any data saving / loading facilities from the disk - that is up to you to store as needed.
- The querying goes from left to right and the condition of current query affects the condition of the previous query. In that sense it works like a stack.

Saying that, it can be used to maintain in-game data and use querying to get/set data.

Have fun

