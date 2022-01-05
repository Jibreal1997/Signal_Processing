%%
%   Author: Jibreal Khan
%   Program: Running Mean time filter
%   Contact: jibrealkhan1997@gmail.com
%
%%

% Step1: Generating a random signal 
Fs = 1000; % Sampling Frequency
dt = 1/Fs; 
time  = 0:dt:3; % signal time
n     = length(time);
p     = 15; % poles for random interpolation

% noise level, measured in standard deviations
noiseamp = 5; 

% adding noise to the signal
ampl   = interp1(rand(p,1)*30,linspace(1,p,n));
noise  = noiseamp * randn(size(time));
signal = ampl + noise;

% initialize filtered signal vector with zeroes
filtsig = zeros(size(signal));

% implementing the running mean filter
k = 200; % filter window size =  k*2+1 , modify k to change the smoothness of the signal 
for i=k+1:n-k-1
    % each point is the average of k surrounding points
    filtsig(i) = mean(signal(i-k:i+k));
end

% compute window size in ms
windowsize = 1000*(k*2+1) / Fs;


% plot the noisy and filtered signals
figure(1), clf, hold on
plot(time,signal, time,filtsig, 'linew',2)

% draw a patch to indicate the window size
tidx = dsearchn(time',1);
ylim = get(gca,'ylim');
patch(time([ tidx-k tidx-k tidx+k tidx+k ]),ylim([ 1 2 2 1 ]),'k','facealpha',.25,'linestyle','none')
plot(time([tidx tidx]),ylim,'k--')

xlabel('Time (sec.)'), ylabel('Amplitude')
title([ 'Running-mean filter with a k=' num2str(round(windowsize)) '-ms filter' ])
legend({'Signal';'Filtered';'Window';'window center'})

zoom on

%% done.
