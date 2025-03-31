function y=sigmoid(beta,x)
if isempty(beta)
    beta = [0 1 0.5 20]; %x range is 0 to 1
end
if nargin<2 | isempty(x)
    x=[0:0.05:1]; 
end
c=beta(1);
s=beta(2);
d=beta(3);
m=beta(4);

y = c + s./(1+exp(-(x-d)*m)); %standard sigmoid
% y = c + s*((x.^m)./(x.^m + d^m)); %Williford and Maunsell, 2006

% % y = c + s./(1+exp(-(x-d)*m)); standard sigmoid (~ logistic function)
% % y = c + s*((x.^m)./(x.^m + d^m)); %Williford and Maunsell, 2006

%generalized form: set c2=1; set e2=1 (e2 has to vary by orders of magnitude for big enough changes...)
%y = c + s./(1+exp(-(x-d)*m));
% c = intercept (the lowest asymptotic value of the sigmoid)
% s = steady state value
% d = lateral positioning and is in fact the point of maximal slope, i.e., 50% point. 
% m = slope parameter

%y = a+c1./(c2+e2*exp(-(x-e1)*m));
%e1 and e2: shift the sigmoid left-right. 
    % compared to when e1=-0.5, when e1 is +0.5, sigmoid gets shifted leftward.
    % compared to when e2=+0.5, when e2 is +50, sigmoid gets shifted righttward.
%m: controls the slope of the sigmoid. when |m|=20, the sigmoid is steeper than when |m|=5. 
%c1 and c2: determine the max/steady state value, such that ss value = c1/c2;
%a determines the lowest asymptotic value of the sigmoid

