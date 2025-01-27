%% Getting started
pwd
cd ..
cd 


%% Creating vectors and matrices
% row vector 
x = [1 4 7]
% column vector 
x = [1;4;7]

% Numbers from 1 to 6
z=1:6
% Vs. 
z=1:6;
% How many numbers in z? 
length(z)
size(z)
size(z,2)
% Numbers from 1 to 6 in steps of 0.5
z=1:0.5:6;
% Creating a vector of ones
ones(1,6)
ones(1,length(z))
zeros(1,5)
% Creating a matrix (2D)
x=[2 3;3 4]
x=ones (3,2); 
x=eye(3);
% Creating a 3D matrix
clear x
x(:,:,1)=[2 3;3 4];
x(:,:,2)=[1 5;6 3];
x(:,:,3)=[9 7;3 8];
size(x)


%% Basic manipulaiton of matrices
load week1_basicMats
x(1,1) %rowindex, column index
% Can you extract the element in the 4th row, 8th col? 
x(2,:) %2nd row
x(:,3) %3rd column
% 2nd and 4rd rows, 7th col
x([2 4],7) 
% 2nd through 4th rows, 7th col
x([2 3 4],7) 
x([2:4],7) 

%% Vector/matric operations
x=[1 2 3 4 5]; 
Multiply by 2
z=2*x
y=[3 4 5 6 7]; 
Multiply each element of x by each element of y
x=[2 3;3 4]
y=[0.5 -0.5;-0.5 0.5]
z=x.*y
% square every element
x.^2

%% Cell arrays
myCell = {[1 2 3],'hello',[1 2;3 4]}
xCell = {[1 2 3],'hello',[1 2;3 4];
             'booyah',[1 2 3;4 5 6],{11;22;33}}

%% Struct
myStr.mat = [1 2 3;4 5 6]; 
myStr.txt = 'hello';
myStr.cel = xCell;
myStr.cel
         
%% Basic operations
% = vs. == 
x=[-1 2 0 4 3];
(x==0) % [0 0 1 0 0] 
% find
[zeroIndices] = find(x==0); %? 3
% sign
sign(x) % ?  [-1 1 0 1 1 ]
% At what time does X cross the threshold of 25?
t= [1:9]; 
x = [18 24.5 19.5 24.75 25.2 30 27.5 28 32]

cos, sin, tan (acos, asin, atan)
% Work in radians. To convert to degrees: *180/pi

%% Basic operations
x=[3 1 2]; y=[4 3 6 5]; 
intersect(x,y)
union(x,y)
setdiff(x,y)
ismember(x,7)
% sort(x)
x=[30 1 12]; w = [160 24 70]; 
[sx,ix] = sort(x)
x(ix)
w(ix)
repmat
repmat(x,3,1)
repmat(x,3,2);

%%  Control branching
if x==5 
    z=2; 
else
    z=3;
end

if x==5, z=2; 
elseif x==7, z=3; 
else z=5; 
end

switch x
case 5, z=2;
case 7, z=3;
otherwise z=5;
end 

%% Loops
% for loop
for i=1:5
i
end
% while loop
i=1;
while i<5
i
i=i+1;
end


%% Basic plotting in 2D
load week1_plotting

% Create x = [1 2 3 ? ]
x=1:length(y)

% Plot y vs. x
figure;
plot(x,y)

% Symbols
plot(x,y,'.')
plot(x,y,'.-')
plot(x,y,?color?,?r?); 
set(gca,?fontsize?,12);  

% Labeling
xlabel('Time (minutes)')
ylabel
ylabel('Amount of cortisol in blood (\mug)')

% Scripts in MATLAB

%% Handles and pointers 
% Colors
h=plot(x,y,'.-');
set(h,'color','r');
h=plot(x,y,'^-')
% Marker color green
set(h,'color','g')
set(h,'markeredgecolor','k')
% Markersize
set(h,'markersize',15)
% Properties: 
get(h)

%% Labeling
% Title
title('test plot')
% Change xlabel to Time (days)
% Change size of xlabel to 5
xh = xlabel('Time (days)');
set(xh,'fontsize',2) %for xlabel and ylabel
% Size of tick labels
set(gca,'fontsize',10) %only for ticklabel text
% Set tick labels to [7 8 9 10..]
set(gca,'xticklabel', 6+[1:length(y)]);
% Change tick labels to 3* and change font size to 15 
set(gca,'xticklabel',3*[1:length(y)],'fontsize',15);
% Tick direction & length
set(gca,'tickdir','out')
set(gca,'ticklength',[0.05 0.05])

%% Text and colors
text(0.2,0.3,'hello')
hold on;
% Converting a number to text
mean(y)
s = num2str(mean(y))
title(s)
% More control
sprintf('%3.2f',mean(y))
% Place the value of mean(y) at (0.2,0.3)  
text(0.2,0.3,sprintf('%3.2f',mean(y)))
% Properties of text
th = text(0.2,0.3,sprintf('%3.2f',mean(y)));
% Set fontsize to 20 and color to blue
set(th,'fontsize',20,'color','b')
% Colors
% [R G B]; going from 0 to 1
[1 0 0]

%% Errorbar and axis controls
% Errorbar
errorbar([1 2 3], [17 32 21], [3 5 4], [3 5 4])
hh=errorbar([1 2 3], [17 32 21], [3 5 4], [3 5 4],'o-')
	      set(hh,'color','r','linewidth',4,'markersize',25,'markerfacecolor','k')
load week1_ebar
errorbar(x,ye,ey)
h=errorbar(X,Y,L,U)
set(h,'markersize','markerfacecolor','color');
% No wasted space
axis tight
x=[1:5]; y=[0.5:1.5:6.5]; plot(x,y,'.-')
% x-and y- tick marks are equal in length?
axis equal
% Turn off axis 
axis off
help axis

%% Filling an object with color
fill([1 2 2 1],[3 3 4 4],'y') %yellow square

%Fill a triangle with blue?

%% Errorband
figure;
subplot(3,1,1); errorbar(x,ye,ey)
subplot(3,1,2);
plot(x,ye,'k-','linewidth',2); 
hold on; 
yplus = ye+ey;
yminus = ye-ey; 
h = fill ([x fliplr(x)],[yplus fliplr(yminus)],'y');
set(h,'edgecolor','none')
alpha(0.5);

subplot(3,1,3);
h = fill ([x fliplr(x)],[yplus fliplr(yminus)],'y');
set(h,'edgecolor','none')
alpha(0.5);
hold on; 
plot(x,ye,'k-','linewidth',2); 

%%
x1=[1 2 3 4 5];
y1 = x1.^2; 
x2=[1.5 2.5 3.5 4.5 5.5];
y2 = x2.^3; 
plot(x1,y1,'b-',x2,y2,'r-'); 
x=[x1' x2']; y = [y1' y2']; 
plot(x,y); 
%% what if x1=x2?
clear x; x = repmat(x1,2,1)'
plot(x,y)
%OR
plot(x1,y); 



%% 3D Plots
x=[0:36:360];
z1=sin(pi/180*x);
plot(x,z1,'.-')
hold on;
z2=2*sin(pi/180*x);
plot(x,z2,'k.-')
z3=4*sin(pi/180*x);
plot(x,z3,'r.-')
z4=6*sin(pi/180*x);
plot(x,z4,'g.-')
xlabel('time')
ylabel('responses')

%% What if... 
% We think about this as plots of sines as a function of x, at different values of another variable y
% Now we are in the domain of 3D plots with 3 variables x,y, & z.
figure; hold on
plot3(x,1*ones(1,length(x)),z1)
plot3(x,2*ones(1,length(x)),z2,'k')
plot3(x,4*ones(1,length(x)),z3,'r')
plot3(x,6*ones(1,length(x)),z4,'g')
view(-42,40)
grid on;
xlabel('time')
ylabel('drug concentration')
zlabel('responses')

%% Meshes and surfaces
figure;
[X,Y]=meshgrid(x,[1 2 4 6]);
Z=Y.*sin(pi/180*X);
mesh(X,Y,Z)
% Set color of the edges to red
h=mesh(X,Y,Z); set(h,'edgecolor','r')
% Label axes
xlabel('time')
ylabel('drug concentration')
zlabel('responses')
% Make an interpolated surface 
surf(X,Y,Z)
% Set color of the face of the surface to gray
h=surf(X,Y,Z); set(h,'facecolor',[0.5 0.5 0.5])
% Add contours
surfc(X,Y,Z)

%% Heatmaps
load week1_imagesc
% Generate a heatmap ?image?
imagesc(im)
colorbar 
% Change the ?range of interest?
figure 
imagesc(im,[0.2 0.7], colorbar)
% Change color scale
colormap hot
help colormap

% Can define own colormap
c=colormap hot;
cmap = c(1:15:end,1:3);
colormap(cmap)

%% Interpolated heatmaps
close; z=rand(8,8);  figure; 
%? standard, non interpolated 
subplot(2,2,1);  imagesc(z); 
%? heatmap version, with interpolation and with contour lines turned off.
subplot(2,2,2);  [~,h] = contourf(flipud(z)); set(h,'linecolor','none');

%% Saving results for papers
% print figure to pdf
print -dpdf figure1
% eval
x='y=3'; eval(x) %? y=3;
printtxt = ['print -dpdf ',fname]; eval(printtxt);
save filename x y z
save('filename', 'x','y','z'); 

% Script vs. Function 



%%
t=0:0.1:1;
p=[1 2]';
v1 = [2 -1]';
x=[];
for k=1:length(t)
x(:,k)=p+t(k)*v1
end

%% data sets for PS1
% ps1_q1
x=round(rand(3,4,4)*10); 
save ps1_q1 x

% ps1_q2
clear all
x1= [1 44 7 3 99 21];  
x2 = round(rand(5,4)*10); 
save ps1_q2 x1 x2

% ps1_q3
clear all
x=[1 2 3 4; 5 6 7 8; 9 10 11 12];

x2(:,:,1) = [1 2 3 4; 5 6 7 8; 9 10 11 12]*3;
x2(:,:,2) = [1 2 3 4; 5 6 7 8; 9 10 11 12]-1;

x3 (:,:,1) = [9 10 11;12 13 14];
x3 (:,:,2) = [1 2 3;4 5 6];
save ps1_q3 x x2 x3

%% switch-case
switch x
    case '>7'
        'boo'
end
