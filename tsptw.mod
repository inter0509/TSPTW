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

subject to constrain21 {k in V2}: start[k] >= start[k-1] + sum{i in V}(p[i]*rank[i,k-1]) + sum{i in V,j in V:i!=j}(c[i,j])*y[i,k-1,j,k];
subject to constrain22: start[0] = 0; 

subject to constrain31 {i in V,j in V,k in V2}: y[i,k-1,j,k]<=rank[i,k-1];
subject to constrain32 {i in V,j in V,k in V2}: y[i,k-1,j,k]<=rank[j,k];
subject to constrain33 {i in V,j in V,k in V2}: y[i,k-1,j,k]>=rank[i,k-1]+rank[j,k]-1;

subject to constrain4 {k in V2}: start[k] >= sum{j in V}(r[j]*rank[j,k]);
subject to constarin5 {k in V2}: start[k]+sum{j in V}(p[j]*rank[j,k]) <= sum{j in V}(d[j]*rank[j,k]);

