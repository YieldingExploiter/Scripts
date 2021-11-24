
local MD5 = (function()local function a(b)if b-math.floor(b)>0 then error("trying to use bitwise operation on non-integer!")end end;local function c(d)local b=#d;local e=0;local f=1;for g=1,b do e=e+d[g]*f;f=f*2 end;return e end;local function h(i,j)local k={}local l={}if#i>#j then k=i;l=j else k=j;l=i end;for g=#l+1,#k do l[g]=0 end end;local m=function()end;local function n(b)local d=m(b)local o=math.max(#d,32)for g=1,o do if d[g]==1 then d[g]=0 else d[g]=1 end end;return c(d)end;m=function(b)a(b)if b<0 then return m(n(math.abs(b))+1)end;local d={}local p=1;while b>0 do local q=math.mod(b,2)if q==1 then d[p]=1 else d[p]=0 end;b=(b-q)/2;p=p+1 end;return d end;local function r(s,b)local i=m(s)local j=m(b)h(i,j)local d={}local e=math.max(#i,#j)for g=1,e do if i[g]==0 and j[g]==0 then d[g]=0 else d[g]=1 end end;return c(d)end;local function t(s,b)local i=m(s)local j=m(b)h(i,j)local d={}local e=math.max(#i,#j)for g=1,e do if i[g]==0 or j[g]==0 then d[g]=0 else d[g]=1 end end;return c(d)end;local function u(s,b)local i=m(s)local j=m(b)h(i,j)local d={}local e=math.max(#i,#j)for g=1,e do if i[g]~=j[g]then d[g]=1 else d[g]=0 end end;return c(d)end;local function v(b,w)a(b)local x=0;if b<0 then b=n(math.abs(b))+1;x=2147483648 end;for g=1,w do b=b/2;b=r(math.floor(b),x)end;return math.floor(b)end;local function y(b,w)a(b)if b<0 then b=n(math.abs(b))+1 end;for g=1,w do b=b/2 end;return math.floor(b)end;local function z(b,w)a(b)if b<0 then b=n(math.abs(b))+1 end;for g=1,w do b=b*2 end;return t(b,4294967295)end;local function A(s,b)local B=r(n(s),n(b))local C=r(s,b)local e=t(C,B)return e end;local D={ff=tonumber('ffffffff',16),consts={}}string.gsub(" d76aa478 e8c7b756 242070db c1bdceee\n    f57c0faf 4787c62a a8304613 fd469501\n    698098d8 8b44f7af ffff5bb1 895cd7be\n    6b901122 fd987193 a679438e 49b40821\n    f61e2562 c040b340 265e5a51 e9b6c7aa\n    d62f105d 02441453 d8a1e681 e7d3fbc8\n    21e1cde6 c33707d6 f4d50d87 455a14ed\n    a9e3e905 fcefa3f8 676f02d9 8d2a4c8a\n    fffa3942 8771f681 6d9d6122 fde5380c\n    a4beea44 4bdecfa9 f6bb4b60 bebfbc70\n    289b7ec6 eaa127fa d4ef3085 04881d05\n    d9d4d039 e6db99e5 1fa27cf8 c4ac5665\n    f4292244 432aff97 ab9423a7 fc93a039\n    655b59c3 8f0ccc92 ffeff47d 85845dd1\n    6fa87e4f fe2ce6e0 a3014314 4e0811a1\n    f7537e82 bd3af235 2ad7d2bb eb86d391\n    67452301 efcdab89 98badcfe 10325476 ","(%w+)",function(E)table.insert(D.consts,tonumber(E,16))end)function D.transform(F,G,H,I,J)local K=function(L,M,N)return r(t(L,M),t(-L-1,N))end;local O=function(L,M,N)return r(t(L,N),t(M,-N-1))end;local P=function(L,M,N)return u(L,u(M,N))end;local g=function(L,M,N)return u(M,r(L,-N-1))end;local N=function(K,Q,R,S,T,L,E,U)Q=t(Q+K(R,S,T)+L+U,D.ff)return r(z(t(Q,v(D.ff,E)),E),v(Q,32-E))+R end;local Q,R,S,T=F,G,H,I;local V=D.consts;Q=N(K,Q,R,S,T,J[0],7,V[1])T=N(K,T,Q,R,S,J[1],12,V[2])S=N(K,S,T,Q,R,J[2],17,V[3])R=N(K,R,S,T,Q,J[3],22,V[4])Q=N(K,Q,R,S,T,J[4],7,V[5])T=N(K,T,Q,R,S,J[5],12,V[6])S=N(K,S,T,Q,R,J[6],17,V[7])R=N(K,R,S,T,Q,J[7],22,V[8])Q=N(K,Q,R,S,T,J[8],7,V[9])T=N(K,T,Q,R,S,J[9],12,V[10])S=N(K,S,T,Q,R,J[10],17,V[11])R=N(K,R,S,T,Q,J[11],22,V[12])Q=N(K,Q,R,S,T,J[12],7,V[13])T=N(K,T,Q,R,S,J[13],12,V[14])S=N(K,S,T,Q,R,J[14],17,V[15])R=N(K,R,S,T,Q,J[15],22,V[16])Q=N(O,Q,R,S,T,J[1],5,V[17])T=N(O,T,Q,R,S,J[6],9,V[18])S=N(O,S,T,Q,R,J[11],14,V[19])R=N(O,R,S,T,Q,J[0],20,V[20])Q=N(O,Q,R,S,T,J[5],5,V[21])T=N(O,T,Q,R,S,J[10],9,V[22])S=N(O,S,T,Q,R,J[15],14,V[23])R=N(O,R,S,T,Q,J[4],20,V[24])Q=N(O,Q,R,S,T,J[9],5,V[25])T=N(O,T,Q,R,S,J[14],9,V[26])S=N(O,S,T,Q,R,J[3],14,V[27])R=N(O,R,S,T,Q,J[8],20,V[28])Q=N(O,Q,R,S,T,J[13],5,V[29])T=N(O,T,Q,R,S,J[2],9,V[30])S=N(O,S,T,Q,R,J[7],14,V[31])R=N(O,R,S,T,Q,J[12],20,V[32])Q=N(P,Q,R,S,T,J[5],4,V[33])T=N(P,T,Q,R,S,J[8],11,V[34])S=N(P,S,T,Q,R,J[11],16,V[35])R=N(P,R,S,T,Q,J[14],23,V[36])Q=N(P,Q,R,S,T,J[1],4,V[37])T=N(P,T,Q,R,S,J[4],11,V[38])S=N(P,S,T,Q,R,J[7],16,V[39])R=N(P,R,S,T,Q,J[10],23,V[40])Q=N(P,Q,R,S,T,J[13],4,V[41])T=N(P,T,Q,R,S,J[0],11,V[42])S=N(P,S,T,Q,R,J[3],16,V[43])R=N(P,R,S,T,Q,J[6],23,V[44])Q=N(P,Q,R,S,T,J[9],4,V[45])T=N(P,T,Q,R,S,J[12],11,V[46])S=N(P,S,T,Q,R,J[15],16,V[47])R=N(P,R,S,T,Q,J[2],23,V[48])Q=N(g,Q,R,S,T,J[0],6,V[49])T=N(g,T,Q,R,S,J[7],10,V[50])S=N(g,S,T,Q,R,J[14],15,V[51])R=N(g,R,S,T,Q,J[5],21,V[52])Q=N(g,Q,R,S,T,J[12],6,V[53])T=N(g,T,Q,R,S,J[3],10,V[54])S=N(g,S,T,Q,R,J[10],15,V[55])R=N(g,R,S,T,Q,J[1],21,V[56])Q=N(g,Q,R,S,T,J[8],6,V[57])T=N(g,T,Q,R,S,J[15],10,V[58])S=N(g,S,T,Q,R,J[6],15,V[59])R=N(g,R,S,T,Q,J[13],21,V[60])Q=N(g,Q,R,S,T,J[4],6,V[61])T=N(g,T,Q,R,S,J[11],10,V[62])S=N(g,S,T,Q,R,J[2],15,V[63])R=N(g,R,S,T,Q,J[9],21,V[64])return F+Q,G+R,H+S,I+T end;local function W(g)local K=function(E)return string.char(t(v(g,E),255))end;return K(0)..K(8)..K(16)..K(24)end;local function X(E)local Y=0;for g=1,string.len(E)do Y=Y*256+string.byte(E,g)end;return Y end;local function Z(E)local Y=0;for g=string.len(E),1,-1 do Y=Y*256+string.byte(E,g)end;return Y end;local function _(E,...)local a0,a1=1,{}for g=1,#arg do table.insert(a1,Z(string.sub(E,a0,a0+arg[g]-1)))a0=a0+arg[g]end;return a1 end;function D.Calc(E)local a2=string.len(E)local a3=56-a2%64;if a2%64>56 then a3=a3+64 end;if a3==0 then a3=64 end;E=E..string.char(128)..string.rep(string.char(0),a3-1)E=E..W(8*a2)..W(0)assert(string.len(E)%64==0)local V=D.consts;local Q,R,S,T=V[65],V[66],V[67],V[68]for g=1,string.len(E),64 do local J=_(string.sub(E,g,g+63),4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4)assert(#J==16)J[0]=table.remove(J,1)Q,R,S,T=D.transform(Q,R,S,T,J)end;local a4=function(a5)return X(W(a5))end;return string.format("%08x%08x%08x%08x",a4(Q),a4(R),a4(S),a4(T))end;return D;end)()