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
