%  V . sai karthik (231010088)

function [u,u1,u2,x] = pbm2_231010088(x_max, x_min, nx, nt, t_max)
dx= (x_max-x_min)/(nx-1);
dt= (1.5)/(nt-1);
cfl=(dt)/(2*dx);
cfl1 = (dt)/(dx);
dfl= ((dt)^2)/(2*(dx)^2);
x=linspace(0,x_max,nx);
t=linspace(0,t_max,nt);
u=zeros(nt,nx);
u1=zeros(nt,nx);
u2 =zeros(nt,nx); 
k=4*pi;
u(1,:) = sin(k * x);
u1(1,:) = sin(k * x);
u2(1,:) = sin(k * x);
for i= 1:nt-1
    for j=2:nx-1
        u(i+1,j)= (u(i,j+1)*(0.5-cfl)) +  (u(i,j-1)*(0.5+cfl));
        u1(i+1,j)= u1(i,j) - cfl*(u1(i,j+1)-u1(i,j-1)) + (dfl)*(u1(i,j+1)-(2)*u1(i,j)+u1(i,j-1));
        u2(i+1,j)= (u2(i,j)*(1-cfl1) + (cfl1)*(u2(i,j-1)));
    end
end

end