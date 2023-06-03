function P = FunEstimateCamMatrix(x, X)
%% 函数解释：由匹配的像点坐标和空间点坐标计算投影矩阵P
%x：像面坐标 X：空间点坐标

    %参数初始化
    [row,~] = size(x);
    C = [];
    R = [];
    %构建参数矩阵C和结果矩阵R
    for i=1:row
        Xw=X(i,1);Yw=X(i,2);Zw=X(i,3);
        x_=x(i,1);y=x(i,2);
        temp_c = [Xw,Yw,Zw,1,0,0,0,0,-Xw*x_,-Yw*x_,-Zw*x_;
                  0,0,0,0,Xw,Yw,Zw,1,-Xw*y,-Yw*y,-Zw*y;];
        temp_r = [x(i,1);x(i,2)];
        C = [C;temp_c];
        R = [R;temp_r];
    end
    %SVD分解
    [U,S,V] = svd(C);
    P = inv(V.')*pinv(S)*inv(U)*R;
    sum = P(9)^2+P(10)^2+P(11)^2;
    P34 = sqrt(1/sum);
    P = P34*[P(1),P(2),P(3),P(4);
             P(5),P(6),P(7),P(8);
             P(9),P(10),P(11),1];
end