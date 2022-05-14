import  options,strutils,sequtils,deques,strutils,sugar,algorithm,tables

## 
## 
## *******************
## Data.NimList
## *******************
## 
## =====================
## Supported functions
## =====================
## * **Basic Functions**
##   * ++
##   * head
##   * last
##   * tail
##   * init
##   * uncons
##   * singleton
##   * null
## * **List transformers**
##   * intersperse
##   * intercalate
##   * transepose
##   * subsequences
##   * permutations
## * **Building list**
##   * scanl
##   * scanl1
##   * scanr
##   * scanr1
## * **Infinite list**
##   * iterate
##   * repeat
##   * replicate
##   * cycle
## * **Sublists**
##   * take
##   * drop
##   * splitAt
##   * takeWhile
##   * dropWhile
##   * span
##   * breakList
##   * stripPrefix
##   * inits
##   * tails
## * **Predicates**
##   * isPrefixOf
##   * isSuffixOf
##   * isInfixOf
## * **Searching lists**
##   * elem
##   * notElem
##   * lookup
## * **Searching with a predicate**
##   * find
##   * partition

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
    import  sugar
    doAssert scanl((a,b:int)->int=>a+b,0,@[1,2,3,4]) == @[0,1,3,6,10]
    doAssert scanl((a,b:int)->int=>a-b,100,@[1,2,3,4]) == @[100,99,97,94,90]
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

proc scanl*(f:proc(a,b:string):string{. closure .},start:string,xs:seq[string]):seq[string]=
  runnableExamples:
    import sugar
    doAssert scanl((a,b:string)->string=>b&a,"foo",@["12","34","56"])  == @["foo", "12foo", "3412foo", "563412foo"]
  var 
    que = xs.toDeque()
    res = initDeque[string]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popFirst()
      t = f(res.peekLast,s)
    res.addLast(t)
  return res.toSeq

proc scanl*(f:proc(a:string,b:char):string{. closure .},start:string,xs:seq[char]):seq[string]=
  runnableExamples:
    import sugar
    doAssert scanl((a:string,b:char)->string=>b&a,"foo",@['a', 'b', 'c', 'd']) == @["foo", "afoo", "bafoo", "cbafoo", "dcbafoo"]
  var 
    que = xs.toDeque()
    res = initDeque[string]()
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
  runnableExamples:
    import  sugar
    doAssert scanr((a,b:int)->int=>a-b,100,@[1,2,3,4]) == @[98,-97,99,-96,100]
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

proc scanr*(f:proc(a,b:string):string {. closure .},start:string,xs:seq[string]):seq[string]=
  var 
    que = xs.toDeque()
    res = initDeque[string]()
  res.addLast(start)
  while(que.len>0):
    var 
      s = que.popLast()
      t = f(s,res.peekFirst)
    res.addFirst(t)
  return res.toSeq

proc scanr*(f:proc(a:char,b:string):string {. closure .},start:string,xs:seq[char]):seq[string]=
  runnableExamples:
    import  sugar
    doAssert scanr((a:char,b:string)->string=>a&b,"foo" , @['a', 'b', 'c', 'd']) == @["abcdfoo", "bcdfoo", "cdfoo", "dfoo", "foo"]
  var 
    que = xs.toDeque()
    res = initDeque[string]()
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

iterator iterate*[S,U](f:proc(a:S):U,x:S):U=
  var
    a:seq[S] = @[x]
    counter:int = 0
  while true:
    if(counter==0):yield a[0]
    else:
      a.add(f(a.last))
      yield a[counter]
    inc counter

iterator repeatList*[T](x:seq[T]):seq[T]=
  while true : yield x

iterator repeatList*[T](x:T):T=
  while true : yield x

proc replicate*[T](a:int,b:T):seq[T]=
  for i in 0..<a:result.add(b)

proc replicate*[T](a:int,b:seq[T]):seq[seq[T]]=
  for i in 0..<a:result.add(b)

iterator cycle*[T](x:seq[T]):T=
  var counter:int = 0
  while true:
    if(counter==x.len):counter -= x.len
    yield x[counter]
    inc counter

iterator cycle*(x:string):char=
  var counter:int = 0
  while true:
    if(counter==x.len):counter -= x.len
    yield x[counter]
    inc counter


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
    import sugar
    proc g(a:int):bool=return a<4
    doAssert takeWhile(g,@[1,2,3,4,5]) == @[1,2,3]
    doAssert takeWhile((x:int)->bool=>x==3,@[3,3,3,4]) == @[3,3,3]
    doAssert takeWhile((x:string) -> bool => x.len<3,@["12","123","12345"]) == @["12"]
  for i in xs:
    if(not(f(i))):break
    if(f(i)):result.add(i)

proc takeWhile*[T](f:proc(a:T):bool{. closure .},xs:string):string =
  for i in xs:
    if(not(f(i))):break
    if(f(i)):result.add(i)

proc dropWhile*[T](f:proc(a:T):bool{. closure .},xs:seq[T]):seq[T] =
  runnableExamples:
    import sugar
    doAssert dropWhile((x:int) -> bool => x<3,@[1,2,3,4,5,1,2,3]) == @[3,4,5,1,2,3]
    doAssert dropWhile((x:int) -> bool => x<9,@[1,2,3]) == @[]
    doAssert dropWhile((x:int) -> bool => x<0,@[1,2,3]) == @[1,2,3]
  for ix,i in xs:
    if(not(f(i))):
      return xs[ix..xs.len-1]
  let emptySeq:seq[T] = @[]
  return emptySeq

proc dropWhile*[T](f:proc(a:T):bool{. closure .},xs:string):string =
  for ix,i in xs:
    if(not(f(i))):
      return xs[ix..xs.len-1]
  let emptyString:string = ""
  return emptyString

proc span*[T](f:proc(a:T):bool,xs:seq[T]):(seq[T],seq[T]) =
  runnableExamples:
    import sugar
    doAssert span((x:int)->bool=>x<3 ,@[1,2,3,4,1,2,3,4]) == (@[1, 2], @[3, 4, 1, 2, 3, 4])
    doAssert span((x:int)->bool=>x<9 ,@[1,2,3]) == (@[1, 2, 3], @[])
    doAssert span((x:int)->bool=>x<0 ,@[1,2,3]) == (@[], @[1, 2, 3])
  return(takeWhile(f,xs),dropWhile(f,xs))
    
proc span*[T](f:proc(a:T):bool,xs:string):(string,string) =
  runnableExamples:
    import sugar
    doAssert  span((x:char)->bool=>x<'d' ,"abcdefg") == ("abc", "defg")
  return((takeWhile(f,xs),dropWhile(f,xs))  )

proc breakList*[T](f:proc(a:T):bool,xs:seq[T]):(seq[T],seq[T]) =
  runnableExamples:
    import sugar
    doAssert breakList((x:int)->bool=>x<3 ,@[1,2,3,4,1,2,3,4]) == (@[], @[1, 2, 3, 4, 1, 2, 3, 4])
    doAssert breakList((x:int)->bool=>x<0 ,@[1,2,3]) == (@[1, 2, 3], @[])
  return span(proc(x:T):bool=
    if(f(x)):false
    else:true,xs)

proc breakList*[T](f:proc(a:T):bool,xs:string):(string,string) =
  runnableExamples:
    import sugar
    doAssert breakList((x:char)->bool=>x>'d' ,"abcdefg") == ("abcd", "efg")
  return span(proc(x:T):bool=
    if(f(x)):false
    else:true,xs)

proc stripPrefix*[T](s:seq[T],xs:seq[T]):Option[seq[T]] =
  runnableExamples:
    import options
    doAssert stripPrefix(@[1,2],@[1,2,3,4,5]) == some(@[3,4,5])
    doAssert stripPrefix(@[1,2],@[3,4,5]) == none(seq[int])
  if(xs[0..<s.len]==s):return some(xs[s.len..<xs.len])
  else:return none(seq[T])

proc stripPrefix*(s:string,xs:string):Option[string] =
  runnableExamples:
    import options
    doAssert stripPrefix("foo","foobar") == some("bar")
    doAssert stripPrefix("foo","barfoo") == none(string)
  if(xs[0..<s.len]==s):return some(xs[s.len..<xs.len])
  else:return none(string)

proc inits*[T](x:seq[T]):seq[seq[T]] =
  runnableExamples:
    doAssert inits(@[1,2,3]) == @[@[], @[1], @[1, 2], @[1, 2, 3]]
  result = newSeq[seq[T]]()
  let first:seq[T] = @[]
  result.add(first)
  for i in 0..<x.len:
    result.add(x[0..i])

proc inits*(x:string):seq[string] =
  runnableExamples:
    doAssert inits("abc") == @["","a","ab","abc"]
  result = newSeq[string]()
  let first:string= ""
  result.add(first)
  for i in 0..<x.len:
    result.add(x[0..i])

proc tails*[T](x:seq[T]):seq[seq[T]] =
  runnableExamples:
    doAssert tails(@[1,2,3]) == @[@[1, 2, 3], @[2, 3], @[3], @[]]
  result = newSeq[seq[T]]()
  for i in 0..<x.len:
    result.add(x[i..x.len-1])
  let final:seq[T] = @[]
  result.add(final)

proc tails*(x:string):seq[string] =
  runnableExamples:
    doAssert tails("abc") == @["abc","bc","c",""]
  result = newSeq[string]()
  for i in 0..<x.len:
    result.add(x[i..x.len-1])
  let final:string = ""
  result.add(final)

#TODO implementation of group function

proc isPrefixOf*[T](x:seq[T],y:seq[T]):bool =
  runnableExamples:
    doAssert isPrefixOf(@[1,2],@[1,2,3,4]) == true
    doAssert  isPrefixOf(@[2],@[1,2,3,4]) == false
  if(x.len>y.len):return false
  return take(x.len,y) == x

proc isPrefixOf*(x:string,y:string):bool =
  runnableExamples:
    doAssert isPrefixOf("Hello","Hello World!") == true
    doAssert  isPrefixOf("Hello","Wello Horld!") == false
  if(x.len>y.len):return false
  return take(x.len,y) == x

proc isSuffixOf*[T](x:seq[T],y:seq[T]):bool =
  runnableExamples:
    doAssert isSuffixOf(@[1,2,3],@[1,2,3,4,5,1,2,3]) == true
  if(x.len>y.len):return false
  return drop(y.len-x.len,y) == x

proc isSuffixOf*(x:string,y:string):bool =
  runnableExamples:
    doAssert isSuffixOf("ld!","Hello World!") == true
    doAssert isSuffixOf("World","Hello World!") == false
  if(x.len>y.len):return false
  return drop(y.len-x.len,y) == x 

proc isInfixOf*(x,y:string):bool=
  ## Whether y includes x
  ## That in other words, y is a longer number of characters than x.
  ## Note that the order of the arguments is reversed from contains in strutils
  runnableExamples:
    doAssert isInfixOf("Haskell", "I really like Haskell.") == true
    doAssert isInfixOf("lal", "I really like Haskell.") == false
  return contains(y,x)

proc isInfixOf*[T](x,y:seq[T]):bool=
  runnableExamples:
    doAssert isInfixOf(@[1,2,3],@[4,5,6,1,2,3,4,5]) == true
    doAssert isInfixOf(@[1,2],@[4,5,6,1,3,2,4,5]) == false
  var
    y = y.mapIt($it).join" "
    x = x.mapIt($it).join" "
  return contains(y,x)

proc elem*[T](x:T,y:seq[T]):bool=
  var
    arr = y.sorted()
    left = -1
    right = y.len
  while(left+1 < right):
    var mid = (left + right) div 2
    if(arr[mid]>=x):right=mid
    else:left=mid
  if(right>=arr.len):return false
  arr[right]==x

proc elem*(x:char,y:string):bool=
  var
    arr = y.sorted()
    left = -1
    right = y.len
  while(left+1 < right):
    var mid = (left + right) div 2
    if(arr[mid]>=x):right=mid
    else:left=mid
  if(right>=arr.len):return false
  arr[right]==x

proc notElem*[T](x:T,y:seq[T]):bool=
  var 
    arr = y.sorted()
    left = -1
    right = y.len
  while(left+1 < right):
    var mid = (left + right) div 2
    if(arr[mid]>=x):right=mid
    else:left=mid
  if(right>=arr.len):return true
  arr[right]!=x

proc notElem*(x:char,y:string):bool=
  var 
    arr = y.sorted()
    left = -1
    right = y.len
  while(left+1 < right):
    var mid = (left + right) div 2
    if(arr[mid]>=x):right=mid
    else:left=mid
  if(right>=arr.len):return true
  return arr[right]!=x

proc lookup*[S, T](x:T, y:seq[(T,S)]):Option[S] =
  var
    a = y.mapIt(it[0]).sorted()
    table = y.toOrderedTable()
    left = -1
    right = a.len
  while(left+1<right):
    var mid = (right + left) div 2
    if(a[mid] >= x):right = mid
    else:left = mid
  if(right>=a.len):return none(S)
  return some(table[a[right]])


proc findList*[T,S](f:proc(x:S):bool{. closure .},x:seq[T]):Option[T]=
  runnableExamples:
    import  sugar,options,sequtils
    doAssert findList((x:int) -> bool => x>6,(1..7).toSeq) == some(7)
    doAssert findList((x:int) -> bool => x>12,(1..7).toSeq) == none(int)
  let res:seq[T] = filter(x,f)
  if(res.null):return none(T)
  else:return some(res[0])

proc partition*[S,T](f:proc(x:S):bool{. closure .}, x:seq[T]):(seq[T],seq[T])=
  runnableExamples:
    import  sugar,sequtils
    doAssert partition((x:int)->bool=>x mod 2==0 ,(0..10).toSeq) == (@[0, 2, 4, 6, 8, 10], @[1, 3, 5, 7, 9])
  var
    resFst:seq[T] = filter(x,f)
    resSnd:seq[T] = filter(x,
    proc(y:S):bool=
      if(f(y)):false 
      else:true
    )
  return (resFst,resSnd)

proc `!!`*[T](x:seq[T],i:int):T=
  return x[i]

proc `!!`*(x:string,i:int):char=
  return x[i]

proc elemIndices*[T](x:T,xs:seq[T]):seq[int]=
  for ix,i in xs:
    if(i==x):result.add(ix)

proc elemIndices*(x:char,xs:string):seq[int]=
  runnableExamples:
    doAssert elemIndices('o',"Hello World") == @[4,7]
  for ix,i in xs:
    if(i==x):result.add(ix)
