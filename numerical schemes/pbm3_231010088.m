%  V . sai karthik (231010088)

function [u_final ,nt ,x] = pbm3_231010088(x_max, x_min, nx, t_max, dt, nu ,nu1)
dx = (x_max - x_min) / (nx - 1); 
x = linspace(x_min, x_max, nx); 

nt = round(t_max / dt)+1; 
u_initial = zeros(1, nx); 
u_initial(x >= 2) = 1; 
u_final=zeros(nt,nx);
u_temp=zeros(nt-1,nx);
cfl= (dt)/(2*(dx));
dfl=((nu1)*(dt))/(dx)^2;
u_final(1,:) = u_initial;

% maccormak

for i = 1:nt-1
    for j = 2:nx-1
        u_temp(i,j) = u_final(i,j) - ((cfl)*u_final(i,j)*(u_final(i,j+1) - u_final(i ,j))) + (dfl)*(u_final(i,j+1) + u_final(i ,j-1) - (2)*u_final(i,j));
    end
    for j = 2:nx-1
        u_final(i+1,j) = (0.5)*(u_final(i,j) + u_temp(i,j) - (cfl)* u_final(i,j)*(u_temp(i,j) - u_temp(i ,j-1)) + (dfl)*(u_temp(i ,j+1) + u_temp(i ,j-1) -(2)*u_temp(i ,j)));
    end
end

u_final(:,nx) = 1;
plot(x,u_final(nt,:),"Color",'black')
hold on
plot(x,u_final(1,:))

%  richmyer

dx = (x_max - x_min) / (nx - 1); 
x = linspace(x_min, x_max, nx); 

nt = round(t_max / dt)+1; 
u_initial = zeros(1, nx); 
u_initial(x >= 2) = 1; 
u_final=zeros(nt,nx);
u_temp=zeros(nt-1,nx);
cfl1= (dt)/(4*(dx));
dfl1=((0.5)*(nu)*(dt))/(dx)^2;
u_final(1,:) = u_initial;

for i = 1:nt-1
    for j = 2:nx-1
        u_temp(i,j) = u_final(i,j) - ((cfl1)*u_final(i,j)*(u_final(i,j+1) - u_final(i ,j-1))) + (dfl1)*(u_final(i,j+1) + u_final(i ,j-1) - (2)*u_final(i,j));
    end
    for j = 2:nx-1
        u_final(i+1,j) = u_final(i,j) - (cfl1)* u_final(i,j)*(u_temp(i,j+1) - u_temp(i ,j-1)) + (dfl1)*(u_temp(i ,j+1) + u_temp(i ,j-1) -(2)*u_temp(i ,j));
    end
end

plot(x,u_final(nt,:),"Color",'blue')
hold on
plot(x,u_final(1,:))
end

