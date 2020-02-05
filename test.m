%file:test.m
%用于分别单个测试每个模块的功能
MSB=2;
origin=zeros(6,6);
origin=[76  ,  11,   128,   192,   159,    22;
    20,   198,   229,   135,    27,   207;
    86,    74,   189,     2,    12,   167;
   154 ,  134 ,  185 ,  178 ,  196 ,   72;
   177  , 141  , 100  ,  15  , 196  ,  84;
   155   ,189   , 26   , 32   ,138   ,121]
blocksize = 6;
x = 1;
y=1;
count=6;
origin=Embedding( origin, blocksize, x, y, MSB, count)
