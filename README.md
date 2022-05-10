# Data.NimList
[![.github/workflows/main.yml](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml/badge.svg)](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml)  

# Whats' this?
### This is a Nim implementation of Haskell's Data.List library  
※Not completed(In progress)  
# Basic Functions

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

# List transformers
※map and reverse are omitted.
## [intersperse](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L122) (a -> [a] -> [a])
```Nim
intersperse(1,@[2,3,4,5]) == @[2,1,3,1,4,1,5]
 intersperse(',', "1234") == "1,2,3,4"
intersperse(' ', "ABCD") == "A B C D"
```

## [intercalate](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L136) ([a] -> [[a]] -> [a])
```Nim
 intercalate(", ", ["Lorem", "ipsum", "dolor"]) == "Lorem, ipsum, dolor"
```

## [transepose](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L142) ([[a]] -> [[a]])
```Nim
@[@[1,2,3],@[4,5,6]].transpose == @[@[1,4],@[2,5],@[3,6]] 
@[@['a','b','c'],@['d','e','f']].transpose == @[@['a','d'],@['b','e'],@['c','f']]
@["123","456"].transpose == @["14","25","36"]
@["abc","def"].transpose == @["ad","be","cf"]
```

## [subsequences(not completed)](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L225) ([a] -> [[a]])
```Nim
"123".subsequences == @[" ", "3", "2", "23", "1", "13", "12", "123"]
```

## [permutations](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L173) ([a] -> [[a]])
```Nim
@[1,2,3].permutations == @[
     @[1, 2, 3], @[1, 3, 2],
     @[2, 1, 3],@[2, 3, 1],
     @[3, 1, 2], @[3, 2, 1]
     ]
"aiu".permutations == @[
      @['a', 'i', 'u'], @['a', 'u', 'i'], 
      @['i', 'a', 'u'], @['i', 'u', 'a'], 
      @['u', 'a', 'i'], @['u', 'i', 'a']
    ]
```

# Sublists  

## [take](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L361) (a -> [a] -> [a])
```Nim
take(3,@[1,2,3,4]) == @[1,2,3]
take(3,"abcdefg") == "abc"
```

## [drop](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L375) (a -> [a] -> [a])
```Nim
drop(3,@[1,2,3,4,5]) == @[4,5]
drop(2,"123456") == "3456"
```

## [spliatAt](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L417) (Int -> [a] -> ([a],[a]))
```Nim
    splitAt 3 @[1,2,3,4,5] == (@[1,2,3],@[4,5])
    splitAt 3 @[1,2,3] == (@[1,2,3],@[])
```

## [takeWhile](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L392) ((a -> bool) -> [a] -> [a])
```Nim
    proc g(a:int):bool=return a<4
    proc f(a:int):bool=return a==3
    proc h(a:char):bool = return a < 'e'
    takeWhile(g,@[1,2,3,4,5]) == @[1,2,3]
    takeWhile(f,@[3,3,3,4]) == @[3,3,3]
    takeWhile(h,@['a','b','c','d','e','g','h']) == @['a','b','c','d']
```

## [dropWhile](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L417) ((a -> bool) -> [a] -> [a])
```Nim
    proc g(a:int):bool=return a<3
    proc f(a:int):bool=return a<9
    takeWhile(g,@[1,2,3,4,5]) == @[1,2,3]
    takeWhile(f,@[3,3,3,4]) == @[3,3,3]
```