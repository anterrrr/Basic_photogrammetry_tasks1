function [K, R, t] = FunEstimateParams(P)
%% 函数解释：分解投影矩阵P得到内方位和外方位参数
% P:投影矩阵 K:内方位参数 R：旋转矩阵 t：平移向量
    f = sqrt((P(2,1)^2 + P(2,2)^2 + P(2,3)^2));
    K = [f,0,0;0,f,0;0,0,1];
    t = [P(1,4)/f;P(2,4)/f;P(3,4)];
    R = [P(1,1:3)/f;P(2,1:3)/f;P(3,1:3)];
    
end
