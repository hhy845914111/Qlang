/ type casting
/ $

/ rule of evaluation
/ statement from right to left, assignment return value

/ datatypes:
/ h, i, j: short, int, long
/ e, f: float, double

/ comparison:
/ =: every, return a list
/ ~: all, including type

/ error: '

/ date:
/ 2000.01.01

/ timespan:
/ 12:00:00.000000000

12:00:00.000000003 - 12:00:00

/ list: (1; 2; "3") or 1 2 3

/ range: til 10

/ join: ,

/ extract: -2#til 10, notice this is extract til, not the one
/ extract 0: 0#til 10 to get type empty.
/ extract more will start again from the begining
-2#til

/ indexing: [3] or 3

/ function: {[x] a:x*x, b:y*y; a+b} // statements evaluated from left to right,
/ in each statement, evaluated from right to left.

/ adverb &&^&&:
/ / for a dyadic function, the first parameter as last, apply the list
/ to the right parameter iteratively.

0 +/ 1+til 100

(+/) 1+til 100 / use as monastic

/ each
/ each as a function
(count each) each ((1 2 3; 3 4); (100 200; 300 400 500))
each[each[count]] ((1 2 3; 3 4); (100 200; 300 400 500))

/ each both '

/ higher-order function
/ @ apply on top level, @[L;I;f]
/ @[L; I; g; v]: e.g. @[L; 0 1; +; 100 200]
/ . index at depthm, call function with multiple parameters .[L; I; f]  .[L; I; g; v]
L:(10 20 30; 40 50)
@[L;0 1]
.[L;0 1]



/ max |
/ min &

12 & 25
12 | 25

/ &&^&& operator
/ sum, sums
/ prd, prds
/ max, maxs
/ min, mins
/ avg
/ null
/ first, last
/ neg
/ wavg
/ left list weight, right value
/ xbar: dyadic, left: interval width (quantity not bar count), right: list of numeric values
/ not
/ sqrt, exp: e^x, log
/ xexp, xlog
/ div
/ mod
/ signum
/ reciprocal
/ parse
/ hsym: add : to a symbol, make it a file handle
/ hcount: tell how long is the file
/ hdel: delete the file handle
/ ungroup: make an column dict into an table, repeat the first column if needed
/ string: will automatically use each adverb when applied to char list
string `Life`the`Universe`and`Everything
string "hello, world"
/ floor
/ ceiling
/ abs
/ cross
/ raze: from complex to a list
/ ratios
/ in
/ read1: read any file into q as a list of bytes
/ `:/file/handle.bin 1: 0x23424: write binary to a file
/ save `:/path/q_entities, if ended with .txt, then will write a table to a text file, seperate with \t, if end with csv, seperate with, if xls, then Excel readable
/ load `:/path/q_entities
/ read0: read a text file, each column in a list
/ 0:
/   1. write as text, not like set, which write as binary e.g. `:/data/solong.txt 0: ("Life"; "The Universe"; "And Everything")
/   2. prepare table into text: e.g. "\t" 0: t, e.g. csv 0: t, e.g. `:/data/t.csv 0: csv 0: t
/   3.

/ deltas0: use 0 as the first result, not assume the initial value to be 0
/ differ where change， the change is before the idx
L:1 1 1 2 2 3 4 5 5 5 6 6
differ L
where differ L
((where differ L) _ L) ~ (where differ L) cut L

runs:(where differ L) cut L / store runs
ct:count each runs / store count of each run
runs where ct=max ct / find the runs of maximum length, notice we do not use select


/ &&^&& idiom
/ print: -3!obj to string
/ print this result during execution 0N!obj
/ ensure a q object to be list while not change already-list: (), x
/ seperate a list into several: 0 5 _ til 10
/ rearange array to matrix: 2 0N#til 10
/ append element to a list: L, :obj
/ to look at all tables: tables `.
L:()
L, 42
L
L,:42
L
/ get all variables: get `.


tmp: sums asc 500?100.0
tmp
2 xbar tmp



0 1 1 wavg 10 20 30

/ / over
0 +/ 1+til 100

f:{2*x+y}
100 f/ 1 2 3 4 5 6 7 8 9 10
100 f\ 1 2 3 4 5 6 7 8 9 10

/ \ scan
0 +\ 1+til 100


/ looping: running x times:
10 {x, sum -2#x}/ 1 1 / notice the looping or times does not reset the target
/ until finish. if not specified how much time to loop, then stop until converge

fib:{x,sum -2#x}
fib/[{1000>last x}; 1 1]


func:{[xn] xn-((xn*xn)-2)%2*xn}
20 func\ 35
func\[35]

buys: 2 1 4 3 5 4
sells: 2 4 3 2

/ each left: \: or each right /:
sums[sells] &\: sums[buys]
deltas sums[sells] &\: sums[buys]

/ each: each, monastic
count (1 2 3; 4 5)

deltas each deltas sums[sells] &\: sums[buys]

/ each previous ':
/ difference between each-previous and scan is that the former result is not kept and used for the next step
100 -': 100 99 101 102 101
100 -/: 100 99 101 102 101


/ dictionary: list ! list
d:`c1`c2!(10 20 30; 1.1 2.2 3.3)

/ unkeyed table
t:flip d
t:([] c1:10 20 30; c2:1.1, 1.2, 1.3)

select from t
select c1, val:2*c2 from t
update c3:10*c3 from t where c2 = `a

`c1`c2 xasc t
`c2 xdesc t

/ &&^&& random sample generator
10?20
10?20.0
10?`aapl`ibm

/ symbolic file handle
f_hdl:`:path/filename

/ save table
/ f_hdl set t

/ get table
/ get f_hdl

/ save as string
`:C:/q/test.txt 0: enlist "sfafasggasga"

/ read as string
read0 `:C:/q/test.txt

/ format table into csv
`:C:/q/test.csv 0: csv 0: t

/ read table and format csv strings into table
("SF"; enlist ",") 0: `:C:/q/test.csv

/ start server
/ \p 5566

/ connect to a server
/ h:hopen `:localhost:5566

/ execution on host
h "6*7"

/ execution function
h (`f, 6, 9)

/ close connection
hclose h

/ types
/ real: float
/ float: double
/ date, timestamp, timespan, minute, second, time

/ type    size chartype numtype
/ boolen        1     b        1
/ byte          1     x        4
/ short         2     h        5       0Nh
/ int           4     i        6       0N < -0W < 0W
/ long          8     j        7       0Nj
/ real          4     e        8       0ne
/ float         8     f        9       0n < -0w < 0w
/ char          1     c        10      ""
/ symbol              s        11      `                 `$"string"
/ timestamp(long) 8   p        12      0Np
/ month(int)    4     m        13      0Nm
/ date          4     d        14      0Nd               `year$dt, `mm$dt, `dd$dt
/ timespan      8     n        16      0Nn                e.g.: 25D12:34:56.123456000
/ minute        4     u        17      0Nu
/ second        4     v        18      0Nv
/ time(int)     4     t        19      0Nt                e.g.: 12:00:00.000, if not accurate enough, use timespan; `hh$tm, `mm$tm, `ss$tm, nanoseconds: (`long$12:34:56.123456789) mod 1000000000
/ enumeration                  20+
/ table                        98
/ dictionary                   99                         a pair of lists
/ function                    100
/ nil                         101                         L:(::, 1, 2) to prevent the list being a simple list
/ GUID:                G               0Ng    1?0Ng       e.g.: "G"$"61f35174-90bc-a48a-d88f-e15e4a377ec8"


/ list                                                    simple list positive, general list 0
/ specify list type: 1 2 3h
/ rule of type coersion: if types in a list can be upgraded to the same type, then do so, regardless of positions.
/ empty list: ()
/ singleton list: enlist 42 => ,42
/ index out of bound return null value
/ indexing with list returns result the same as the index: mapping
/ when combining list, if arguments are not of uniform type the result is a general list
/ merge with ^: right null be filled with those in left operand
/ find ?: list?item
/ disctince: return object as they appear, not sorted
/ where return true locations e.g. L[where L>20]:42
/ group return a table of each indices
/ _ remove
/ # take/repeat


{`ss$x} 2012.01.01D12:03:24.5415251613

12:34 01:02:03

L:10 20 30 40
L[(1 2 1; 1)]

m:((11; 12; 13; 14); (21; 22; 23; 24); (31; 32; 33; 34))

m[1;]~m[1]

mm:((1 2;3 4;5 6);(10 20;30 40;50 60))

/ operators:
/ way to call operator function
/ 1. dyadic:
/   a. 1 + 2
/   b. +[2;3]


/ neq: <>
/ cannot compare between symbol and char

/ +:, -:, *:, %:, &:, |:
/ can be used even if no existance, will use 0 of the type by default

`ad<`bc /comparison between symbols is strange

/ alias :: e.g. a::b
/ usually used to create an view of a table



/ system dictionary: .z.b, to look at alias



/ command:
/ \b to look at system dictionary
/ \P num: how many decimals to present
/ \p open portal
/ \t timeit


/ dictionary: list!list
/ operators associated:
/ key, value, count
/ by default, lienar lookup, can have two accounts with the same key, but only return the first one every time
/ if use key with unique attribution, then hash search, much faster
/ if content are the same but order is not, two dict are not the same.
/ empty list ()!() or (`symbol$())!`float$() with types
/ reverse lookup with ? d?value_obj -> key_obj
/ + first expand the dict, then add value accroding to corresponding keys
/ where: accept d_obj = xx, an binary list, return its key list
/ #: extract sub-dictionary: `a`c#dct_obj
/ remove entries: `a`c _ (or cut) dct_obj
/ join ,, right prevailes
/ coalesce ^, right prevailes unless null
/ comparison operator, first expand, if not exist, return false

/ column dictionary, transpose does not change physical arrangement of the data

(`u#`a`b`c)!10 20 30

L:10 20 30
d:0 1 2!10 20 30
L=d
d=L
L~d

dwhackey:(1 2; 3 4 5; 6; 7 8)!10 20 30 40
dwhackey[enlist 6] / cannot retrieve

L:(10 20 30; 100 200 300)

@[count; L]


/ function
/ in each line, between statements, the ordering of evaluation is left to the right, seperated by ;
/ function application
/ apply by name: `f [3]
/ pass parameters by names
/ identity function: ::[]
::[42]

(1; 98.6; {x*x})
f:{x*x}
(neg; f)[0; 23] / first get neg, then apply 23

/ call-by-name
/ get `a, `a set 12

/ use local variable
f:{[p1] a:42; helper:{[a; p2] a*p2}[a;]; helper p1} /otherwise cannot get access from outer function

/ use global variable
/ however, unlike local variable, global variable can be accessed in function

b:7
f:{b*x}
f[6]

/ projection (partial function)
/ notice when the original function change, the projection will not change accordingly
/ dyadic function applied to two lists: pyth:{sqrt (x*x)+y*y} pyth[1 2 3; 1 2 3]

/ types
/ list of list, the outer list is a general list
L:10 20 30 40
L[1]:(type L)$42h
L,:(type L)$43h

/ parsing data from string: using UPPERCASE, "I"$"342"
/ this is different from type cast as "0x01" will be 0x01, not 1
"i"$"432"
"I"$"432"

/ parse function
value "{x*x}"
parse "{x*x}"

/ enumeration: `sym$`a`b`c or `sym?`a`b`c
/ enum created from different domains may have the same values (=), but they are not the same (~)
/ update domain list will update enumerated list
u:`g`aapl`msft`ibm
v:1000000?u
k:`u$v
`int$k

st:()
v:`a`b`c`twtr
ev:`st?`a`b`c
ev,:`st?`twtr
v=ev
v~ev

/ unkeyed-table
/ join by column: t1 ,' t2
/ create from column dict by fliping
dc:`name`iq!(`Dent`Beeblebrox`Prefect;98 42 126)
dc
type dc
t: flip dc
t
type t
t[;`name`iq] / return a list
/ create by constructor
/ when columns are not of the same length, auto fill
([] c1:`a`b`c; c2:42 31; c3:98.6)

/ crerate table by list of dicts
(`name`iq!(`Dent;98); `name`iq!(`Beeblebrox;42))
enlist `a`b!10 20 / this is a table

([] c1:`a`b`c; c2:42; c3:98.6)
/ cols: cols t
t
cols t
/ metadata o table: meta t
meta t

/ value: get a list from a dict

/ append: append a dict, or a list of row data

/ find: a dict or a list of row data

/ column join
,'

/ keyed-table: A keyed table is a dictionary mapping a table of key records to a table of value records.
/ create from two unkeyed-table and use them to create a dict
v:flip `name`iq!(`Dent`Beeblebrox`Prefect;98 42 126)
k:flip (enlist `eid)!enlist 1001 1002 1003
kt:k!v
kt

/ create from constructor

/ retrieve multiple keys: kt[(enlist 1001; enlist 1002)] or kt[flip enlist 1001 1002] or kt ([] eid:1001 1002) or ([] eid:1001 1002)#kt
/ reverse lookup: kts?([] name:`hi`hello)
/ key: key kt, return the key table
/ value: value kt, return the value table
/ keys: return key table cols
/ values: return key table cols
/ xkey: `eid xkey t: use `eid as the key, form a keyed table; () xkey t: form a unkeyed table
/ 1!t also do the same job

kts:([eid:1001 1002 1003] name:`Dent`Beeblebrox`Prefect)
keys kts
cols key kts

value kts
cols value kts

t:([]eid:1001 1002 1003; name:`Dent`Beeblebrox`Prefect; iq:98 42 126)
1!t
kts:([k:101 102 103] v1:`a`b`c; v2:1.1 2.2 3.3)
ktc:([k1:`a`b`c;k2:`x`y`z] v1:`a`b`c; v2:1.1 2.2 3.3)

/ foreign key
/ use a keyed-table's key as domain to create enumeration
kt:([eid:1001 1002 1003] name:`Dent`Beeblebrox`Prefect; iq:98 42 126)
`kt$1002 1001 1001 1003 1002 1003
`kt?1004 / notice this kind of domain cannot automatically expand
tdetails:([] eid:`kt$1003 1001 1002 1001 1002 1001; sc:126 36 92 39 98 42)
meta tdetails
/ fkeys
fkeys tdetails

/ use foreign key to have access to another table connected to this
select eid.name, sc from tdetails

/ append
/ kt,:(key_obj; value_obj; value_obj)

/ find: use a dict or a unkeyed table

/ column join
,'

/ attributes
/ sorted: `s#
/   apply to list: first check, then confirm. If append, first check, if holds, retain
/   apply to dict: to the key list, e.g. `s#10 20 30 40 50!`a`b`c`d`e
/   apply to keyed-table: to the initial key column, e.g. `s#([k:1 2 3 4] v:`d`c`b`a)
/   apply to unkeyed-table, the first column is parted

/ unique: `u#
/ check when apply, drop when make it impossible

/ parted: `p#
/ all common occcurances of any value in a list are adjacent.
/ do not retain anyway

/ grouped: `g#
/ ??
/ remove attributes
/ `#L

/ &&^&& quries
`t insert _dict_ or (_dict_1; _dict_2)
`t insert _row_list_
`t insert _unkeyed_table_
insert[`t; _list_]
`t insert (col1; col2)

/ upsert
/ difference to insert
/ 1. when apply to keyed-table

t:([] col1:`$(); col2:`int$())
kt:([k:`int$()]; col1:`$())

`t insert (`1, 1) / can insert two identical records
t

`kt insert (1, `1) / keyed table cannot insert two record with the same key
`kt upsert (1, `2) / this work, if duplicate, update then
kt

12#t
/ 2. when bulk insert(upsert)
`t upsert (_row_list1_; _row_list2_)

/ 3. can call the table by value, but insert only call by name
/ 4. can upsert into persisted table, insert cannot. Also useful when append to a
/    splayed table


/ select template
/   select <ps> by <pb> from <texp> where <pw>
/   virtual column i: e.g. select i, c1 from t
/ select distinct from
/ select[n/-n] xxx, return first/last n
/ select[n m] xxx from m, use n rows
/ select[>\<col_name] xxx: sort according to columns
/ select[2; <name] combination

/ where i within 50 99
/ where c1, c2 ~ where c1&c2
/ where s like "ef", if s is a column of list

t:([] f:1.1 2.2 3.3; s:("aef";enlist "d";"ef"))
select from t where s like "ef"

/ where weight= (max; weight) fby city
/ (fagg;exprcol) fby c, return index
select from p where weight=(max;weight) fby city

select from p where weight=(max;weight) fby city,color=`blue

/ update: update a column, or column join
update <pu> by <pb> from texp <where pw>

/ delete
delete <pcols> from texp where <pw>
/ a great way to select a few columns

/ sorting: xasc, xdesc
 `c2`c3 xasc t
`c1 xasc `c2 xdesc t

/ rename: xscol
`new1`new2 xcol t
@[cols[t]; where cols[t] in `c1`c3; :; `new1`new3] xcol t

/ rearrange: xcols
`c3`c2 xcols t

/ join
/ 1. implicit join using foreign key
/ 2. left join: lj
t1:([] k:1 2 3 4; c:10 20 30 40)
t2:([] k:1 2 3 4; c:20 30 40 50)
t3:([] j:1 2 3 4; c:30 40 50 60)

kt:([k:2 3 4 5]; v:200 300 400 500)

t1 lj kt
flip each (t1 lj t2) / dog shit
kt lj t1 / do not work
/ 3. inner join
/ create keyed table as needed:
`k xkey t

t1 ij kt
/ 4. Equijoin: all matching records in the right table appear in the result. As with any join, upsert semantics holds on duplicate columns.
/ no need to have a keyed table

ej[`k;t1;t2]
/ 5. Plus join pj
t:([] k:`a`b`c; a:100 200 300; b:10. 20. 30.; c:1 2 3)
kt:([k:`a`b] a:10 20; b:1.1 2.2)

t pj kt
t + kt / length mismatch

/ 6. union join
/ unkeyed table, simply append
t1:([] c1:`a`b`c; c2: 10 20 30)
t2:([] c1:`x`y; c3:8.8 9.9)
t1 uj t2
t3:([] c1:`e`f`g; c2:50 60 70; c3:5.5 6.6 7.7)
(uj/) (t1; t2; t3)

/ keyed table, upsert
kt1:([k:1 2 3] v1:`a`b`c; v2:10 20 30)
kt2:([k:3 4] v2:300 400; v3:3.3 4.4)
kt1 uj kt2

/ 7.as of join
/ aj[`c1...`cn;t1;t2], first symbol is time, t1 is the target, t2 info fill into target by using the last
/ asof
t asof ([] sym:`msft`ibm; ti:10:01:01 10:01:03)

/ 8.window join
t:([]sym:3#`aapl;time:09:30:01 09:30:04 09:30:08;price:100 103 101)
q:([] sym:8#`aapl; time:09:30:01+(til 5),7 8 9; ask:101 103 103 104 104 103 102 100; bid:98 99 102 103 103 100 100 99)
/ wj[w;c;t;(q;(f0;c0);(f1;c1))]
/ w: list of windows
/ c: list of sym and time column names, in that order
/ t: trades table
w:-2 1+\:t `time

wj[w;c;t;(q;(::;`ask);(::;`bid))]

/ control flow
/ ? : or switch
$[exprcond; exprtrue; exprfalse]
$[v=42; [a:6;b:7;`Everything]; [a:`Life;b:`the;c:`Universe;a,b,c]]
$[exprcond1;exprtrue1; …;exprcondn;exprtruen;exprfalse]

/ vector version
?[vb;exprtrue;exprfalse]

/ if
if[exprcond;expr1; …;exprn]

/ do, not recommended
do[exprcount;expr1; …;exprn]

/ early return: :before statement
f:{0N!"Begin"; a:x; b:y; :a*b; "End"}

/ raise exception in function '
g:{0N!"Begin"; a:x; b:y; '"End"; c:b}

/ &&^&& IO
/ file handles
`:/path/name

/ save/read q entities as binary file
/ `:/data/a set 42
/ get `:/data/a == value `:/data/a == \l data/t

/ using data file handle
/ h:hopen `:/data/raw
/ append to data: h 32
/ neg[h] 21431: write as text not binary

/ splayed table
/ The convention for enumerating symbols in splayed tables is to enumerate all
/ symbol columns in all tables over the domain sym and store the resulting
/ sym list in the root directory – i.e., one level above the directory
/ holding the splayed table.

`:/db/tsplay/ set .Q.en[`:/db; ([] c1:`a`b`c; c2:10 20 30)]

/ parse data
/ 1. fixed width record
/   (Lt;Lw) 0:f_hdl read from text Lt: type char of data, uppercase,
/     if not use the column, leave white space, Lw: width of each column,
/     return a compound list
/   (Lt;Lw) 1:f_hdl read from binary: lower case

/ 2. variable length record
/ (Lt;D) 0:f: D: enlisted delimiter, return an unkeyed table
/ (Lt;D) 1:f

/ (Lt;D) 0: char_list : return a list of list

/ 3. parse key-value pair: skip

/ interprocess communication
/   network handle: `:ip/computer name/URL:port
/   open handle: h:hopen `:localhost:5566
/   remote execution:
/   1. h "4*6"
/   2. h (func; args...)
/   3. h (`func_on_server; args...)

/ namespace(context): is a dict
/ . : root context
/ .kx, .[a-z] occupied
/ create context: .foo.a:42
/ key `
key `.
get `.
delete a from `.

/ save and load context: treat it like a dict

/ change working context:
/ can only set context one level down from the root
.jab.tt:12
\d .jab

/ commands and system variables
/ 1. system "p 5042": execute a command, \p
/ 2. list tables: \a
/ 3. alias: \b or .z.b
/ 4. pending alias: \B
/ 5. change working directory: \cd
/ 6. OS command: \_cmd_ e.g. \dir
\conda activate work
/ 7. context: \d
/ 8. error trap: \e [0|1]
/ 9. functions: \f
\f
/ 10. GC: \g ??
/ 11. load \l, use this to load splayed table
/ 12. GMT Offset \o
.z.t / GMT
.z.T / local time
/ 13. seeds \S
/ 14. timer \t
/   1. \t 2000 sleep milliseconds and then move on
/   2. \t:times_of_execution expr
/   3. \ts expr: time and space(bytes)
\t:1000 sum til 100000
/ 15. variables \v
/ 16. workspace \w
/ 17. lock scrip: \_, checks if client write access is blocked. ??
/ 18. redirect:
\1 /data/out.txt
\2 /data/err.txt
