**Basic tasks of photogrammetry Ⅰ**

注：本次任务中使用的数据来自某气象雷达天线的摄影测量实验，所有数据均在文件夹data中。

**任务1：在已知畸变模型的情况下对像面点进行畸变矫正。**

相机投影矩阵是针孔成像模型的数学描述，是线性的成像模型，其中仅仅包含了焦距、主点、旋转矩阵、平移向量。畸变是系统的非线性成像缺陷模型，它使得实际的成像坐标偏离了理想位置（针孔模型成像位置），畸变对于成像点位置的影响如下图1所示。

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795056042-fb89525b-6b4b-4e66-9972-e7dd11ccdd3a.png#averageHue=%23fcfcf4&clientId=uda22b19d-d590-4&from=paste&height=272&id=udffa9399&originHeight=342&originWidth=625&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=216122&status=done&style=none&taskId=uf6abddbb-29ef-431c-a7b7-dd7e695191a&title=&width=497.102783203125)

图1 畸变量示意图（蓝色点为理想像点位置，红色圆圈为实际像点位置）

为了准确求解相机矩阵P，需要将实际的像面坐标进行校正，消除非线性畸变的影响。畸变量通过下面的多项式描述：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795720504-fedbbafa-3446-4ada-8f7c-5a7be190cb4a.png#averageHue=%23f1f1f1&clientId=uda22b19d-d590-4&from=paste&height=71&id=ub7303f61&originHeight=76&originWidth=411&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=5713&status=done&style=none&taskId=u0fcd0c2a-e258-44d0-9f45-4abb01a9eec&title=&width=384.1121307032869)

其中

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795733529-ae27b023-1f6f-4502-b25e-62ecad753cbd.png#averageHue=%23f7f7f7&clientId=uda22b19d-d590-4&from=paste&height=39&id=u7a35614b&originHeight=42&originWidth=301&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=1345&status=done&style=none&taskId=u799a74ba-66f4-48b9-aea1-b25e2ae166e&title=&width=281.3083974250349)

公式中，k1, k2, K3是径向畸变参数；P1, P2是偏心畸变参数；B1, B2是面内附加畸变参数，由像面坐标轴不垂直、像元尺寸在两方向不一致等原因引起。
令相机的主点偏移为xp和yp，那么点(x, y)校正后的像点坐标(xl, yl)为：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795746603-1d8ce413-3919-4415-91cc-67b03dbcefc7.png#averageHue=%23f3f3f3&clientId=uda22b19d-d590-4&from=paste&height=54&id=u7da1e6b3&originHeight=58&originWidth=119&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=1422&status=done&style=none&taskId=ub5d42a05-c9b0-40d5-80c2-e1231eb199c&title=&width=111.21494781919985)

    畸变矫正函数见FunDistortionCorrect.m

**任务2：给定一些三维坐标已知的空间点，以及它们在像面上的二维像点坐标，计算相机的投影矩阵P。**

相机投影矩阵是相机成像模型的数学描述，它包含了相机的内方位参数（Intrinsic Orientations）和外方位参数（Extrinsic Orientations）等全部信息，是相机标定、定向、匹配、三维重建等技术的模型和方法基础。

本次实验采用如下的成像模型：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795688325-4d5162ae-24ae-486c-b9db-8585f08f3589.png#averageHue=%23f5f4f4&clientId=uda22b19d-d590-4&from=paste&height=195&id=u8d7991a2&originHeight=209&originWidth=544&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=20715&status=done&style=none&taskId=u3be422f9-19ff-4a0a-9146-18f8955303e&title=&width=508.4111900306279)

由于已经进行校正（包括畸变校正和主轴偏移），因此内参数矩阵采用如下形式：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795798101-2054e5ba-6541-4f79-93b7-03e16176abe6.png#averageHue=%23f3f3f3&clientId=uda22b19d-d590-4&from=paste&height=79&id=uc88575de&originHeight=84&originWidth=144&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=2845&status=done&style=none&taskId=ua697c686-108b-40d1-b5d1-0c2744fc770&title=&width=134.57943265516622)

将矩阵方程展开可得：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795936967-f6226424-40ab-4848-9f5a-9e2c98a9b7b7.png#averageHue=%23eeeeee&clientId=uda22b19d-d590-4&from=paste&height=53&id=ua486ab2e&originHeight=57&originWidth=505&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=10359&status=done&style=none&taskId=u073de240-15dd-4c85-89ab-803ac34cad5&title=&width=471.96259368652034)

由6个靶点像面坐标和空间坐标以及约束条件：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685795994244-4af8e1b3-6372-4f22-b76c-49910e50816d.png#averageHue=%23ececec&clientId=uda22b19d-d590-4&from=paste&height=22&id=u9c7f9ea3&originHeight=24&originWidth=150&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=1788&status=done&style=none&taskId=u9bb14979-96ef-4676-a6a0-bafa6adf637&title=&width=140.18690901579814)
可解得投影矩阵P。
    投影矩阵计算函数见FunEstimateCamMatrix.m。
已知至少六个点的空间坐标和对应的像面坐标，我们可以求解得到相机的投影矩阵_P_。反过来，如果知道了投影矩阵_P_和若干点空间坐标，那么可以计算它们在像面的投影点坐标，用到的模型是：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685796270582-30357b88-9377-4af8-9f17-26512f476df3.png#averageHue=%23f2f2f2&clientId=uda22b19d-d590-4&from=paste&height=95&id=u3847f30d&originHeight=116&originWidth=136&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=2784&status=done&style=none&taskId=u2508ab4d-4787-4ba2-abb2-ff9e18135e0&title=&width=111.10279846191406)

反投影点坐标与实际像点坐标之间的差别被称为像面误差，是视觉里面常用的一种度量标准，可以作为相机标定、空间重建、投影矩阵等等计算结果优劣的比较标准。

    反投影函数见FunReproject.m。

**任务3：对投影矩阵进行分解，得到相机的内参数矩阵、旋转矩阵和平移向量。**

由成像模型可得：

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685796574290-b9640451-8044-4098-ba55-c7b1cb4988c3.png#averageHue=%23f1f1f1&clientId=uda22b19d-d590-4&from=paste&height=79&id=ub2118f7d&originHeight=85&originWidth=313&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=7449&status=done&style=none&taskId=uaececeaf-38e7-4fd6-b39b-3b9281d98f6&title=&width=292.52335014629875)

根据旋转矩阵的单位性和正交性易分解P得到f，进而得到旋转矩阵R和平移向量T。
    
    投影矩阵分解函数见FunEstimateParams.m

**任务4：测试点分布对投影矩阵P求解和对内参数求解精度的影响**

分别6个使用靶点、6个随机编码点和6个随机普通点的像面坐标和空间坐标调用FunEstimateCamMatrix计算投影矩阵PCam1、PCam1_code和PCam1_tar；调用反投影函数FunReproject将全部的普通点的空间坐标反投影至像面，计算像面误差，进而得到像面误差的最大值、均值和标准差等指标，并以上述指标为度量标准测试点分布对投影矩阵P求解精度的影响；调用FunEstimateParams分别对PCam1、PCam1_code和PCam1_tar进行分解得到内参数矩阵，以计算焦距和真实焦距之间的误差为度量标准测试点分布对内参数求解精度的影响。

6个随机编码点和6个随机普通点分布1可视化

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685798464155-d1f41da5-addb-459d-ba7d-068264743f42.png#averageHue=%23fcf9f9&clientId=uda22b19d-d590-4&from=paste&height=409&id=u790367fb&originHeight=648&originWidth=865&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=331433&status=done&style=none&taskId=u1d64201c-98dd-4e81-add3-255ba5154c6&title=&width=546.0098876953125)

分布1像面误差统计

| 
| **最大值** |  | **均值** |  | **标准差** |  |
| --- | --- | --- | --- | --- | --- | --- |
| **靶点** | **2.43595** | **6.14031** | **0.51246** | **1.47491** | **0.53322** | **1.58907** |
| **编码点** | **0.01007** | **0.00324** | **4.8961e-04** | **2.7193e-04** | **6.4903e-04** | **2.7173e-04** |
| **普通点** | **0.01000** | **0.00931** | **12.1809e-04** | **13.6942e-04** | **15.8918e-04** | **18.1455e-04** |

6个编码点和普通点分布2可视化

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685798487256-7225b7ef-865f-475b-84f1-fd2273c792f2.png#averageHue=%23fcf9f9&clientId=uda22b19d-d590-4&from=paste&height=408&id=u3790e836&originHeight=649&originWidth=865&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=333189&status=done&style=none&taskId=u6387d36a-86d1-4208-874e-84fbcd57fe0&title=&width=543.9946899414062)

分布2像面误差统计

| 
 | **最大值** |  | **均值** |  | **标准差** |  |
| --- | --- | --- | --- | --- | --- | --- |
| **靶点** | **2.43595** | **6.14031** | **0.51246** | **1.47491** | **0.53322** | **1.58907** |
| **编码点** | **0.00864** | **0.00508** | **5.3781e-04** | **5.9702e-04** | **5.6967e-04** | **5.0629e-04** |
| **普通点** | **0.00990** | **0.00360** | **7.6688e-04** | **6.3343e-04** | **10.3246e-04** | **7.0684e-04** |

6个编码点和普通点分布3可视化

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25481822/1685798509717-7378b466-afb9-415e-bdc5-5656bf7e4edb.png#averageHue=%23fcf9f9&clientId=uda22b19d-d590-4&from=paste&height=409&id=ucbc3381e&originHeight=649&originWidth=865&originalType=binary&ratio=1.0700000524520874&rotation=0&showTitle=false&size=334870&status=done&style=none&taskId=uaf13d12b-1466-474c-916d-c761c978b85&title=&width=545.0005493164062)

分布3像面误差统计

| 
 | **最大值** |  | **均值** |  | **标准差** |  |
| --- | --- | --- | --- | --- | --- | --- |
| **靶点** | **2.43595** | **6.14031** | **0.51246** | **1.47491** | **0.53322** | **1.58907** |
| **编码点** | **0.00926** | **0.00416** | **3.1262e-04** | **3.8569e-04** | **4.9670e-04** | **4.0664e-04** |
| **普通点** | **0.009794** | **0.00352** | **4.0687e-04** | **2.8803e-04** | **4.9176e-04** | **2.7797e-04** |

使用靶点求解得到P的分解结果如下

| **内参矩阵** |  |  | **旋转矩阵** |  |  | **平移向量** |
| --- | --- | --- | --- | --- | --- | --- |
| **14.303** | **0.000** | **0.000** | **-0.357** | **1.237** | **0.160** | **-194.990** |
| **0.000** | **14.303** | **0.000** | **0.062** | **0.302** | **0.951** | **-1228.571** |
| **0.000** | **0.000** | **1.000** | **0.458** | **-0.686** | **0.566** | **1877.791** |

使用随机编码点求解得到P的分解结果如下

| **内参矩阵** |  |  | **旋转矩阵** |  |  | **平移向量** |
| --- | --- | --- | --- | --- | --- | --- |
| **20.311 ** | **0.000 ** | **0.000 ** | **-0.203 ** | **0.970 ** | **0.131 ** | **-157.159 ** |
| **0.000 ** | **20.311 ** | **0.000 ** | **0.624 ** | **0.026 ** | **0.781 ** | **-990.648 ** |
| **0.000 ** | **0.000 ** | **1.000 ** | **-0.754 ** | **-0.240 ** | **0.611 ** | **2150.285 ** |

使用随机普通点求解得到P的分解结果如下

| **内参矩阵** |  |  | **旋转矩阵** |  |  | **平移向量** |
| --- | --- | --- | --- | --- | --- | --- |
| **20.316 ** | **0.000 ** | **0.000 ** | **-0.203 ** | **0.971 ** | **0.131 ** | **-157.293 ** |
| **0.000 ** | **20.316 ** | **0.000 ** | **0.624 ** | **0.026 ** | **0.781 ** | **-990.713 ** |
| **0.000 ** | **0.000 ** | **1.000 ** | **-0.754 ** | **-0.241 ** | **0.611 ** | **2151.464 ** |

    所有测试代码和可视化程序见testMain.m。




