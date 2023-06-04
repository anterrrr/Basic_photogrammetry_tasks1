clear;clc;close all;
%% 数据初始化
bar1 =  load('./data/barCrd2D_Cam1.txt');
bar2 =  load('./data/barCrd2D_Cam2.txt');
bar3D = load('./data/barCrd3D.txt');

code1 =  load('./data/codeCrd2D_Cam1.txt');
code2 =  load('./data/codeCrd2D_Cam2.txt');
code3D =  load('./data/codeCrd3D.txt');

tar1 = load('./data/tarCrd2D_Cam1.txt');
tar2 = load('./data/tarCrd2D_Cam2.txt');
tar3D = load('./data/tarCrd3D.txt');

inParam = load('./data/inParams.txt');
xp = inParam(1);yp = inParam(2);f = inParam(3);


%% 畸变校正
[row,~] = size(bar1);
bar2D_Cam1_crt = bar1-ones([row,1])*[xp,yp]+FunDistortionCorrect(bar1,inParam);
[row,~] = size(code1);
code2D_Cam1_crt = code1-ones([row,1])*[xp,yp]+FunDistortionCorrect(code1,inParam);
[row,~] = size(tar1);
tar2D_Cam1_crt = tar1-ones([row,1])*[xp,yp]+FunDistortionCorrect(tar1,inParam);

[row,~] = size(bar2);
bar2D_Cam2_crt = bar2-ones([row,1])*[xp,yp]+FunDistortionCorrect(bar2,inParam);
[row,~] = size(code2);
code2D_Cam2_crt = code2-ones([row,1])*[xp,yp]+FunDistortionCorrect(code2,inParam);
[row,~] = size(tar2);
tar2D_Cam2_crt = tar2-ones([row,1])*[xp,yp]+FunDistortionCorrect(tar2,inParam);

% 可视化
figure
title('畸变校正前后结果图');
[row,~] = size(tar2D_Cam1_crt);
for i =1:row
    scatter(tar2D_Cam1_crt(i,1),tar2D_Cam1_crt(i,2),6,'red','filled');
    scatter(tar1(i,1),tar1(i,2),6,'+','red');
    hold on;
end

[row,~] = size(bar2D_Cam1_crt);
for i =1:row
    scatter(bar2D_Cam1_crt(i,1),bar2D_Cam1_crt(i,2),6,'blue','filled');
    scatter(bar1(i,1),bar1(i,2),6,'+','blue');
    hold on;
end

[row,~] = size(code2D_Cam1_crt);
for i =1:row
    scatter(code2D_Cam1_crt(i,1),code2D_Cam1_crt(i,2),6,'black','filled');
    scatter(code1(i,1),code1(i,2),6,'+','black');
    hold on;
end

%% 求解相机矩阵P
%随机取点
n = 6;%随机取点的个数
[row,~] = size(code1);
rand_point_index = randperm(row,n);%原始索引
rand_code2D_point = [];
rand_code3D_point = [];

for i = 1:n
    temp1 = code2D_Cam1_crt(rand_point_index(i),:);
    temp3 = code3D(rand_point_index(i),:);
    rand_code2D_point = [rand_code2D_point;temp1];
    rand_code3D_point = [rand_code3D_point;temp3];
end

[row,~] = size(tar1);
rand_point_index = randperm(row,n);%原始索引
rand_tar2D_point = [];
rand_tar3D_point = [];
for i = 1:n
    temp2 = tar2D_Cam1_crt(rand_point_index(i),:);
    temp4 = tar3D(rand_point_index(i),:);
    
    rand_tar2D_point = [rand_tar2D_point;temp2];
    rand_tar3D_point = [rand_tar3D_point;temp4];
end


for i=1:n
    scatter(rand_tar2D_point(i,1),rand_tar2D_point(i,2),'green');
    scatter(rand_code2D_point(i,1),rand_code2D_point(i,2),'green');
    hold on
end

PCam1 = FunEstimateCamMatrix(bar2D_Cam1_crt,bar3D);
PCam1_code = FunEstimateCamMatrix(rand_code2D_point,rand_code3D_point);
PCam1_tar = FunEstimateCamMatrix(rand_tar2D_point,rand_tar3D_point);
disp('6个靶点计算所得投影矩阵P为：');disp(PCam1);
disp('6个随机编码点计算所得投影矩阵P为：');disp(PCam1_code);
disp('6个随机普通点计算所得投影矩阵P为：');disp(PCam1_tar);

%% 将空间坐标投影至像面
%使用由靶点计算出的P对普通空间点进行重投影
rpCam1 = FunReproject(tar3D,PCam1);
%将空间点投影至像面观察分布情况

reproject_error = abs(rpCam1-tar2D_Cam1_crt);
error_max = max(reproject_error);
error_mean = mean(reproject_error);
error_std = std(reproject_error);

%使用由6个随机编码点计算出的P对普通空间点进行重投影
rpCam1_code = FunReproject(tar3D,PCam1_code);
reproject_error_code = abs(rpCam1_code-tar2D_Cam1_crt);
error_max_code = max(reproject_error_code);
error_mean_code = mean(reproject_error_code);
error_std_code = std(reproject_error_code);

%使用由6个随机正常点计算出的P对普通空间点进行重投影
rpCam1_tar = FunReproject(tar3D,PCam1_tar);
reproject_error_tar = abs(rpCam1_tar-tar2D_Cam1_crt);
error_max_tar = max(reproject_error_tar);
error_mean_tar = mean(reproject_error_tar);
error_std_tar = std(reproject_error_tar);

all_error = [error_max;error_max_code;error_max_tar;error_mean;error_mean_code;error_mean_tar;error_std;error_std_code;error_std_tar];


%% 分解投影矩阵
[K,R,t] = FunEstimateParams(PCam1);
disp('内方位参数为：');disp(K);
disp('旋转矩阵为：');disp(R);
disp('平移向量为：');disp(t);
[K_code,R_code,t_code] = FunEstimateParams(PCam1_code);
[K_tar,R_tar,t_tar] = FunEstimateParams(PCam1_tar);










