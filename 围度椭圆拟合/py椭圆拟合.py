# import numpy as np
# import matplotlib.pyplot as plt
# from scipy.optimize import curve_fit  # 用python拟合函数最主要模块就是cure_fi
# # 准备数据
# with open('x.txt', 'r') as xflie:
#     x = []
#     while True:
#         xdata = xflie.readline()
#         # print(xdata)
#         if xdata == '':
#             break
#         xdata = float(xdata)
#         x.append(xdata)
# with open('y.txt', 'r') as yflie:
#     y = []
#     while True:
#         ydata = yflie.readline()
#         if ydata == '':
#             break
#         ydata = float(ydata)
#         y.append(ydata)
#         # print(ydata)

# x = np.array(x)
# y = np.array(y)

# plt.scatter(x,y,c='g',label='before_fitting')#散点
# plt.show()
# # 定义你自己想要拟合的函数
# def func(x, y, t1, t2, t3, t4, t5, t6):
# return np.sum((t1 * np.power(x,2) + t2 * x * y + t3 * np.power(y,2) +
# t4* x + t5 * y + t6)^2)

# # popt,pcov=curve_fit(func,x,y)
# # print(popt)


# from sympy.parsing.sympy_parser import parse_expr
# from sympy import plot_implicit
# ezplot = lambda exper: plot_implicit(parse_expr(exper))#用了匿名函数   exper表达式
# expression='z*x-1'#隐函数是x**2+y**2-1=0，其实就是圆的方程
# ezplot(expression)#能描绘大致的图像
#

import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
from scipy.optimize import minimize
from sympy.parsing.sympy_parser import parse_expr
from sympy import plot_implicit
# 准备数据
with open('x.txt', 'r') as xflie:
    x = []
    while True:
        xdata = xflie.readline()
        # print(xdata)
        if xdata == '':
            break
        xdata = float(xdata)
        x.append(xdata)
with open('y.txt', 'r') as yflie:
    y = []
    while True:
        ydata = yflie.readline()
        if ydata == '':
            break
        ydata = float(ydata)
        y.append(ydata)
        # print(ydata)
x_data = np.array(x)
y_data = np.array(y)
z_data = np.zeros((len(x_data), 2))
for i in range(len(x_data)):
    aa = [x_data[i], y_data[i]]
    # print(aa)
    z_data[i] = aa


def func(x_data,y_data):
	x = x_data
	y = y_data
	v= lambda t: np.sum((t[0] * np.power(x, 2) + t[1] * x * y + t[2] * np.power(y, 2) + t[3] * x + t[4] * y + t[5])**2)
	
	return v

if __name__ == "__main__":

	t0 = np.array([0.5, 0.5, 0.5, 0.5, 0.5, 0.5])
	res = minimize(func(x_data,y_data), t0)
	print(res.fun)
	print(res.success)
	print(res.x)

	ezplot = lambda exper: plot_implicit(parse_expr(exper))#用了匿名函数
	expression='(-1.64150042e-06)*x*x+(1.50389960e-07)*x*y+(-2.68598310e-06)*y*y+(3.07658150e-06)*x+(3.76491429e-04)*y+(3.49754189e-02)-0'#隐函数是x**2+y**2-1=0，其实就是圆的方程
	ezplot(expression)#能描绘大致的图像