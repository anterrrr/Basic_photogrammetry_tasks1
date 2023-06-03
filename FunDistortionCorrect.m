function [crdCorrected] = FunDistortionCorrect(crdDistorted,inParam)
%% 函数解释：计算成像畸变Δx,Δy
% crdCorrected：校正后数据 crdDistorted：原数据 inParam：内参数

%参数初始化
[row,~] = size(crdDistorted);
xp=inParam(1); yp=inParam(2); 
f=inParam(3); 
K1=inParam(4); K2=inParam(5);K3=inParam(6); 
P1=inParam(7); P2=inParam(8); 
B1=inParam(9); B2=inParam(10);

%迭代计算
crdCorrected = [];
for i=1:row
    x_ = crdDistorted(i,1)-xp;
    y_ = crdDistorted(i,2)-yp;
    r = sqrt(x_^2+y_^2);
    Delta_x = x_*(K1*r^2+K2*r^4+K3*r^6)+P1*(2*x_^2+r^2)+2*P2*x_*y_+B1*x_+B2*y_;
    Delta_y = y_*(K1*r^2+K2*r^4+K3*r^6)+P2*(2*y_^2+r^2)+2*P1*x_*y_;
    crdCorrected = [crdCorrected;Delta_x,Delta_y];
end

end