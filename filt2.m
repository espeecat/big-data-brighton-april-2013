% http://www.codeproject.com/Articles/317054/Simple-FFT-and-Filtering-Tutorial-with-Matlab
clear all; 
clc; 
close all; 
f=10; 
A=5; 
Fs=f*100;
Ts=1/Fs; 
t=0:Ts:10/f;
L= length(t);
NFFT = 2^nextpow2(L);
x0=A*sin(2*pi*f*t); 
x1=A*sin(2*pi*(60)*t); 
x2=A*sin(2*pi*(260)*t); 
x=x0+x1+x2;
figure
subplot(3,1,1)
plot(t(1:L/2),x(1:L/2)) 
F=fft(x, NFFT); 
f = Fs/2*linspace(0,1,NFFT/2+1);
subplot(3,1,2)
%plot( abs(F(1:100)))

plot(f(1:500),abs(F(1:500)));
xlabel('Frequency Hz.')


F2=zeros(NFFT,1); 
F2(1:21)=F(1:21);   
xr=ifft(F2); 
subplot(3,1,3)
Lt=200;
plot(t(1:Lt), 2*real(xr(1:Lt)), '--b','LineWidth',2); % 2 x as only considering +ve freqs
hold on
plot(t(1:Lt) , x(1:Lt),  ':r','LineWidth',2);
legend('original data', 'filtered data')

grid on
xlabel('Time (s)')
ylabel('Amplitude')
%title('Comparison of original and filtered data')

figure

Lt=900;
plot(t(1:Lt), 2*real(xr(1:Lt)), '--b','LineWidth',3); % 2 x as only considering +ve freqs
hold on
plot(t(1:Lt) , x(1:Lt),  ':r','LineWidth',1);
legend('filtered data','original data')

grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Comparison of original and filtered data')
axis([0 0.5 -15 15])
 