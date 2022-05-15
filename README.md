# Data.NimList
[![.github/workflows/main.yml](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml/badge.svg)](https://github.com/sanao1006/Data.NimList/actions/workflows/main.yml)  

# Whats' this?
### This is a Nim implementation of Haskell's Data.List library 　※Not completed(In progress)  
**[Document](https://sanao1006.github.io/Data.NimList/)**    
* * *
* I avoid using recursion too often, and I actively use a standard library. Therefore, some functions have unique implementations.   
* Functions that exist in a standard library are omitted.  
Please point out any mistakes!   

# Supported functions
* __Basic Functions__
  * ++
  * head
  * last
  * tail
  * init
  * uncons
  * singleton
  * null
* __List transformers__
  * intersperse
  * intercalate
  * transepose
  * subsequences
  * permutations
* __Building list__
  * scanl
  * scanl1
  * scanr
  * scanr1
* __(In)finite list__
  * iterate
  * repeat
  * replicate
  * cycle
* __Sublists__
  * take
  * drop
  * splitAt
  * takeWhile
  * dropWhile
  * span
  * breakList
  * stripPrefix
  * inits
  * tails
* __Predicates__
  * isPrefixOf
  * isSuffixOf
  * isInfixOf
* __Searching lists__
   * elem
   * notElem
   * lookup
 * __Searching with a predicate__
   * find
   * partition
 * __Index lists__
   * (!!)
   * elemIndices
