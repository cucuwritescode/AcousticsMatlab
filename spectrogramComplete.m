function spectrogramComplete(filename,frame_size, maxfreq, loglin, dbmin)
% generate a spectrogram for:
% the first channel of the audio in filename
% frame_size sets the frame size. This function uses a hann window and 25% overlap
% maxfreq determines the maximum frequency to plot to
% loglin is an optional input - set as 'lin' to plot linear frequency axis and
% set as 'log' to plot logarithmic
% dbmin sets the minimum dbvalue to plot down to (e.g. is dBmin = -100 then the
% spectrogram will plot from 0dB down to 100dB)

% check loglin input 
if strcmp(loglin,'lin') == 0
    if strcmp(loglin,'log') == 0
        error('Please specify input loglin. Input ''log'' for logarithmic frequency axis and ''lin'' for linear frequency axis');
    end
end

% read in audio file. only use channel 1
[x,fs] = audioread(filename);
x = x(:,1);

Ninput = length(x); % The number of samples in the input signal
step_size = frame_size/2; % For 50% overlap
w = window(@hann, frame_size);  % Generate the Hann window to apply to a frame
Nframes = floor((Ninput-frame_size) / step_size); % calculate number of frames

% create an empty  array and time and frequency vectors
spect_image = zeros(frame_size/2+1, Nframes);
t = linspace(0,Ninput/fs,Nframes);
f = linspace(0,fs/2,frame_size/2+1);

% Generate spectra one frame at a time
for n = 1 : Nframes
    % Isolate the current frame of the input vector x
    x_frame = x(1+(n-1)*step_size:(n-1)*step_size+frame_size);
    % Apply the window to the current frame of the input vector x
    windowed = w.*x_frame;
    % Calculate magnitude spectrum in dBs 
    winSpec = 20*log10(abs(fft(windowed)));
    % Add spectrum below fs / 2 to spectrogram matrix
    spect_image( : , n) = winSpec(1:frame_size/2+1);
end

spect_image = spect_image-max(spect_image(:)); % set 0dB ref to maximum spect_image value
spect_image(spect_image<dbmin) = dbmin; % remove bin data below dbmin

% viewing options below - note that surf will not print as a scalable pdf,
% and imagesc will not plot with a logarithmic axis
surf(t, f, spect_image) % Plot image as 3D surface
% imagesc(t, f, spect_image)


if strcmp(loglin,'log') == 1
    set(gca,'YScale','log');
    disp('Plotting with logarithmic frequency axis')
elseif  strcmp(loglin,'lin') == 1
    disp('Plotting with linear frequency axis')
end

xlabel('Time (s)')
ylabel('Frequency (Hz)')
shading interp % set shading to interp for correct plotting
axis xy % Set origin of axis scales to bottom left corner
axis([0 max(t) 0 maxfreq]); % plot entire spectrogram in time up to determine maxfreq
view(0,90) % set view angle

% set the colormap for the spectrogram
colormap(colormapgen())
colorbar % Turn on a colour bar scale key
c = colorbar; % Get the colorbar handle
ylabel(c, 'Magnitude (dB)') % Use the handle to label the colorbar (sideways!)
title(strcat(filename,{' - '},'Spectrogram'), 'Interpreter', 'none');
view(0,90)
end

% function below generates a colormap for the spectrogram
function [cmapspec1] = colormapgen()
R = 0:1/255:1;
G = [zeros(1,206),0:1/49:1];
B = 0:1/255:1;
cmapspec1 = [R',G',B'];

end