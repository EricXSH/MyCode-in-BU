(*
Honor code comes here:

First Name:Shihao 
Last Name:Xing
BU ID:U66709138

I pledge that this program represents my own
program code and that I have coded on my own. I received
help from no one in designing and debugging my program.
I have read the course syllabus of CS 320 and have read the sections on Collaboration
and Academic Misconduct. I also understand that I may be asked to meet the instructor
or the TF for a follow up interview on Zoom. I may be asked to explain my solution in person and
may also ask you to solve a related problem.
*)

(*
Write a safe_zip_int function that takes two lists of integers and combines them into a list of pairs of ints
If the two input list are of unequal lengths, return None
your method must be tail recursive.

For example,
safe_zip_int [1;2;3;5] [6;7;8;9] = Some [(1,6);(2,7);(3,8);(5,9)]
safe_zip_int [1] [2;4;6;8] = None
safe_zip_int (between 0 1000000) (between 0 1000000) does not stack overflow

Note: The between function is from the previous programming assignment 1. 
You can use the between function from the previous assignment for testing purposes. 
*)


let  safe_zip_int (ls1: int list) (ls2: int list) : ((int * int) list) option = 
  let rec foo (l: (int*int) list) (x: int list) (y: int list) = 
    match (x,y) with
    | [],[] -> Some(l)
    | [], _::tail -> None
    | _::tail,[] -> None
    | h1::t1, h2::t2 -> foo (l @ [(h1, h2)]) t1 t2
  in match (ls1,ls2) with 
  | t1::w1, t2::w2 -> foo [(t1,t2)] w1 w2
  | [],[] -> Some([])
  | [], _::tail -> None
  | _::tail,[] -> None



(*
Write a function that produces the ith Pell number:
https://en.wikipedia.org/wiki/Pell_number
https://oeis.org/A000129
your function must be tail recursive, and needs to have the correct output up to integer overflow

pell 0 = 0
pell 1 = 1
pell 7 = 169
pell 1000000  does not stack overflow
*)


let  pell (i: int) : int =
  if (i == 0)
  then 0
  else if (i == 1)
  then 1
  else 
    let rec foo (first: int) (second: int)  (index : int) =
      if (index == i)
      then (2 * second + first)
      else foo second  (2 * second + first) (index + 1)
    in 
    foo 0 1 2




(* The nth Tetranacci number T(n) is mathematically defined as follows.
 *
 *      T(0) = 0
 *      T(1) = 1
 *      T(2) = 1
 *      T(3) = 2
 *      T(n) = T(n-1) + T(n-2) + T(n-3) + T(n-4)
 *
 * For more information, you may consult online sources.
 *
 *    https://en.wikipedia.org/wiki/Generalizations_of_Fibonacci_numbers
 *    https://mathworld.wolfram.com/TetranacciNumber.html
 *
 * Write a tail recursive function tetra that computes the nth Tetranacci
 * number efficiently. In particular, large inputs such as (tetra 1000000)
 * should neither cause stackoverflow nor timeout.
*)

let tetra (n : int) : int = 
  if (n == 0)
  then 0
  else if (n==1)
  then 1
  else if (n == 2)
  then 1
  else if (n == 3)
  then 2
  else 
    let rec foo (yi : int) (er:int) (san: int) (si:int) (index:int) =
      if (index == n)
      then (yi + er + san + si)
      else foo er san si (yi + er + san + si) (index + 1)
    in 
    foo 0 1 1 2 4

(*
infinite precision natural numbers can be represented as lists of ints between 0 and 9

Write a function that takes an integer and represents it with a list of integers between 0 and 9 where the head 
of the list holds the least signifigant digit and the very last element of the list represents the most significant digit.
If the input is negative return None. We provide you with some use cases:

For example:
toDec 1234 = Some [4; 3; 2; 1]
toDec 0 = Some []
toDec -1234 = None
*)

(* Hint use 
   mod 10
   / 10
*)

let  toDec (i : int) : int list option = 
  if ( i == 0)
  then Some ([])
  else if ( i < 0)
  then None
  else 
    let rec foo (x: int) (l : int list) = 
      if (x <= 9)
      then Some (l @ [x])
      else foo ( x / 10) ( l @ [x mod 10])
    in foo i []
(*
Write a function that sums 2 natrual numbers as represented by a list of integers between 0 and 9 where the head is the least signifigant digit.
Your function should be tail recursive

sum [4; 3; 2; 1] [1;0;1] = [5; 3; 3; 1]
sum [1] [9;9;9] = [0; 0; 0; 1]
sum [] [] = []
sum (nines 1000000) [1] does not stack overflow, when (nines 1000000) provides a list of 1000000 9s
*)

let sum (a : int list) (b : int list) : int list =  
  let rec foo (x: int list) (y:int list) (sum: int list) (addition : int) = 
    match (x,y) with
    | t1::w1, t2::w2 -> foo w1 w2 (sum @ [(t1 + t2 + addition) mod 10]) ((t1+t2 + addition) / 10)
    | [], [] -> if (addition == 0) then sum else (sum @ [addition])
    | [], h::tail -> foo [] tail (sum @ [(h + addition) mod 10]) ((h + addition) / 10)
    | h::tail, [] -> foo tail [] (sum @ [(h + addition) mod 10]) ((h + addition) / 10)
  in foo a b [] 0


(*
Write an infinite precision version of the pel function from before

pell2 0 = []
pell2 1 = [1]
pell2 7 = [9; 6; 1]
pell2 50 = [2; 2; 5; 3; 5; 1; 4; 2; 9; 2; 4; 6; 2; 5; 7; 6; 6; 8; 4]

Hint: You may want to use the sum function from above again inside 
pell2. 

*)

let pell2 (i: int) : int list = 
  if (i == 0)
  then []
  else if (i == 1)
  then [1]
  else 
    let rec foo (first: int list) (second: int list)  (index : int) =
      if (i == index)
      then sum (sum second second) first
      else foo second (sum (sum second second) first) (index + 1)
    in foo [] [1] 2
