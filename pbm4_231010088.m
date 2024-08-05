%  V . sai karthik (231010088)

function [x ,u_explicit,u_implicit ,nt] = pbm4_231010088(x_max, x_min, nx, cfl, t_max, t_min)
dx = (x_max - x_min)/(nx-1);
dt = (cfl)*(dx);
nt = ((t_max - t_min)/(dt)) +1;
sigma = (dt)^2/(dx)^2;
x =linspace(x_min , x_max , nx);
u_explicit = zeros(nt , nx);
u_implicit = zeros(nt , nx);
b =zeros(nx,1);



u_explicit(1,:) = sin(pi*x);
for i= 1: nx-1
    u_explicit(2,i) = (u_explicit(1,i)) + (dt*(0.25)* sin(2*pi*(i-1)*(dx)));
end

% explicit scheme 
for i = 2:nt-1
    
    for j= 2:nx-1
        
        u_explicit(i+1,j) = (2)*(u_explicit(i,j)) - u_explicit(i-1,j) + (sigma)*(u_explicit(i,j+1)+u_explicit(i,j-1)-(2)*(u_explicit(i,j)));
        
    end
end


u_implicit(1,:) = sin(pi*x);
for i= 1: nx-1
    u_implicit(2,i) = (u_implicit(1,i)) + (dt*(0.25)* sin(2*pi*(i-1)*(dx)));
end


%  implicit scheme
c1 = (cfl)^2;
a = full(gallery('tridiag',(nx),c1,-1.5,c1));
a(1,[1 2]) = [1 0];
a(51,[50 51])=[0 1];

b =zeros(nx,1);
for i = 2:nt-1
    for j =2:nx-1
        b(j,1) = u_implicit(i-1,j) - (2*u_implicit(i,j));
    end
     u_implicit(i+1,:) =transpose(a\b);
end

