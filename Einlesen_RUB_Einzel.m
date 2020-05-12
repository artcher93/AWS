function Einlesen_RUB_Einzel(handles)

currentfolder = handles.currentfolder;
auswertungordnertemp = handles.auswertungordnertemp;
txt_einzel = dir(fullfile(currentfolder,'*einzel*.txt'));
%% Auslesen der Daten
for a = 1:size(txt_einzel)
filename = fullfile(currentfolder,txt_einzel(a).name);
formatSpec = '%s%s%s';
delimiter = '\t';
fileID = fopen(filename);
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter);
fclose(fileID);

%% Als Matrix speichern
Masse = dataArray{1,1}(1:size(dataArray{1,2},1));
Masse = cellfun(@str2num,Masse);
Stromstaerke = str2num(cell2mat(dataArray{1,2}));
time = datenum(txt_einzel(1).date);
if size(dataArray{1,1},1)~=size(dataArray{1,1},2)
chip = dataArray{1,1}(end);
end
Ergebnisse = zeros(size(Masse,1)+1,2);
Ergebnisse(2:end,1)=Masse;
Ergebnisse(2:end,2)=Stromstaerke;
Ergebnisse(1,2)=time;

%% Speichern als Matfile
savename = txt_einzel(a).name;
savename = savename(1:end-4);
if size(dataArray{1,1},1)~=size(dataArray{1,1},2)
save(fullfile(currentfolder,[savename,'.mat']),'Ergebnisse','chip')
else
    save(fullfile(currentfolder,[savename,'.mat']),'Ergebnisse')
end 
  handles.matfile = fullfile(currentfolder,[savename,'.mat']);
  handles.txt_einzel = txt_einzel(a).name;
  Auswerten_Einzel(handles)
end






