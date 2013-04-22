% Load web analytics from Excel
%

% There's tidy!
clc
clear all; 
close all

% load 2 column data from sheet1
data = xlsread('sd1.xlsx','sheet1');
% quick plot
% plot(data(:,1), data(:,2))

hours = data(:,1);
visits =  data(:,2);
meanVisits = mean(visits);
visits = visits - meanVisits;

% GA gives you hours as integers so need to add
% them to the start date
startDate = datenum('22-Mar-2013 00:00:00'); % midnight.

dates = addtodate(startDate, -7, 'hour');
% datestr(dates)

dateTime  = zeros(1,length(hours)); % pre-allocate
% loop through
for i=1:length(hours)
  hour = hours(i); % integer  0 1 2 3..
  dateTime(i) =  addtodate(startDate, hour, 'hour');
  %datestr(dateTime);
end

% plot with date on X axis 
% date format  http://www.mathworks.co.uk/help/matlab/ref/datetick.html#inputarg_dateFormat
%plot(dateTime,visits);
%datetick('x','dd-mmm')


NFFT = 2^(nextpow2(length(visits)))
FF =fft(visits , NFFT);

X1 =1
X2=10;

[num idx]  = max(FF(1:60))
plot(abs(FF(X1:X2)))
grid on
figure
X1 =1
X2=260;
plot(abs(FF(X1:X2)))
grid on



% looks like a peak at point 45
% could use max to pick out but happy to grab it manually

peak1=44; % go 1 or 2 each side and IFFT
zero1 = zeros(1,NFFT); % pre-allocate
zero1(peak1-2:peak1+2) = FF(peak1-2:peak1+2); % just grab 1 or 2 side of FFT
% ifft
ga1 = ifft(zero1); % IFFT to get part back
ga1 =2* real (ga1); % bound to be some imaginary bits -just ingore -numerical error!

%get second peak 60-100

[value peak2] = max(abs(FF(60:100)));
peak2=60+peak2-1;
zero2 = zeros(1,NFFT); % pre-allocate
zero2(peak2-2:peak2+2) = FF(peak2-2:peak2+2); % just grab 1 or 2 side of FFT
% ifft
ga2 = ifft(zero2); % IFFT to get part back
ga2 =2* real (ga2); % bound to be some -ve bits -just ingore -numerical error!

%get third peak 150-200

[value peak3] = max(abs(FF(150:200)));
peak3=150+peak3-1;
zero3 = zeros(1,NFFT); % pre-allocate
zero3(peak3-2:peak3+2) = FF(peak3-2:peak3+2); % just grab 1 or 2 side of FFT
% ifft
ga3 = ifft(zero3); % IFFT to get part back
ga3 =2* real (ga3); % bound to be some -ve bits -just ingore -numerical error!

% lower peaks 2-3 and 6-8

peak4=2;
zero4 = zeros(1,NFFT); % pre-allocate
zero3(peak4:peak4+1) = FF(peak4:peak4+1); % just grab 1 or 2 side of FFT
% ifft
ga4 = ifft(zero4); % IFFT to get part back
ga4 =2* real (ga4); % bound to be some -ve bits -just ingore -numerical error!


% peaks 6-8
peak5=6;
zero5 = zeros(1,NFFT); % pre-allocate
zero5(peak5:peak4+2) = FF(peak5:peak4+2); % just grab 1 or 2 side of FFT
% ifft
ga5 = ifft(zero5); % IFFT to get part back
ga5 =2* real (ga5); % bound to be some -ve bits -just ingore -numerical error!

figure
% plot length
x1 =500;
x2=700;

plot(dateTime(x1:x2) , visits(x1:x2),'-.r')

hold on
plot(dateTime(x1:x2) ,  ga1(x1:x2))

plot(dateTime(x1:x2) ,  ga2(x1:x2))
plot(dateTime(x1:x2) ,  ga3(x1:x2))

%plot(dateTime(x1:x2) ,  ga4(x1:x2))
% plot(dateTime(x1:x2) ,  ga5(x1:x2))

% axis([735320 735340 -600 700 ])
% axis([735330 735340 -600 900 ])
% axis([735336 735340 -600 900 ])
%plot(dateTime,visits);
%datetick('x','dd-mmm')

%xax = linspace(735336, 735340, 24);

axis([datenum('04-12-2013', 'mm-dd-yyyy') datenum('04-20-2013', 'mm-dd-yyyy') -600 900])

%xax = linspace(datenum('04-12-2013 00:00:00', 'mm-dd-yyyy'),  datenum('04-20-2013', 'mm-dd-yyyy'), 8);

xax = linspace(datenum('04-12-2013'),  datenum('04-20-2013'), 12);
datetick('x','HHPM','keeplimits')


set(gca, 'XTick', xax);


figure
% plot length
plot(dateTime , visits,'r', 'LineWidth',4)

hold on
% sinusoids
x1=1;
x2=740;
plot(dateTime(x1:x2) ,  ga1(x1:x2), '--b','LineWidth',3)

plot(dateTime(x1:x2) ,  ga2(x1:x2),':b','LineWidth',3)
%plot(dateTime(x1:x2) ,  ga3(x1:x2),'--y','LineWidth',2)
% axis([datenum('04-15-2013', 'mm-dd-yyyy') datenum('04-20-2013', 'mm-dd-yyyy') -600 900])

axis([datenum('04-12-2013 00:00:00') datenum('04-16-2013 00:00:00') -600 1000])

%xax = linspace(datenum('04-12-2013 12:00:00'),  datenum('04-20-2013 12:00:00'), 3);
%xax = linspace(datenum('04-15-2013'),  datenum('04-20-2013'), 12);
%datetick('x','HHPM','keeplimits')

datetick('x','HHPM','keeplimits')
%xax = linspace(datenum('04-12-2013 00:00:00),  datenum('04-20-2013 00:00:00'), 8);

legend('Original Data','lunchtime rush','unidentified')
xlabel('Time')
ylabel('Number of Visits')
title('Visitors to a Learning Site')    

grid on

figure
% plot length
plot(dateTime , visits,'r', 'LineWidth',2)
xlabel('Date')
ylabel('Number of Visits')
title('Visitors to a Learning Site')
xax = linspace(datenum('04-01-2013 00:00:00'),  datenum('04-20-2013 00:00:00'), 21);
%datetick('x','dd-mmm',xax)
%axis([datenum('04-01-2013 00:00:00') datenum('04-22-2013 00:00:00') -600 1000])
set(gca,'XTick',xax)
datetick('x','dd-mmm')
axis([datenum('04-01-2013 00:00:00') datenum('04-22-2013 00:00:00') -600 1000])




