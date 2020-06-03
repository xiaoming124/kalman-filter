clc; close all;clear all

len=500;
row=1;

A=0.9;
C=1;
% t = 1:len;
% x = sin(2*pi*0.01*t);
for kk = 1:100

x = zeros(row,len);
y = zeros(row,len);

w = randn(row,len);
v = randn(row,len);

Q = w*w'/len;
R = v*v'/len;

xx = randn;
xe = randn;
Pkk = eye(row);

for ii=2:len
    xx(ii)=A*xx(ii-1)+w(ii);
    yy(ii)=C*xx(ii)+v(ii);
end

% for kk=2:len
%     Pkk = A*Pkk*A'+Q;
%     H = Pkk*C'*inv(C*Pkk*C'+R);
%     xe(kk) = A*xe(kk-1)+H*(yy(kk)-C*A*xe(kk-1));
%     Pkk = (eye(row)-H*C)*Pkk;
% end

for kk=2:len
    Pkk = A*Pkk*A'+Q;
    Pkk = inv(inv(Pkk)+conj(C')*inv(R)*C);
    H = Pkk*conj(C')*inv(R);
    xe(kk) = A*xe(kk-1)+H*(yy(kk)-C*A*xe(kk-1));
    
end

Err(kk,:) = abs(xe-xx);
end

figure,
subplot(211),plot(xx);
subplot(212),plot(yy);

figure;hold on;
plot(xx,'r');plot(xe,'g');
legend('xx','xe');

figure,
plot(db(mean(Err)));
axis([-inf, +inf, -inf, 5]);