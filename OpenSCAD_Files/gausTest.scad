/*
(j[1] == -1) ? state0(a, b, [k[0], k[1], k[2]], [j[0], i, j[2], j[3]]) : 
    (j[1] == n ? state0(a, b, [k[0], k[1], k[2]], [j[0], j[1], 0, j[3]]) : (/Manipulate a/))
    (j[2] == p) ? state0(a, b, [k[0], k[1], k[2]], [j[0], j[1], j[2], j[3]]);
    
    */
    

function partial(list,start,end) = [for (i = [start:end]) list[i]];
function z2(k, j, i, s, b) = (k < len(b[0])) ? z2(k + 1, j, i, s, concat(partial(b, 0, j), concat(concat(partial(b[j], 0, k), concat([b[j][k] - s * b[i][k]], partial(b[j], k + 1, len(b[j])))), partial(b, j + 1, len(b))))) : b;

b = [[0.5],
     [2/3],
     [3/4],
     [4/5],
     [5/6]];
echo(z2(0, 0, 0, 2, b));

/*
//state = [i, k=[k1, k2, k3], j=[j1, j2, j3, j4]]
function state0(a, b, state) = let (n = len(b))
(i == n - 1) ? [a, b] : 
    ((j[0] != n && abs(a[j[0]][i]) > abs(a[k[0]][i])) ? state0(a, b, i, [j[0], j[1], j[2]], [j[0] + 1, j[1], j[2], j[3]) :
        ((k[0] != i) ? : ));

function gauss(a, b, state) = assert(len(a) == len(b), "Wrong Dimensions a b") 
assert(len([for(i=a) if (len(i) != len(a)) true]) == 0, "Wrong Dimensions a")
(state == 0) ? 0 : ((state == 1) ? 0 : []);
a = [[4, 1, 0, 0, 0],
     [1, 4, 1, 0, 0],
     [0, 1, 4, 1, 0], 
     [0, 0, 1, 4, 1],
     [0, 0, 0, 1, 4]];
b = [[0.5],
     [2/3],
     [3/4],
     [4/5],
     [5/6]];
echo(len(a));
echo(len(a[0]));
echo(len(b));
echo(gauss(a, b, 0));

*/