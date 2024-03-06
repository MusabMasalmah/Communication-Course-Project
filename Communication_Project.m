clear all;clc;
syms t n n1 n2 k;
T0 = 0.1;
w0 = (2*pi)/T0;
MSE = 0;
Gt = 0;
n = 1:3;
%********************************part1************************************
x1 = @(t) 1*heaviside(t-(T0/2));
x2 = @(t) 1*triangularPulse((t-(T0/2))/(T0/2));
x3 = @(t) 1*rectangularPulse((t-(T0/4))/(T0/2));
y = @(t) x3(t)+ x1(t)*x2(t);

a0 = (1/T0)*int(y(t),t,0,T0)
an = (2/T0)*int(y(t)*cos(n*w0*t),t,0,T0)
bn = (2/T0)*int(y(t)*sin(n*w0*t),t,0,T0)
%********************************part2************************************
for n1 = 1:3
an = (2/T0)*int(y(t)*cos(n1*w0*t),t,0,T0);
bn = (2/T0)*int(y(t)*sin(n1*w0*t),t,0,T0);
Gt = Gt + an*cos(n1*w0*t) + bn*sin(n1*w0*t);
end
Gt = a0 + Gt;
fplot(y(t),[0,T0])
hold on
fplot(Gt,[0,T0])
xlabel('g(t) ... ga(t)')
ylabel('time')
%********************************part3************************************
for k = 1:3
    ga = 0;
   for n2 = 1:k
        an=(2/T0)*int(y(t)*cos(n2*w0*t),t,0,T0);
        bn=(2/T0)*int(y(t)*sin(n2*w0*t),t,0,T0);
        ga = ga + an*cos(n2*w0*t) + bn*sin(n2*w0*t);
   end 
    ga = a0 + ga;
    MSE = (1/T0)*int((y(t) - ga).^2,t,0,T0);
    fprintf('MSE%i: %f\n',k,MSE);
end    

