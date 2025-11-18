 
fs = 1000;
N = 20;
bp = fir1(N,[30 450]/(fs/2), 'bandpass');
lp = fir1(N,4/(fs/2),'low');