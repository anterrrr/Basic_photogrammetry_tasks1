function [x] = FunReproject(X, P)
%% 函数解释：将空间点反投影至像面
% X：空间点坐标 P：投影矩阵 x：像面坐标
    x = [];
    [row,~]=size(X);
    for i=1:row
        temp_X = [X(i,:).';1];
        temp_x = P*temp_X;
        temp_x = temp_x/temp_x(3);
        x = [x;temp_x.'];
    end
    x = x(:,1:2);
end
