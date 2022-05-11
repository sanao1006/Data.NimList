# Data.NimList
[![.github/workflows/main.yml](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml/badge.svg)](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml)  

# Whats' this?
### This is a Nim implementation of Haskell's Data.List library 　
### I avoid using recursion too often, and I actively use the standard library. Therefore, some functions have unique implementations.  
### Please point out any mistakes!
※Not completed(In progress)  
Currently, the links to the code for each function are misaligned
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
  
# Building lists

## [scanl](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L259) ((b -> a -> b) -> b -> [a] -> [b])
```Nim
proc f(a, b:int):int = a + b
scanl(f,0,@[1,2,3,4]) == @[0,1,3,6,10]
```

## [scanr](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L310) ((a -> b -> b) -> b -> [a] -> [b])
```Nim
proc f(a, b:int): int = a - b
scanr(f, 100 , @[1..4]) == @[98,-97,99,-96,100]
```

# Infinite list
## [iterate](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L358) (Int ->(a -> a) -> a -> [a])
Since Nim, strict evaluation, cannot express an infinite list, the number of items to be evaluated is determined in advance(By using argument "number").
```Nim
proc f(a:int):int == a + 3
iterate(10, f, 42) == @[42,45,48,51,54,57,60,63,66,69]

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
splitAt(3,@[1,2,3,4,5]) == (@[1,2,3],@[4,5])
splitAt(3,@[1,2,3]) == (@[1,2,3],@[])
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
proc f(a:int):bool=return a<4
dropWhile(g,@[1,2,3,4,5]) == @[4,5]
dropWhile(f,@[3,3,3,4]) == @[]
```

## [span](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L432) ((a -> bool) -> [a] -> ([a],[a]))
```Nim
proc g(a:int):bool=return a<3
span(g,[1,2,3,4,1,2,3,4]) == (@[1,2],@[3,4,1,2,3,4])
proc f(a:int):bool=return a<9
span(f,[1,2,3]) == (@[1,2,3],@[])
```

## [breakList](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L438) ((a -> bool) -> [a] -> ([a],[a]))
"break" is a reserved word, so I named it "breakList"
```Nim
proc g(a:int):bool=return a>3
breakList(g,[1,2,3,4,1,2,3,4] == (@[1,2,3],@[4,1,2,3,4])
proc f(a:int):bool=return a>9
breakList(f, @[1,2,3]) == (@[1,2,3],@[])
```

## [stripPrefix](https://github.com/sanao1006/Data.NimList/blob/59c4d6ce044e3083ce14e8306200169ee00ce71c/src/nimList.nim#L448) ([a] -> [a] -> Option[a])
```Nim
stripPrefix("foo","foobar") == some("bar")
stripPrefix("foo","barfoo") == none(string)
```
