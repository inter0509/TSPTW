Appendix

--------------------------------------------------------------------------------------------------------------
##########TSP Model File##########
param n > 0,integer;
set V := 0..n;
set V2 := 1..n;
param c{V,V} >= 0;
param p{V} >= 0;

var x{V,V} binary;
var u{V2} integer;

minimize total_time : sum{i in V, j in V : i!=j} (x[i,j]*c[i,j])+sum{i in V}(p[i]);

subject to constrain1 {i in V}: sum{j in V:i!=j} x[i,j] = 1;
subject to constrain2 {j in V}: sum{i in V:i!=j} x[i,j] = 1;
subject to constrain3 {i in V2,j in V2:i!=j}: u[i]-u[j]+n*x[i,j] <= (n-1);

##########TSP Data File##########
param n := 9;
param c:
	   0  1 2  3  4  5  6 7  8  9 :=
	0  0  5 4  4  4  6  3 2  1  8 
	1  7  0 2  5  3  5  4 4  4  9 
	2  3  4 0  1  1 12  4 3 11  6
	3  2  2 3  0  2 23  2 9 11  4
	4  6  4 7  2  0  9  8 3  2  1 
	5  1  4 6  7  3  0  8 5  7  4
	6 12 32 5 12 18  5  0 7  9  6
	7  9 11 4 12 32  5 12 0  5 22 
	8  6  4 7  3  5  8  6 9  0  5
	9  4  6 4  7  3  5  8 6  9  0;
	
param p:=
	0 0		1 1
	2 5 	3 9 
	4 2 	5 7 
	6 5 	7 1
	8 5 	9 3;
	
##########Running Result:##########
ampl: model tsp.mod;
ampl: data tsp.dat;
ampl: option solver cplex;
ampl: solve;
CPLEX 12.5.1.0: optimal integer solution; objective 66
54 MIP simplex iterations
0 branch-and-bound nodes
ampl: display x;
x [*,*]
:   0   1   2   3   4   5   6   7   8   9    :=
0   0   0   0   0   0   0   0   0   1   0
1   0   0   0   0   1   0   0   0   0   0
2   0   0   0   1   0   0   0   0   0   0
3   0   0   0   0   0   0   1   0   0   0
4   0   0   0   0   0   0   0   0   0   1
5   1   0   0   0   0   0   0   0   0   0
6   0   0   0   0   0   1   0   0   0   0
7   0   0   1   0   0   0   0   0   0   0
8   0   1   0   0   0   0   0   0   0   0
9   0   0   0   0   0   0   0   1   0   0
;

ampl: display total_time;
total_time = 66
	
--------------------------------------------------------------------------------------------------------------
##########TSPTW Model File##########
	
param n > 0,integer;
set V := 0..n;
set V2 := 1..n;
param c{V,V} >= 0;
param p{V} >= 0;
param r{V} >= 0;
param d{V} >= 0;

var rank{V,V} binary;
var start{V} >= 0;
var y{V,V,V,V2} binary;

minimize total_time : start[n]+sum{j in V:j!=0}(c[j,0]*rank[j,n])+sum{j in V:j!=0} (p[j]*rank[j,n]);

subject to constrain11 {j in V}: sum{k in V} rank[j,k]=1;
subject to constrain12 {k in V}: sum{j in V} rank[j,k]=1;
subject to constrain13: rank[0,0] = 1;

subject to constrain21 {k in V2}: start[k] >= start[k-1] + sum{i in V}(p[i]*rank[i,k-1])
									+sum{i in V,j in V:i!=j}(c[i,j])*y[i,k-1,j,k];
subject to constrain22: start[0] = 0; 

subject to constrain31 {i in V,j in V,k in V2}: y[i,k-1,j,k]<=rank[i,k-1];
subject to constrain32 {i in V,j in V,k in V2}: y[i,k-1,j,k]<=rank[j,k];
subject to constrain33 {i in V,j in V,k in V2}: y[i,k-1,j,k]>=rank[i,k-1]+rank[j,k]-1;

subject to constrain4 {k in V2}: start[k] >= sum{j in V}(r[j]*rank[j,k]);
subject to constarin5 {k in V2}: start[k]+sum{j in V}(p[j]*rank[j,k]) <= sum{j in V}(d[j]*rank[j,k]);

##########TSPTW Data File##########

param n := 9;
param c:
	   0  1 2  3  4  5  6 7  8  9 :=
	0  0  5 4  4  4  6  3 2  1  8 
	1  7  0 2  5  3  5  4 4  4  9 
	2  3  4 0  1  1 12  4 3 11  6
	3  2  2 3  0  2 23  2 9 11  4
	4  6  4 7  2  0  9  8 3  2  1 
	5  1  4 6  7  3  0  8 5  7  4
	6 12 32 5 12 18  5  0 7  9  6
	7  9 11 4 12 32  5 12 0  5 22 
	8  6  4 7  3  5  8  6 9  0  5
	9  4  6 4  7  3  5  8 6  9  0;
	
param p:=
	0 0		1 1
	2 5 	3 9 
	4 2 	5 7 
	6 5 	7 1
	8 5 	9 3;

param r:=
	0 0		1 2
	2 9 	3 4 
	4 12 	5 0 
	6 23 	7 9
	8 15 	9 10;
	
param d:=
	0 150	1 45
	2 42 	3 40 
	4 150 	5 48 
	6 96 	7 100
	8 127 	9 66;
	
##########Running Result##########
ampl: model tsptw.mod;
ampl: data tsptw.dat;
ampl: option solver cplexamp;
ampl: solve;
CPLEX 12.5.0.0: optimal integer solution; objective 75
52894 MIP simplex iterations
3429 branch-and-bound nodes
ampl: display rank;
rank [*,*]
:   0   1   2   3   4   5   6   7   8   9    :=
0   1   0   0   0   0   0   0   0   0   0
1   0   1   0   0   0   0   0   0   0   0
2   0   0   1   0   0   0   0   0   0   0
3   0   0   0   1   0   0   0   0   0   0
4   0   0   0   0   0   0   0   1   0   0
5   0   0   0   0   0   1   0   0   0   0
6   0   0   0   0   1   0   0   0   0   0
7   0   0   0   0   0   0   0   0   1   0
8   0   0   0   0   0   0   0   0   0   1
9   0   0   0   0   0   0   1   0   0   0
;

ampl: display start;
start [*] :
0   0
1   5
2   9
3  15
4  26
5  36
6  47
7  53
8  58
9  64
;

ampl: display total_time;
total_time = 75
--------------------------------------------------------------------------------------------------------------
