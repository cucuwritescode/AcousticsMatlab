function waveformplot(filename, start_time, end_time)
    % plotea la onda del primer canal del input file especificado por el
    % nombre del archivo 
    % filename. Allows optional specification of start and end times for the plot.
    %tercera modificacion, 
    %if the file is stereo, both channels are plotted using subplot.
    
    %leer el archivo de audio 
    [x, fs] = audioread(filename);
    x = x(:,1);  % Use only the first channel
    
    %calculate the time step (t) and calculate time axis of the plot
    t = 1 / fs;
    L = length(x);
    timeaxis = (0:L-1) * t;
    
    %handle start_time and end_time inputs
    if nargin < 2  %if no start_time is provided, set it to 0
        start_time = 0;
    end
    if nargin < 3  %if no end_time is provided, set it to the length of the signal
        end_time = max(timeaxis);
    end
    
    %convert start_time and end_time to corresponding sample indices
    start_sample = round(start_time * fs);
    end_sample = round(end_time * fs);
    
    %start_sample and end_sample are within the valid range
    start_sample = max(start_sample, 1);  %minimo es uno
    end_sample = min(end_sample, L);  %maximo la longitud de la senal
    %chequear si el audio es stereo (2 canales)
    num_channels = size(x, 2);  %chequear numero de canales, 2= stereo
    
    if num_channels == 2  %audio stereo
        %plotear canal de la izquierda (primer canal)
        subplot(2, 1, 1);  %subplot del primer canal
        plot(timeaxis(start_sample:end_sample), x(start_sample:end_sample, 1), 'b');
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(strcat(filename, ' - Left Channel'), 'Interpreter', 'none');
        axis([start_time end_time -1.1 1.1]);
        grid on;
        
        %plottear right channel (segundo canal)
        subplot(2, 1, 2);  %subplot para ek segundo canal
        plot(timeaxis(start_sample:end_sample), x(start_sample:end_sample, 2), 'r');
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(strcat(filename, ' - Right Channel'), 'Interpreter', 'none');
        axis([start_time end_time -1.1 1.1]);
        grid on;
        
    else  %audio mono (1 canal)
        %plotear ese canal solo (mismo que antes)
        plot(timeaxis(start_sample:end_sample), x(start_sample:end_sample, 1), 'k');
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(strcat(filename, ' - Waveform'), 'Interpreter', 'none');
        axis([start_time end_time -1.1 1.1]);
        grid on;
    end
    
    %plottear la onda
    plot(timeaxis(start_sample:end_sample), x(start_sample:end_sample), 'k');
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(strcat(filename, ' - Waveform'), 'Interpreter', 'none');
    axis([start_time end_time -1.1 1.1]);  %ajustar eje para que vaya con el rango de tiempo
    grid on;
end
