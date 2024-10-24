%esta funcion lee el primer canal del archivo de audio, computa el fft y
%normaliza el resultado en decibeles 
%el espectro se plotea en frecuencia y escala logaritmica entre 22 hz y
%22khz (Rango de audicion humana)
%el rango db esta entre -90 y 0 db
function freqspec(filename, start_time, end_time)
    % freqspec - This function plots the frequency spectrum of the first
    % channel of an audio file within the specified time range.
    
    %leer archivoe
    [x, fs] = audioread(filename);
    x = x(:,1); 
    
    %duracion totald e la senal
    total_duration = length(x) / fs;
    
    %manejar start_time y end_time inputs
    if nargin < 2  % If no start_time is provided, set it to 0
        start_time = 0;
    end
    if nargin < 3  % If no end_time is provided, set it to the total duration
        end_time = total_duration;
    end
    
    %convertir start_time y end_time para samplear indices
    start_sample = round(start_time * fs);
    end_sample = round(end_time * fs);
    
    %start_sample and end_sample are within valid range
    start_sample = max(start_sample, 1);  % minimo es uno
    end_sample = min(end_sample, length(x));  %maximo es longitud de la senal
    
    % Extract the portion of the audio to analyze
    x_segment = x(start_sample:end_sample);
    
    % Length of the extracted segment
    L = length(x_segment);
    
    % Apply FFT to the selected portion
    NFFT = 2^nextpow2(L);  % Get next power of 2 for efficient FFT
    Y = fft(x_segment, NFFT);
    
    % Compute magnitude in dB, normalized to max = 0 dB
    YdB = db(abs(Y(1:NFFT/2)) / max(abs(Y(1:NFFT/2))));
    
    % Create frequency axis values
    f = linspace(0, fs/2, NFFT/2);
    
    % Plot the spectrum with a logarithmic frequency axis
    semilogx(f, YdB, 'color', 'k');
    title(strcat(filename, {' - '}, 'Frequency Spectrum (', num2str(start_time), 's to ', num2str(end_time), 's)'), 'Interpreter', 'none');
    
    % Set -90 dB amplitude limit and frequency axis from 22 Hz to 22 kHz
    axis([22 22000 -90 1]);
    grid on;
    
    % Set frequency labels and ticks
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    set(gca, 'XTick', [22 100 1000 10000 20000]);
    set(gca, 'XTickLabel', {'22', '100', '1k', '10k', '20k'});
end
