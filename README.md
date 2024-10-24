# AcousticsinMatlab
## Some matlab acoustics exercises solutions from the labs at University of York.
### A pdf file with all solutions can be found below 
[Matlab Acoustic Calculations Graphs.pdf](https://github.com/user-attachments/files/17503957/Matlab.Acoustic.Calculations.Graphs.pdf)
Working with Audio in MATLAB

Introduction	1
1. Writing an additive synthesis function	
2. Creating waveform plots	
3. Creating spectral plots	
4. Creating spectrograms	
5. Examining Impulse Responses	


**_Introduction_**
The aim of this lab is to give you more experience of using MATLAB to generate, import, analyse, and view audio. By the end of the lab you will have gained experience in generating audio signals and files, viewing waveform and spectral plots, and creating spectrograms of input audio. These are skills that will be essential in the completion of the acoustics assessment task for this module.

Completing this lab will allow you to create plots of the frequency content of different audio signals using the Fourier transform. In later lectures and labs we will revisit the fourier transform: the mathematics of it, how we can implement that in our code, and how we can handle the result in a useful manner. For now it will suffice to become familiar with using MATLAB’s FFT function and looking at the results.
1. **Writing an additive synthesis function**

Before you start on this lab, you should make sure that you have finished the Introduction to MATLAB. Once you have completed those exercises, you should end up with a MATLAB function that allows you to generate sine waves at a particular frequency, with a particular amplitude, sampling rate, and duration.

You should now write a function that allows you to perform additive synthesis. This function should allow a user to specify:
Sampling rate (or you can set this to always be 44.1 kHz)
Duration
Fundamental frequency
The frequencies of the harmonics to add
The amplitudes of the harmonics to add
The amplitude of the end result

Once you have written this function (ensuring it is fully and clearly commented), you should use it to generate square, triangle, and sawtooth waves. How many harmonics do you need in order to hear the results you expect? What does the waveform look like?

Once you have done this you should experiment with MATLAB’s audiowrite function and save some example waveforms as .wav files. Make sure you have a variety of waveforms saved with a variety of fundamental frequencies.

2. **Creating waveform plots**

   
Download the waveformplot.m function. This function has a single input variable (filename) which allows the user to specify a wav file to view the waveform of. Have a look at the function code. Can you make sense of what is going on?

Try using the function to view a variety of your saved waveforms. Since the function by default gives a view of the entire waveform, it is often hard to see useful detail. The axis command in MATLAB allows you to specify the axes limits to plot. Try using this function to change what you see to make more useful waveform plots.

You should now adjust the function to allow the user to specify the start and end points (in time) of the input audio that should be plotted. Use your extended function to examine different parts of your saved audio waveforms.

You will also notice that this function plots only a single channel of audio. If you have stereo audio you may want to view both channels. Some example stereo audio is available here but you can use any audio you wish. 

Adjust the function to use the subplot command in MATLAB to create a separate set of axes for each channel of the input audio.

3. **Creating spectral plots**

Download the freqspec.m function. As with waveformplot.m, this function has a single input which specifies the file to view in a spectral plot. This file is read into MATLAB and a fourier transform is applied. Due to the sampling theorem, only the frequency content below fs/2 is plotted (due to aliasing above the Nyquist frequency).

As before, read through the code and see if you can make sense of it. Use the function to view the spectra of the various waveforms you have created, and look at the example stereo audio as well. Can you relate the features you see to what you hear? How useful is the information presented to you?

Modify the function to allow the user to specify a time range of the input audio to analyse. How can you use this new functionality to examine different parts of an audio waveform? Experiment with the example audio and see what features you can find.

4. **Creating spectrograms**

You will now use a spectrogram to view the time and frequency features of these audio files. Download the spectrogramComplete.m function.

This function has the following syntax:

spectrogramComplete(filename,frame_size, maxfreq, loglin, dbmin)

The input arguments specify, respectively: the wav file to read in and view, the size of the frames of audio that will be analysed, the maximum frequency to plot up to, whether to plot linear or logarithmic frequency, and the minimum dB value to plot down to. Have a look through the function’s code. Can you make sense of what is going on?

We will start by looking at a sine wave at some frequency (say 1000Hz). Make this signal (if you haven’t already) and save it as a wav file (here it is called sin1k441.wav). Now input the following command:

spectrogramComplete('sin1k441.wav',512,22050,'lin',-80)

This command tells MATLAB to read in the sine wave audio file, and to create a spectrogram of it. The frame size is 512 samples, so our signal is being divided into small chunks of this length, and then each chunk is analysed to determine its frequency content. We are then plotting the results up to 22050 Hz (fs/2) with a linear frequency axis, and plotting magnitude values between 0dB (the maximum value in the analysed audio) and -80dB. The result should look like the spectrogram shown in Figure 1.



Once you have a spectrogram that looks like Figure 1, you should start experimenting with changing the input variables and looking at different audio files. You should try:
Changing the frame size variable (you should use powers of 2, e.g. 256, 512, 1024 etc). Try going from a very small value up to a very large one. How does this change the features you see in the spectrogram?
Changing the maximum frequency plotted. Where is it helpful to change this? You can also use the axis command after you’ve generated the spectrogram to change the three axes limits.
Comparing what you get with a linear frequency axis to what you get with a logarithmic frequency axis. Can you explain what is going on? Is one more useful than another?
Varying the minimum dB value to plot. How does this change the visual features of the spectrogram? Can this be misleading? Think about how this variable relates to the colours MATLAB uses. You can also try changing the colorbar variable to see how a different colour scheme changes what features are most prominent in the spectrogram.
Investigate the above for the waveforms you have created and other audio files. As before you can extend this function to create a separate spectrogram for each channel of input audio.

5. **Examining Impulse Responses**

Once you have completed the above, you should then use the functions to examine some example IRs. You can download these examples we looked at in the lecture, or go to www.openairlib.net for some other ones.

You should view the time and frequency domain features of these IRs and relate what you see to what you hear. Consider how the physical properties of each space would result in the presence of these features in each IR.


