%Program for removing silence from speech signal
clc
close all;
clear all;
files = dir('recording wav\sentence\*.wav');
i = 1;
for file = files'
        fn = strcat('recording wav\sentence\',file.name);
        [data{i},sr] = audioread(fn);
        i = i+1; 
end
fs=16000;
bits=16;
channel=1;
mkdir sentence;
BaseName='194102311_sentence_';
for k1=1:25
filename = ['sentence\',BaseName,num2str(k1),'.wav'];
signal_with_silence = data{k1};
%Assigning values for creating frames
fs=16000;
frame_duration=0.01;
frame_len = frame_duration*fs;
N=length(signal_with_silence);
num_frames=floor(N/frame_len);
new_sig=zeros(N,1);
count=0;
%Creating Frames using for loop
for k = 1 : num_frames
    frame = signal_with_silence((k-1)*frame_len+1 : frame_len*k);
    max_val = max(frame);
    
    if (max_val>0.0)
        count = count + 1;
        new_sig((count-1)*frame_len+1 : frame_len*count) = frame;
    end
end
%Removing the ending zeros from signal without silence
signal_without_silence=new_sig(new_sig~=0);


audiowrite(filename,signal_without_silence, fs);
end
