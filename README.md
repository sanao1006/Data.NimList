# Data.NimList
[![.github/workflows/main.yml](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml/badge.svg)](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml)  

# Whats' this?
### This is a Nim implementation of Haskell's Data.List library  
※Not completed(In progress)  
# Introduction of Functions

## ++ ([a] -> [a] -> [a])
```Nim
@[1,2,3] ++ @[4,5,6] == @[1,2,3,4,5,6]
```

## head ([a] -> a)
```Nim
@[1,2,3,4].head == 1  
@["abc","def","ghi","jkl"].head == "abc"  
"abcdefg".head == 'a'
```
## last ([a] -> a)
```Nim
@[1,2,3,4].last == 4
@["abc","def","ghi","jkl"].last == "jkl"
"abcdefg".last == 'g'
```
