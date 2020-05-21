function Auswerten_Chiptest(handles)

%% Chiptest Auswertung Test Änderung
folder = handles.folder;
chiptestfileEEX = dir(fullfile(folder,'*EEX*.txt'));

for a = 1:size(chiptestfileEEX,1)
%% Auslesen der Einstellungen
chiptestmess = fopen(fullfile(folder,chiptestfileEEX(a).name),'r');
einstellungentemp = textscan(chiptestmess,'%s %f','Delimiter',';');
einstellungentemp = einstellungentemp{1,1}(1:24,1);
einstellungenEEX(:,a) = einstellungentemp;
fclose(chiptestmess);
chiptestmess = fopen(fullfile(folder,chiptestfileEEX(a).name),'r');
delimiter = '\t';
startRow = 25;
endRow = 205;
formatSpec = '%f%f%[^\n\r]';

%% Auslesen der EEX Daten
textscan(chiptestmess, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(chiptestmess, formatSpec,'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
chiptestEEX(:,a) = dataArray{1,2};

fclose(chiptestmess);
save(fullfile(folder,'Chiptest_EEX.mat'),'chiptestEEX','einstellungenEEX')

end
% end


chiptestfileEF = dir(fullfile(folder,'*EF*.txt'));

if size(chiptestfileEF,1)==0
    disp('Keine Chiptest Dateien vorhanden')
else

for a = 1:size(chiptestfileEF,1)
%% Auslesen der Einstellungen
chiptestmess = fopen(fullfile(folder,chiptestfileEF(a).name),'r');
einstellungentemp = textscan(chiptestmess,'%s %f','Delimiter',';');
einstellungentemp = einstellungentemp{1,1}(1:24,1);
einstellungenEF(:,a) = einstellungentemp;
fclose(chiptestmess);
chiptestmess = fopen(fullfile(folder,chiptestfileEF(a).name),'r');
delimiter = '\t';
startRow = 25;
endRow = 205;
formatSpec = '%f%f%[^\n\r]';

%% Auslesen der EEX Daten
textscan(chiptestmess, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(chiptestmess, formatSpec,'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
chiptestEF(:,a) = dataArray{1,2};

fclose(chiptestmess);
save(fullfile(folder,'Chiptest_EF.mat'),'chiptestEF','einstellungenEF')

end
end
