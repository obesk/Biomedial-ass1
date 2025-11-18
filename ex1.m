clear;
clc;

%Il filtro filtra abbastanza?
S = load('es1_emg/ES1_emg.mat');
bpfilt = designfilt("bandpassfir", ...
    FilterOrder=2,CutoffFrequency1=30, ...
    CutoffFrequency2=450,SampleRate=1500);
figure(6);
freqz(bpfilt);
raw_emg = S.Es1_emg.matrix(:,1)';
filtered_emg = filtfilt(bpfilt, raw_emg);
rectified_emg = abs(filtered_emg);

% num = bpfilt.Numerator;
% disp("[" );
% for i = num
%     disp(i);
% end
% 
% disp("]");

%figure(1);
%plot(raw_emg);
%hold on;
%plot(filtered_emg);
%hold off;

%va bene che il linear envelope sia 6 volte più piccolo in modulo?
LP = 4;
Wp = LP / 1000;
[F,E] = butter(2,Wp,"low");
lin_env_emg = filtfilt(F, E,rectified_emg);

downsampled_emg = downsample(lin_env_emg, 100);

% figure(2);
% plot(rectified_emg);
% hold on;
% plot(lin_env_emg);
% hold off;
% 
% 
% figure(3);
% subplot(2, 3, 1);
% plot(raw_emg);
% title("Raw");
% 
% subplot(2, 3, 2);
% plot(filtered_emg);
% title("Filtered");
% 
% subplot(2, 3, 3);
% plot(rectified_emg);
% title("Rectified");
% 
% subplot(2, 3, 4);
% plot(lin_env_emg);
% title("Linear Envelope");
% 
% subplot(2, 3, 5);
% plot(downsampled_emg);
% title("Downsampled");
% 
% figure(4);
% plot(lin_env_emg/100);
% hold on;
% plot(S.Es1_emg.matrix(:,2:4));

% 
% legend(S.Es1_emg.labels);

%Va bene questo modo di calcolare a tot?
% figure(5);
% a = S.Es1_emg.matrix(:,2:4);
% atot = sqrt(a(:,1).^2 + a(:,2).^2 + a(:,3).^2);
% plot(atot);
% hold on;
% plot(lin_env_emg/100);

% Question A: Why is the down-sampling performed after the envelope computation?
% 
% The downslamping loses information, so it's better to first calculate the 
% linear envelope and then downsample; moreover before downsample some
% frequencies needs to be removed, otherwise remains too much noise.

% Question B: Based on the motion signal, when does the muscle activation 
% commence in relation to the movement?
%
% When the muscle activates the acceleration decreases





