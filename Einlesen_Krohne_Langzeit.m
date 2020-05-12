function Einlesen_Krohne_Langzeit(handles)

currentfolder = handles.currentfolder;
guiversion = handles.guiversion;

mess_txt = dir(fullfile(handles.currentfolder,'*.txt'));
mess_txt = mess_txt(~ismember({mess_txt.name},{'.' '..'}));%unnötige Zeilen entfernen

%% Einstellungen auslesen
filename = fullfile(currentfolder,mess_txt(1).name);
fileID = fopen(filename,'r');
delimiter = '\t';
endRow = 18;
formatSpec = '%s%[^\n\r]';
dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', delimiter);
einstellungen = dataArray{1,1};
fclose(fileID);

%% Auslesen der Masse 
filename = fullfile(currentfolder,mess_txt(1).name);
fileID = fopen(filename,'r');
delimiter = '\t';
startRow = 20;
formatSpec = '%f%f%f%[^\n\r]';

%% Auslesen der Werte
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
Masse = dataArray{1,2};
fclose(fileID);
mess_time = strings(1,length(mess_txt));
for a = 1:length(mess_txt)
    filename = fullfile(currentfolder,mess_txt(a).name);
    fileID = fopen(filename,'r');
    delimiter = '\t';
    startRow = 20;
    formatSpec = '%f%f%f%[^\n\r]';
    textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
    Stromstaerke(:,a) = dataArray{1,3};
    Frequenz = dataArray{1,1};
    
    %Zeit aus TXT-Namen auslesen
    mess_time_year = mess_txt(a).name(1:4);
    mess_time_mounth =  mess_txt(a).name(5:6);
    mess_time_day = mess_txt(a).name(7:8);
    mess_time_h = mess_txt(a).name(10:11);
    mess_time_min = mess_txt(a).name(12:13);
    mess_time_s = mess_txt(a).name(13:14);
    mess_time(a) = [mess_time_day,'.',mess_time_mounth,'.',mess_time_year,' ',mess_time_h,':',mess_time_min,':',mess_time_s];
    fclose(fileID);
    
    %Systemdruck aus txt auslesen
    startRow = 13;
    endRow = 13;
    formatSpec = '%s%*s%*s%[^\n\r]';
    fileID = fopen(filename,'r');
    textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArray2 = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    fclose(fileID);
    systempressure_temp = regexp(dataArray2{1,1},'\d*','Match');
    if size(systempressure_temp,2)==0
        systempressure_temp = 0;
    else
        systempressure_temp = str2num(strcat(systempressure_temp(1),'.',systempressure_temp(2)));
    end
    systempressure(a)= systempressure_temp;

    
end
formatIn = 'dd.mmm.yyyy HH:MM:SS';
mess_time_num = datenum(mess_time,formatIn).';

%% Zusammenfügen der Daten in eine Große Matrix
mess_time_num_temp = zeros(1,length(mess_time_num)+1);
mess_time_num_temp(2:end) = mess_time_num;  
Ergebnissetemp = [Masse,Stromstaerke];
Ergebnisse = [mess_time_num_temp;Ergebnissetemp];

%% Messdauer in Stunden bestimmen
start_timenum = datevec(mess_time_num(1));
end_timenum = datevec(mess_time_num(end));
time_interval_in_hours = etime(end_timenum,start_timenum)/60/60;
time_interval_in_hours = round(time_interval_in_hours,1);
messdauer = time_interval_in_hours;
messdauer(messdauer==0)=[];

filename = [datestr(mess_time_num(1), 'dd-mmm-yyyy'),'_',num2str(messdauer),'h','_Auswertung','_Krohnesystem','.mat'];
save(fullfile(currentfolder,filename),'Ergebnisse','Masse','einstellungen','Frequenz','mess_time','mess_time_num','messdauer','Stromstaerke','systempressure','guiversion')


Auswerten_Langzeit(handles)