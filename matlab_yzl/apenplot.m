% foo.m
%
% This m-file shows an example of how to use ApEn function
% 
% More specifically, it generates three simulated data with different
% complexity (sine, chirp, and Gaussian noise), and plots the ApEn values
% with varying r

%-------------------------------------------------------------------------
% coded by Kijoon Lee, kjlee@ntu.edu.sg
% Mar 21st, 2012
%-------------------------------------------------------------------------

m = 5;      % embedded dimension
tau = 1;    % time delay for downsampling
data;

% calculate standard deviations
sd = std(data);
% specify the range of r
rnum = 50;
result = zeros(3,rnum);

% main calculation and display
figure
for i = 1:rnum
    r = i*0.02;
    result(1,i) = ApEn(m, r*sd, data, tau);
end

r = 0.02*(1:rnum);
plot(r,result(1,:),'o-')
axis([0 rnum*0.02 0 1.05*max(result(:))])
xlabel r

