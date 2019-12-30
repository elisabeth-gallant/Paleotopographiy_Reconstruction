(1.18*10^5)% get depth values
depth = extract_depth(profiles);

D = length(depth);

% filter outliers
index = 1:length(depth);
% pull out rediculous nulls
ix = find(depth<-100);
index(ix) = [];
depth(ix) = [];

% plot(index,depth)

% manually pull out the ends of the data
ix = find(depth>0,1,'first');
index(ix:end) = [];
depth(ix:end) = [];
index(1:5) = [];
depth(1:5) = [];

plot(index,depth)

%linear
p1 = polyfit(index,depth,1);

%hyperbolic
p2 = polyfit(index,depth,2);

%cubic
p3 = polyfit(index,depth,3);


hold on;
%plot(index,polyval(p1,index));
plot(index,polyval(p2,index));
%plot(index,polyval(p3,index));

legend('Depth','Hyperbolic');

v1 = 1.1023;
v2 = 3.858;
t1 = linspace(0,604800,D);
t2 = linspace(0,172800,D);
t1 = t1(index);
t2 = t2(index);

k1=.1;
k2=.01;
k3=.001;
k4=.0001;

h=3;
theta = 35*pi/180;
g=9.81;
rho = 2600;
depth = -depth;

% actual time spacing makes matlab complain, there's some scaling that
% could make the warning go away but it does finish
p1 = polyfit(t1,(depth),2);
p2 = polyfit(t2,(depth),2);

F1 = k1*rho*g*h*sin(theta)*v1;
F2 = k2*rho*g*h*sin(theta)*v1;
F3 = k3*rho*g*h*sin(theta)*v1;
F4 = k4*rho*g*h*sin(theta)*v1;

H1 = F1*t1./polyval(p1,t1);
H2 = F2*t1./polyval(p1,t1);
H3 = F3*t1./polyval(p1,t1);
H4 = F4*t1./polyval(p1,t1);

dt1 = polyval(p1,t1);
dt2 = polyval(p2,t1);


dH1A = (F1*dt1-F1*t1.*polyval([p1(1)*2, p1(2)],t1))./(dt1.^2);
dH2A = (F2*dt1-F2*t1.*polyval([p1(1)*2, p1(2)],t1))./(dt1.^2);
dH3A = (F3*dt1-F3*t1.*polyval([p1(1)*2, p1(2)],t1))./(dt1.^2);
dH4A = (F4*dt1-F4*t1.*polyval([p1(1)*2, p1(2)],t1))./(dt1.^2);
