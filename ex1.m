clear;
clc;

%% Loading data
S = load('es1_emg/ES1_emg.mat');

%% Raw EMG
raw_emg = S.Es1_emg.matrix(:,1)';

%% Filtered EMG
% Sample rate should be equal to sampling frequency (2000 or 1500?)
bpfilt = designfilt("bandpassfir", ...
    FilterOrder=100,CutoffFrequency1=30, ...
    CutoffFrequency2=450,SampleRate=2000);
filtered_emg = filtfilt(bpfilt, raw_emg);

%% Rectified EMG
rectified_emg = abs(filtered_emg);

%% Linear envelope
Fs = 2000;
LP = 5;
Wp = LP / (Fs/2);
[b, a] = butter(2, Wp, 'low');
lin_env_emg = filtfilt(b, a, rectified_emg);

%% Downsampling
downsampled_emg = downsample(lin_env_emg, 100);

%% Computing acceleration for movement signal
acc_data = S.Es1_emg.matrix(:,2:4);
atot = sqrt(sum(acc_data.^2, 2));

%% Plots
figure(1);

subplot(2,2,1);
plot(raw_emg);
hold on;
plot(filtered_emg);
hold off;
title("Raw EMG overlaid with filtered signal");

subplot(2,2,2);
plot(rectified_emg);
hold on;
plot(lin_env_emg);
hold off;
title("Rectified EMG overlaid with the envelope");

subplot(2,2,3);
plot(atot);
hold on;
plot(lin_env_emg/100);
title("Movement signal overlaid with the envelope signal");

%% Question A: Why is the down-sampling performed after the envelope computation?
% The downslamping loses information, so it's better to first calculate the 
% linear envelope and then downsample; moreover before downsampling, some
% frequencies needs to be removed, otherwise too much noise remains.

%% Question B: Based on the motion signal, when does the muscle activation commence in relation to the movement?
% The muscle activates when the acceleration start decreasing. 




