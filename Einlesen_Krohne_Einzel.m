function Einlesen_Krohne_Einzel(handles)

currentfolder = handles.currentfolder;
guiversion = handles.guiversion;
txt_file = handles.txt_file;
txt_einzel = handles.txt_einzel;

%% Einstellungen auslesen
fileID = fopen(txt_file,'r');
delimiter = '\t';
endRow = 18;
formatSpec = '%s%[^\n\r]';
dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', delimiter);
einstellungen = dataArray{1,1};
fclose(fileID);

%% Auslesen der Masse
fileID = fopen(txt_file,'r');
delimiter = '\t';
startRow = 20;
formatSpec = '%f%f%f%[^\n\r]';

%% Auslesen der Werte
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
Masse = dataArray{1,2};
fclose(fileID);


fileID = fopen(txt_file,'r');
delimiter = '\t';
startRow = 20;
formatSpec = '%f%f%f%[^\n\r]';
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
Stromstaerke = dataArray{1,3};
Frequenz = dataArray{1,1};

%Zeit aus TXT-Namen auslesen
mess_time_year = txt_einzel(1:4);
mess_time_mounth =  txt_einzel(5:6);
mess_time_day = txt_einzel(7:8);
mess_time_h = txt_einzel(10:11);
mess_time_min = txt_einzel(12:13);
mess_time_s = txt_einzel(13:14);
mess_time = [mess_time_day,'.',mess_time_mounth,'.',mess_time_year,' ',mess_time_h,':',mess_time_min,':',mess_time_s];
fclose(fileID);

%Systemdruck aus txt auslesen
startRow = 13;
endRow = 13;
formatSpec = '%s%*s%*s%[^\n\r]';
fileID = fopen(txt_file,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray2 = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
systempressure_temp = regexp(dataArray2{1,1},'\d*','Match');
systempressure_temp = str2num(strcat(systempressure_temp(1),'.',systempressure_temp(2)));
systempressure = systempressure_temp;

formatIn = 'dd.mmm.yyyy HH:MM:SS';
mess_time_num = zeros(1,2);
mess_time_num(1,2) = datenum(mess_time,formatIn).';
Ergebnissetemp = [Masse,Stromstaerke];
Ergebnisse = [mess_time_num;Ergebnissetemp];
chip = einstellungen{1,1};

savename = txt_file(1:end-4);
savename = [savename,'.mat'];
handles.matfile = savename;
corfak = einstellungen{11,1};
corfak = str2num(cell2mat(regexp(corfak,'\d*','Match')));
save(savename,'Ergebnisse','chip','Masse','einstellungen','Frequenz','mess_time','mess_time_num','Stromstaerke','systempressure','corfak','guiversion')
Auswerten_Einzel(handles)