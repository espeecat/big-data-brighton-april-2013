clc % clear command prompt
clear all % clear all previous data
close all % close all figure
sampleFreq=40; % 40Hz
Ts= 1/sampleFreq;
L = 500; % Length of signal 
t = (0:L-1)*Ts; % 1000 time points
 
NFFT = 2^nextpow2(L);
f = sampleFreq/2*linspace(0,1,NFFT/2+1);
 
% (could be x) 0 to 3s
f1=1; %frequency in cycles per second (Hertz)
f2=3;
f3=7;

 
y1=2*sin(2*pi*f1*t); % Observations or data at each interval t
y2=4*sin(2*pi*f2*t);
y3=6*sin(2*pi*f3*t);


figure
N =8; %fontsize
thk= 2;

% time series
subplot(4,1,1)
plot(t,y1, 'r', 'LineWidth',thk);  % plot the data
axis([0,6,-10,10])
xlabel('Time (s)')
 set(gca,'FontSize',N)

subplot(4,1,2)
plot(t,y2 ,'r', 'LineWidth',thk);  % plot the data
axis([0,6,-10,10])
xlabel('Time (s)')
 set(gca,'FontSize',N)

subplot(4,1,3)
plot(t,y3 ,'r', 'LineWidth',thk);  % plot the data
axis([0,6,-10,10])
xlabel('Time (s)')
 set(gca,'FontSize',N)
 
ytotal=y1+y2+y3;
subplot(4,1,4)
plot(t,ytotal ,'r', 'LineWidth',thk);  % plot the data
axis([0,6,-10,10])
xlabel('Time (s)')
 set(gca,'FontSize',N)

% FFTs
figure
Y1 = fft(y1 , NFFT);
Y2 = fft(y2 , NFFT);
Y3 = fft(y3 , NFFT);
YT = fft(ytotal,NFFT);

subplot(4,1,1)
plot(f(1:L/5),abs(Y1(1:L/5)) ,'r', 'LineWidth',thk);
axis([0,8,0,2000])
xlabel('Frequency (Hz)')
 set(gca,'FontSize',N)


subplot(4,1,2)
plot(f(1:L/5),abs(Y2(1:L/5)) ,'r', 'LineWidth',thk);
axis([0,8,0,2000])
xlabel('Frequency (Hz)')
 set(gca,'FontSize',N)


subplot(4,1,3)
plot(f(1:L/5),abs(Y3(1:L/5)) ,'r', 'LineWidth',thk);
axis([0,8,0,2000])
xlabel('Frequency (Hz)')
set(gca,'FontSize',N)

subplot(4,1,4)
plot(f(1:L/5),abs(YT(1:L/5)) ,'r', 'LineWidth',thk);
axis([0,8,0,2000])
xlabel('Frequency (Hz)')
 set(gca,'FontSize',N)



% Not using this
%{
figure
axis([0,6,-10,10])
subplot(4,1,2)
plot(t,y2);  % plot the data
axis([0,6,-10,10])

subplot(4,1,3)
plot(t,y3);  % plot the data
axis([0,6,-10,10])

ytotal=y1+y2+y3;
subplot(4,1,4)
plot(t,ytotal);  % plot the data
axis([0,6,-10,10])





ytotal =y1+y2+y3;
Y3 = fft(ytotal,NFFT);
subplot(4,1,2)
 
 
plot(f(1:L/5),abs(Y3(1:L/5)));
 
 
plot(t,ytotal);  % plot the data
xlabel ('Time (seconds)'); %label the data
ylabel('Amplitude'); %
title('plot of y1+y2+y3')
ytotal =y1+y2+y3+y4;
Y4 = fft(ytotal,NFFT);
 
subplot(3,1,3)
 
plot(t,ytotal);  % plot the data
xlabel ('Time (seconds)'); %label the data
ylabel('Amplitude'); %
title('plot of y1+y2+y3+y4')
 
%figure
subplot(3,1,1)
plot(f(1:L/5),abs(Y2(1:L/5)));
ylabel('ABS Amp'); %
subplot(3,1,2)
plot(f(1:L/5),abs(Y3(1:L/5)));
ylabel('ABS Amp'); %
subplot(3,1,3)
plot(f(1:L/5),abs(Y4(1:L/5)));
xlabel ('Frequency (Hz)'); %label the data
ylabel('ABS Amp'); 
%}
