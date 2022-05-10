

import  options,strutils,sequtils,deques



proc `++`*[T](x:seq[T],y:seq[T]):seq[T] = 
  ## Append two lists
  runnableExamples:
    doAssert @[1,2,3] ++ @[4,5,6] == @[1,2,3,4,5,6]
    doAssert @["abc","def"] ++ @["ghi","jkl"] == @["abc","def","ghi","jkl"]
    doAssert @[1.1,2.2,3.3] ++ @[4.4,5.5,6.6] == @[1.1,2.2,3.3,4.4,5.5,6.6]
  return x & y

proc `++`*(x:string,y:string):string = 
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


proc intersperse*(x:char,s:string):string=
  runnableExamples:
    doAssert  intersperse(',', "1234") == "1,2,3,4"
    doAssert intersperse(' ', "ABCD") == "A B C D"
  var res = newSeq[string]()
  for i in 0..<s.len-1:
    res.add(s[i] & x)
  res.add($s.last)
  return res.join()

proc intersperse*[T](s:T,x:seq[T]):seq[T] =
  runnableExamples:
    doAssert intersperse(1.1,@[2.2,3.3,4.4,5.5]) == @[2.2,1.1,3.3,1.1,4.4,1.1,5.5]
    doAssert intersperse(1,@[2,3,4,5]) == @[2,1,3,1,4,1,5]
  result = newSeq[T]()
  result.add(x[0])
  for i in x.tail:
    result.add(s)
    result.add(i)

proc intersperse[T](s:seq[T],x:seq[seq[T]]):seq[seq[T]] =
  result = x.mapIt(concat(it,s))

proc intercalate[T](x:seq[T],y:seq[seq[T]]):seq[T] =
  result = intersperse(x,y).foldl(concat(a,b))

proc intercalate(x:string,y:seq[string]):string =
  result = intersperse(x,y).join ""

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

proc permutations*[T](a: seq[T], n: int = a.len): seq[seq[T]] =
  runnableExamples:
    doAssert @[1,2,3].permutations == @[
     @[1, 2, 3], @[1, 3, 2],
     @[2, 1, 3],@[2, 3, 1],
     @[3, 1, 2], @[3, 2, 1]
     ]
  proc perm[T](a: openArray[T], n: int, use: var seq[bool]): seq[seq[T]] =
    result = newSeq[seq[T]]()
    if n <= 0: return
    for i in 0 .. a.high:
      if not use[i]:
        if n == 1:result.add(@[a[i]])
        else:
          use[i] = true
          for j in perm(a, n - 1, use):result.add(a[i] & j)
          use[i] = false
  var use = newSeq[bool](a.len)
  perm(a, n, use)

proc permutations*(a:string,n:int=a.len):seq[seq[char]] =
  runnableExamples:
    doAssert "aiu".permutations == @[
      @['a', 'i', 'u'], @['a', 'u', 'i'], 
      @['i', 'a', 'u'], @['i', 'u', 'a'], 
      @['u', 'a', 'i'], @['u', 'i', 'a']
    ]
  proc perm[T](a: openArray[T], n: int, use: var seq[bool]): seq[seq[T]] =
    result = newSeq[seq[T]]()
    if n <= 0: return
    for i in 0 .. a.high:
      if not use[i]:
        if n == 1:result.add(@[a[i]])
        else:
          use[i] = true
          for j in perm(a, n - 1, use):result.add(a[i] & j)
          use[i] = false
  var use = newSeq[bool](a.len)
  perm(a, n, use)

proc concatMap*[T](xs:seq[seq[T]],f:proc,x:T):seq[T] =
  runnableExamples:
    func plus(a,b:int):int=return a+b
    func minus(a,b:int):int=return a-b
    func product(a,b:float):float=return a*b
    func divide(a,b:int):int = a div b
    func floatDiv(a,b:float):float = a/b
    doAssert @[@[1,2,3],@[4,5,6]].concatMap(plus,1) == @[2,3,4,5,6,7]
    doAssert @[@[1,2,3],@[4,5,6]].concatMap(minus,1) == @[0,1,2,3,4,5]
    doAssert @[@[1,2,3],@[4,5,6]].concatMap(divide,2) == @[0,1,1,2,2,3]
    doAssert @[@[1.1,2.2,3.3],@[4.4,5.5,10.0]].concatMap(product,2.0) == @[2.2,4.4,6.6,8.8,11.0,20.0]
    doAssert @[@[1.0,2.0,3.0],@[4.0,5.0,6.0]].concatMap(floatDiv,2) == @[0.5,1.0,1.5,2.0,2.5,3.0]
  return xs.mapIt(it.mapIt(it.f(x))).concat

proc subsequences*(s:string):seq[string]=
  runnableExamples:
    doAssert "123".subsequences == @[" ", "3", "2", "23", "1", "13", "12", "123"]
  iterator product[T](s: openArray[T], repeat: Positive): seq[T] =
    var counters = newSeq[int](repeat)
    block outer:
      while true:
        var result = newSeq[T](repeat)
        for i, cnt in counters:
          result[i] = s[cnt]
        yield result
        var i = repeat - 1
        while true:
          inc counters[i]
          if counters[i] == s.len:
            counters[i] = 0
            dec i
          else: break
          if i < 0:break outer
  result = newSeq[string]()
  result.add(" ")
  for i in product(@[0,1],s.len):
    var tmp = newSeq[char]()
    for jx,j in i:
      if(j==1):tmp.add(s[jx])
    if(tmp.len==0):continue
    result.add(
      tmp
      .mapIt($it)
      .foldl(a & b)
    )

proc scanl*(f:proc(a,b:int):int{. closure .},start:int,xs:seq[int]):seq[int]=
  runnableExamples:
    proc f(a,b:int):int=a+b
    doAssert scanl(f,0,@[1,2,3,4]) == @[0,1,3,6,10]
  var 
    que = xs.toDeque()
    res = initDeque[int]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popFirst()
      t = f(res.peekLast,s)
    res.addLast(t)
  return res.toSeq

proc scanl*(f:proc(a,b:float):float{. closure .},start:float,xs:seq[float]):seq[float]=
  var 
    que = xs.toDeque()
    res = initDeque[float]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popFirst()
      t = f(res.peekLast,s)
    res.addLast(t)
  return res.toSeq

proc scanl1*(f:proc(a,b:int):int{. closure .},xs:seq[int]):seq[int]=
  var 
    que = xs.toDeque()
    res = initDeque[int]()
  res.addLast(1)
  while(que.len>0):
    var 
      s = que.popFirst()
      t = f(res.peekLast,s)
    res.addLast(t)
  return res.toSeq

proc scanl1*(f:proc(a,b:float):float{. closure .},xs:seq[float]):seq[float]=
  var 
    que = xs.toDeque()
    res = initDeque[float]()
  res.addLast(1.0)
  while(que.len>0):
    var 
      s = que.popFirst()
      t = f(res.peekLast,s)
    res.addLast(t)
  return res.toSeq

proc scanr*(f:proc(a,b:int):int {. closure .},start:int,xs:seq[int]):seq[int]=
  var 
    que = xs.toDeque()
    res = initDeque[int]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popLast()
      t = f(s,res.peekFirst)
    res.addFirst(t)
  return res.toSeq

proc scanr*(f:proc(a,b:float):float {. closure .},start:float,xs:seq[float]):seq[float]=
  var 
    que = xs.toDeque()
    res = initDeque[float]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popLast()
      t = f(s,res.peekFirst)
    res.addFirst(t)
  return res.toSeq

proc scanr1*(f:proc(a,b:int):int {. closure .},xs:seq[int]):seq[int]=
  var 
    que = xs.toDeque()
    res = initDeque[int]()
  res.addLast(1)
  while(que.len>0):
    var 
      s = que.popLast()
      t = f(s,res.peekFirst)
    res.addFirst(t)
  return res.toSeq

proc scanr1*(f:proc(a,b:float):float {. closure .},start:float,xs:seq[float]):seq[float]=
  var 
    que = xs.toDeque()
    res = initDeque[float]()
  res.addLast(1.0)
  while(que.len>0):
    var 
      s = que.popLast()
      t = f(s,res.peekFirst)
    res.addFirst(t)
  return res.toSeq

proc iterate*[T](number:int,f:proc(b:T):T{. closure .},start:T):seq[T]=
  var res = initDeque[T]()
  res.addLast(start)
  while(not(res.len ==  number)):
    var 
      s = res.peekLast()
      t = f(s)
    res.addLast(t)
  return res.toSeq

proc take*[T](n:int,xs:seq[T]):seq[T] = 
  runnableExamples:
    doAssert take(3,@[1,2,3,4]) == @[1,2,3]
    doAssert take(3,@[1.1,2.2,3.3,4.4]) == @[1.1,2.2,3.3]
    doAssert take(3,@["123","456","789","101112"]) == @["123","456","789"]
  return xs[0..n-1]
proc take*(n:int,xs:string):string = return xs[0..n-1]

proc drop*(n:int,xs:string):string =
  runnableExamples:
    doAssert drop(2,"123456") == "3456"
    doAssert drop(3,"123") == ""
  return xs[n..xs.len-1]

proc drop*[T](n:int,xs:seq[T]):seq[T] =
  runnableExamples:
    doAssert drop(3,@[1,2,3,4,5]) == @[4,5]
    doAssert drop(3,@[1,2,3]) == @[]
  return xs[n..xs.len-1]

proc splitAt*[T](n:Positive,xs:seq[T]):(seq[T],seq[T])=
  runnableExamples:
    doAssert splitAt(3,@[1,2,3,4,5]) == (@[1,2,3],@[4,5])
  return (take(n,xs),drop(n,xs))

proc splitAt*(n:Positive,xs:string):(string,string)=
  runnableExamples:
    doAssert splitAt(3,"12345678") == ("123","45678")
    doAssert splitAt(3,"123") == ("123","")
  return(take(n,xs),drop(n,xs))

proc takeWhile*[T](f:proc(a:T):bool{. closure .},xs:seq[T]):seq[T] =
  runnableExamples:
    proc g(a:int):bool=return a<4
    proc f(a:int):bool=return a==3
    proc h(a:char):bool = return a < 'e'
    doAssert takeWhile(g,@[1,2,3,4,5]) == @[1,2,3]
    doAssert takeWhile(f,@[3,3,3,4]) == @[3,3,3]
    doAssert takeWhile(h,@['a','b','c','d','e','g','h']) == @['a','b','c','d']
  for i in xs:
    if(not(f(i))):break
    if(f(i)):result.add(i)

proc takeWhile*[T](f:proc(a:T):bool{. closure .},xs:string):string =
  for i in xs:
    if(not(f(i))):break
    if(f(i)):result.add(i)

proc dropWhile*[T](f:proc(a:T):bool{. closure .},xs:seq[T]):seq[T] =
  for ix,i in xs:
    if(not(f(i))):
      return xs[ix..xs.len-1]
      break
  let emptySeq:seq[T] = @[]
  return emptySeq

proc dropWhile*[T](f:proc(a:T):bool{. closure .},xs:string):string =
  for ix,i in xs:
    if(not(f(i))):
      return xs[ix..xs.len-1]
      break
  let emptyString:string = ""
  return emptyString

proc span[T](f:proc(a:T):bool,xs:seq[T]):(seq[T],seq[T]) =
  return(takeWhile(f,xs),dropWhile(f,xs))
    
proc span[T](f:proc(a:T):bool,xs:string):(string,string) =
  return((takeWhile(f,xs),dropWhile(f,xs))  )

proc breakList[T](f:proc(a:T):bool,xs:seq[T]):(seq[T],seq[T]) =
  return span(proc(x:T):bool=
    if(f(x)):false
    else:true,xs)

proc breakList[T](f:proc(a:T):bool,xs:string):(string,string) =
  return span(proc(x:T):bool=
    if(f(x)):false
    else:true,xs)

proc stripPrefix[T](s:seq[T],xs:seq[T]):Option[seq[T]] =
  if(xs[0..<s.len]==s):return some(xs[s.len..<xs.len])
  else:return none(seq[T])

proc stripPrefix(s:string,xs:string):Option[string] =
  if(xs[0..<s.len]==s):return some(xs[s.len..<xs.len])
  else:return none(string)
