clear all
clc
% 导入数据
my_FileName =['C:\Users\kumori\Desktop\Parameter_statistics.xlsx'];
my_SheetName = 'Sheet1';
my_NIR = xlsread(my_FileName,my_SheetName,'A2:C301');
my_octane =  xlsread(my_FileName,my_SheetName,'D2:F301');
% 随机产生训练集和测试集
my_temp = randperm(size(my_NIR,1));
% 训练集——204个样本
P_train_ = my_NIR(my_temp(1:204),:)';
T_train_ = my_octane(my_temp(1:204),:)';
% 测试集——96个样本
P_test_ = my_NIR(my_temp(205:end),:)';
T_test_ = my_octane(my_temp(205:end),:)';
N = size(P_test_,2);
%数据归一化
[p_train_, ps_input_s] = mapminmax(P_train_,0,1);
p_test_ = mapminmax('apply',P_test_,ps_input_s);
[t_train_, ps_output_s] = mapminmax(T_train_,0,1);
% BP神经网络创建、训练及仿真测试
% 创建网络
net = newff(p_train_,t_train_,10);
%设置训练参数
net.trainParam.epochs = 600;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.0000001;
% 训练网络
net = train(net,p_train_,t_train_);
%仿真测试
t_sim_ = sim(net,p_test_);
%数据反归一化
T_sim_ = mapminmax('reverse',t_sim_,ps_output_s);
%相对误差error
error = abs(T_sim_ - T_test_)./T_test_;
% 结果对比
my_result = [T_test_' T_sim_' error'];
%绘图
figure
plot(1:N,T_test_(3,:),'b:*',1:N,T_sim_(3,:),'r-o')
legend('真实值','预测值')
xlabel('预测样本')
ylabel('8th para')
%平均误差率
average_error = sum(error(3,:))/N
%保存训练好的网络在当前工作目录下的bbb文件中，net为网络名
x = [93.38391902,89.74097402,97.6411468]'
c = mapminmax('apply',x,ps_input_s);
d = sim(net,c);
f = mapminmax('reverse',d,ps_output_s)
