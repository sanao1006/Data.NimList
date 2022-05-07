

import  options,strutils,sequtils



proc `++`*[T](x:seq[T],y:seq[T]):seq[T] = 
  ## Append two lists
  runnableExamples:
    doAssert @[1,2,3] ++ @[4,5,6] == @[1,2,3,4,5,6]
    doAssert @["abc","def"] ++ @["ghi","jkl"] == @["abc","def","ghi","jkl"]
    doAssert @[1.1,2.2,3.3] ++ @[4.4,5.5,6.6] == @[1.1,2.2,3.3,4.4,5.5,6.6]
  return x & y

proc `++`*(x:string,y:string):string = 
  ## Append two lists
  runnableExamples:
    doAssert "abc" ++ "def" == "abcdef"
  return x & y
  
proc head*[T](x:seq[T]):T =
  ## Return the first element of a list
  runnableExamples:
    doAssert @[1,2,3,4].head == 1
    doAssert @["abc","def","ghi","jkl"].head == "abc"
    doAssert @[1.1,2.2,3.3,4.4].head == 1.1
  return x[0]

proc head*(x:string):char =
  ## Return the first element of a list
  runnableExamples:
    doAssert "abcdefg".head == 'a'
  return x[0]

proc last*[T](x:seq[T]):T =
  ## Return the last element of a list
  runnableExamples:
    doAssert @[1,2,3,4].last == 4
    doAssert @["abc","def","ghi","jkl"].last == "jkl"
    doAssert @[1.1,2.2,3.3,4.4].last == 4.4
  return x[x.len - 1]

proc last*(x:string):char =
  ## Return the last element of a list
  runnableExamples:
    doAssert "abcdefg".last == 'g'
  return x[x.len - 1]

proc tail*[T](x:seq[T]):seq[T] =
  ## Return all elements of a list except the first
  runnableExamples:
    doAssert @[1,2,3].tail == @[2,3]
    doAssert @["abc","def","ghi"].tail == @["def","ghi"]
    doAssert @[1.1,2.2,3.3].tail == @[2.2,3.3]
  return x[1 ..< x.len]

proc tail*(x:string):string =
  ## Return all elements of a list except the first
  runnableExamples:
    doAssert "abcdefg".tail == "bcdefg"
  return x[1 ..< x.len]

proc init*[T](x:seq[T]):seq[T] =
  ## Return all elements of a list except the last
  runnableExamples:
    doAssert @[1,2,3].init == @[1,2]
    doAssert @["abc","def","ghi"].init == @["abc","def"]
    doAssert @[1.1,2.2,3.3].init == @[1.1,2.2]
  return x[0 ..< x.len - 1]

proc init*(x:string):string =
  ## Return all elements of a list except the last
  runnableExamples:
    doAssert "abcdefg".init == "abcdef"
  return x[0 ..< x.len - 1]

proc `null`*[T](x:seq[T]):bool =
  runnableExamples:
    var a: seq[int] = @[]
    doAssert not(@[1,2,3].null)
    doAssert a.null
    doAssert "".null
  return x.len == 0

proc `null`*(x:string):bool =
  runnableExamples:
    var a: seq[int] = @[]
    doAssert not(@[1,2,3].null)
    doAssert a.null
    doAssert "".null
  return x.len == 0

proc uncons*[T](x:seq[T]):Option[(T,seq[T])] =
  ## Return the first element of a list and the rest
  runnableExamples:
    import options
    doAssert uncons(@[1,2,3]) == some((1,@[2,3]))
    doAssert uncons(@[1.1,2.2,3.3]) == some((1.1,@[2.2,3.3]))
  if(x.null):return none((T,seq[T])) else:return some((x[0],x[1 ..< x.len]))

proc uncons*(x:string):Option[(char,string)] =
  ## Return the first element of a list and the rest
  runnableExamples:
    import options
    doAssert uncons("abcde") == some(('a',"bcde"))
  if(x.null):return none((char,string)) else:return some((x[0],x[1 ..< x.len]))

proc singleton*[T](x:T):seq[T] =
  runnableExamples:
    doAssert singleton(3) == @[3]
    doAssert singleton("abc") == @["abc"]
    doAssert singleton(1.1) == @[1.1]
    doAssert singleton('c') == @['c']
  result.add(x)


proc intersperse*(s:string,x:char):string=
  runnableExamples:
    doAssert "1234".intersperse(',') == "1,2,3,4"
    doAssert "ABCD".intersperse(' ') == "A B C D"
  var res = newSeq[string]()
  for i in 0..<s.len-1:
    res.add(s[i] & x)
  res.add($s.last)
  return res.join()

import  sequtils
proc transpose*[T](arr:seq[seq[T]]):seq[seq[T]] = 
  runnableExamples:
    import sequtils
    doAssert @[@[1,2,3],@[4,5,6]].transpose == @[@[1,4],@[2,5],@[3,6]] 
    doAssert @[@[1.1,2.2,3.3],@[4.4,5.5,6.6]].transpose == @[@[1.1,4.4],@[2.2,5.5],@[3.3,6.6]]
    doAssert @[@['a','b','c'],@['d','e','f']].transpose == @[@['a','d'],@['b','e'],@['c','f']]
  var
    hight=arr.len
    width=arr.mapIt(it.len)[0]
  result=newSeq[seq[T]]()
  for i in 0..<width:
    var tmpArr=newSeq[T]()
    for j in 0..<hight:
      tmpArr.add(arr[j][i])
    result.add(tmpArr)
proc transpose*(arr:seq[string]):seq[string] = 
  runnableExamples:
    import sequtils
    doAssert @["123","456"].transpose == @["14","25","36"]
    doAssert @["abc","def"].transpose == @["ad","be","cf"]
  var
    hight=arr.len
    width=arr.mapIt(it.len)[0]
  var res=newSeq[seq[char]]()
  for i in 0..<width:
    var tmpArr=newSeq[char]()
    for j in 0..<hight:
      tmpArr.add(arr[j][i])
    res.add(tmpArr)
  return res.mapIt(it.join())

