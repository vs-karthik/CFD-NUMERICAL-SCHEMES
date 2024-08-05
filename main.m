%  V . sai karthik (231010088)

clear;
clc;
close all;
%% problem1 

x_max = 1;
t_max = 0.05; 
nx =64;
nt =64;
nu = 0.501;
x=linspace(0,x_max,nx);
u = pbm1_231010088(x_max, nx, t_max, nt, nu);
plot(x,u([1,ceil(nt/5),nt],:))
xlabel("X");
ylabel("Y");
title("solution of the diffusion equation For given conditions")
figure
u = pbm1_231010088(x_max, nx, t_max, 32, nu);
plot(x,u([1,ceil(nt/5),nt],:))
xlabel("X");
ylabel("Y");
title("solution of the diffusion equation when delta(t) is doubled")
figure
u = pbm1_231010088(x_max, nx, t_max, nt, 0.12);
plot(x,u([1,ceil(nt/5),nt],:))
xlabel("X");
ylabel("Y");
title("solution of the diffusion equation for modified viscosity")
figure
u = pbm1_231010088(x_max, nx, t_max, 32, 0.12);
plot(x,u([1,ceil(nt/5),nt],:))
xlabel("X");
ylabel("Y");
title("solution of the diffusion equation for modified viscosity and delta(t) doubled")
figure
%% problem 2

x_max=4;
x_min=0;
t_max=1.5;
nx=30001;
nt= 20001;
nu= 10e-5;
c=1;

[u,u1,u2,x] = pbm2_231010088(x_max, x_min, nx, nt, t_max);
k = 4*pi;
x1 = linspace(1.5,4,30001);
c =1;
u_theoretical = sin(k*x1 - c*1.5 + 1.5);
plot(x,u(1,:))
hold on
plot(x,u(nt,:));
plot(x1,u_theoretical,"--","Color","k")
legend("intial","Friedrich","theoretical")
title("Convection plot")
figure
plot(x,u(1,:))
hold on
plot(x,u1(nt,:));
plot(x1,u_theoretical,"--","Color","k")
legend("intial","Wendroff","theoretical")
title("Convection plot")
figure
plot(x,u(1,:));
hold on
plot(x,u2(nt,:));
title("Convection plot")
plot(x1,u_theoretical,"--","Color","k")
legend("intial","Upwind","theoretical")
figure
%% problem 3
x_min = 0; 
x_max = 4;
nx = 401;
t_min=0;
t_max= 0.5;
dt = 0.001;
c=1;
nu = 0.0050;
nu1 = 0.0024;

[u_final ,nt , x] = pbm3_231010088(x_max, x_min, nx, t_max, dt, nu, nu1);

% maccormak

plot(x,u_final(nt,:),"Color",'black')
hold on
plot(x,u_final(1,:))
legend("final","intial");
title("Maccormak");

figure

% richmyer

plot(x,u_final(nt,:),"Color",'blue')
hold on
plot(x,u_final(1,:))
legend("final","intial");
title("Richmyer");

figure

%% problem 4

x_min = 0;
x_max = 1;
t_min = 0;
t_max = 1.2;
nx= 51;
cfl = 0.5;
[x,u_explicit,u_implicit,nt] = pbm4_231010088(x_max, x_min, nx, cfl, t_max, t_min);

plot(x , u_explicit(1,:));
hold on
plot(x , u_explicit(nt,:),"LineStyle","--","LineWidth",0.7);
plot(x ,u_explicit(40,:),"LineStyle",":","LineWidth",0.7);
plot(x,u_explicit(80,:),"LineStyle","-.","LineWidth",0.7);
legend("intial","t = 1.2","t = 0.4","t = 0.8")
title("Explicit scheme");

figure

plot(x , u_implicit(1,:));
hold on
plot(x , u_implicit(nt,:));
plot(x ,u_implicit(40,:));
plot(x,u_implicit(80,:));
legend("intial","t = 1.2","t = 0.4","t = 0.8")
title("Impicit scheme");

figure 

x = linspace(0,1,51);
t = [0 0.4 0.8 1.2];
u_analytical =zeros(51,4);
for j = 1:4
for i = 1:length(x)
    u_analytical(i,j) = sin(pi.*x(i))*(cos(pi*t(j)) + ((1/(8*pi)) * sin(2*pi.*x(i)) * sin(2*pi*t(j))));
end
end
plot(x,u_analytical(:,1),"LineStyle","--","LineWidth",0.7)
hold on
plot(x,u_analytical(:,2),"LineStyle",":")
plot(x,u_analytical(:,3),"LineStyle","-.","LineWidth",0.7)
plot(x,u_analytical(:,4),"LineStyle","-","LineWidth",0.7)
title("Analytical solutions")

figure
% error plots

plot(x, transpose(u_explicit(ceil(nt/4),:)) - u_analytical(: , 2),"LineStyle","--","LineWidth",0.7);
hold on
plot(x, transpose(u_explicit(ceil(2*nt/3),:)) - u_analytical(: , 3),"LineStyle",":","LineWidth",0.7);
plot(x, transpose(u_explicit(ceil(nt),:)) - u_analytical(: , 4),"LineStyle","-.","LineWidth",0.7);
legend("t = 0.4","t = 0.8","t = 1.2");
title("Error plots for Explicit Scheme");

