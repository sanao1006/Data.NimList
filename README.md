# Data.NimList
[![.github/workflows/main.yml](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml/badge.svg)](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml)  

# Whats' this?
### This is a Nim implementation of Haskell's Data.List library  
※Not completed(In progress)  
# Introduction of Functions

## [++](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L7) ([a] -> [a] -> [a])
Append two lists
```Nim
@[1,2,3] ++ @[4,5,6] == @[1,2,3,4,5,6]
```

## [head](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L20) ([a] -> a)
```Nim
@[1,2,3,4].head == 1  
@["abc","def","ghi","jkl"].head == "abc"  
"abcdefg".head == 'a'
```

## [last](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L33) ([a] -> a)
```Nim
@[1,2,3,4].last == 4
@["abc","def","ghi"].tail == @["def","ghi"]
"abcdefg".last == 'g'
```

## [tail](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L46) ([a] -> [a])
```Nim
@[1,2,3].tail == @[2,3]
@["abc","def","ghi"].tail == @["def","ghi"]
"abcdefg".tail == "bcdefg"
```

## [init](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L59) ([a] -> [a])
```Nim
@[1,2,3].init == @[1,2]
@["abc","def","ghi"].init == @["abc","def"]
"abcdefg".init == "abcdef"
```

## [uncons](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L89) ([a] -> Option(a,[a]))
```Nim
uncons(@[1,2,3]) == some((1,@[2,3]))
uncons("abcde") == some(('a',"bcde"))
let a:seq[int] = @[]
uncons(a) == none((int,seq[int]))
```

## [singleton](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L103) (a -> [a])
```Nim
singleton(3) == @[3]
singleton("abc") == @["abc"]
singleton(1.1) == @[1.1]
singleton('c') == @['c']
```

## [null](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L73) ([a] -> bool)
```Nim
let a: seq[int] = @[]
let b: seq[int = @[1,2,3]
a.null == true
b.null == false
"".null == true
```
