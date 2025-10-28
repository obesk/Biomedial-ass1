load('ES2_emg.mat');  % carica la struct ES2_emg

time = seconds(ES2_emg.time);  % converte da numerico a duration
signals = ES2_emg.signals;

TT1 = timetable(time, signals(:,1), 'VariableNames', {'Segnale1'});
TT2 = timetable(time, signals(:,2), 'VariableNames', {'Segnale2'});
TT3 = timetable(time, signals(:,3), 'VariableNames', {'Segnale3'});
TT4 = timetable(time, signals(:,4), 'VariableNames', {'Segnale4'});

% (facoltativo) salva tutto in un nuovo file
save('ES2_emg_timetables.mat', 'TT1', 'TT2', 'TT3', 'TT4', '-v7.3');
