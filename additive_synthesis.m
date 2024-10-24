%funcion de sintesis aditiva
function y=additive_synthesis(fs, duration, f0, harmonics_freqs, harmonics_amps, overall_amp)
%los inputs son fs=sampling rate, duration= la duracion de la onda en
%segundos
%f0 la frecuencia fundamental en hz, harmonics_freqs arreglo de frecuencias armonicas para agregar en hz 
%harmonic amps arreglo de amplitudes armonicas, overall amp el overall
%amplitude de la onda resultante

t=0:1/fs:duration; %vector duracion desde 0 con step size 1/fs
y=zeros(size(t)); %inicializar la senal 

for i=1:length(harmonics_freqs) %en este for agrego la fundamental y los armonicos
    freq=harmonics_freqs(i); %frecuencia armonica y su amplitud
    amp=harmonics_amps(i);

    y=y+amp*sin(2*pi*freq*t); %agregar el armonico a la senal

end


if max(abs(y)) ~= 0
    y = overall_amp * (y / max(abs(y)));  % Only normalize if max(abs(y)) is non-zero
end


