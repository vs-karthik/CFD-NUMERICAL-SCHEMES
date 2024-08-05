%  V . sai karthik (231010088)

function u =  pbm1_231010088(x_max, nx, t_max, nt, nu)
x=linspace(0,x_max,nx);
dx=1/(nx-1);
dt=t_max/(nt-1);
u=zeros(nt,nx);
q=((nu)*(dt)/(dx)^2);

for i=1:nx
    if (x(i) >= 0.4)  && (x(i) <= 0.6)
        u(1,i) = 1;
    else
        u(i,i) = 0;
    end
end

for i=1:nt-1                 
    for j=2:nx-1
        u(i+1,j)= q*u(i,j+1)+q*u(i,j-1)+(1-2*q)*u(i,j);
    end
end

end