function f = fun_test(x)
%网络加载,注意文件名要加单引号
    load('-mat','aaa');
    load('ps_input_.mat');
    load('ps_output_.mat');
    c = mapminmax('apply',x,ps_input_);
    d = sim(net,c);
    f = mapminmax('reverse',d,ps_output_);
end

