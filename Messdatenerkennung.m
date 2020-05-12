function Messdatenerkennung(handles)

auswertungordnertemp = handles.auswertungordnertemp;
messung = handles.messung;
currentfolder = cell2mat(fullfile (auswertungordnertemp,messung));
handles.currentfolder = currentfolder;
mess_folder = handles.mess_folder;
ordner = handles.ordner;
chipname = strcat(cell2mat(ordner),'-',cell2mat(messung));

%% Überprprüfen ob Einzelmessung vorhanden sind und diese dann verschieben (Krohne-System)
if strncmpi(handles.system_choice,'Krohne',6)==1
    % Die ersten 20 Messungen überprüfen auf Veränderung der Masse
    mess_txt = dir(currentfolder);
    mess_txt = mess_txt(~ismember({mess_txt.name},{'.' '..'}));
    delimiter = '\t';
    startRow = 20;
    formatSpec = '%*s%f%*s%[^\n\r]';
    
    if size(mess_txt,1)<20
        massen_array = cell(1,size(mess_txt,1));
        for a = 1:size(mess_txt,1)
            fileID = fopen(fullfile(currentfolder,mess_txt(a).name),'r');
            textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
            dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
            fclose(fileID);
            massen_array(1,a) = dataArray(1,1);
        end
    else
        massen_array = cell(1,20);
        for a = 1:20
            fileID = fopen(fullfile(currentfolder,mess_txt(a).name),'r');
            textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
            dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);
            massen_array(1,a) = dataArray(1,1);
            fclose(fileID);
        end
        
        
    end
    if size(mess_txt,1)==1
        disp('Nur eine Messung vorhanden')
    elseif isequal(massen_array{:}) == 1
        disp('Keine Einzelmessungen vorhanden')
    else
        if size(mess_txt,1)<20
            loop = 1:size(mess_txt,1)-1;
            loop = sort(loop,'descend');
            for a = loop
                check_diff = sum(massen_array{1,a}-massen_array{1,end});
                if check_diff~=0
                    check = a;
                    break
                end
            end
        else
            loop = sort(1:19,'descend');
            for a = loop
                check_diff = sum(massen_array{1,a}-massen_array{1,end});
                if check_diff~=0
                    check = a;
                    break
                end
            end
        end
        
        %% Einzelmessungen auswerten und aussortieren
        for a = 1:check
            txt_file = fullfile(currentfolder,mess_txt(a).name);
            handles.txt_file = txt_file;
            handles.txt_einzel = mess_txt(a).name;
            Einlesen_Krohne_Einzel(handles)
        end
            
        
    end
    
else
    %% Überprprüfen ob Einzelmessung vorhanden sind und diese dann verschieben (RUB-System)
    if size(dir(fullfile(currentfolder,'einzel_Messung*')),1) >= 1
        Einlesen_RUB_Einzel(handles)
    else
        disp('Keine Einzelmessungen vorhanden')
        
    end
end

f = waitbar(0.33,'Auswertung läuft...');
fullpfad = fullfile(cell2mat(auswertungordnertemp),cell2mat(messung));
pfad = fullpfad;
handles.fullpfad = fullpfad;
handles.pfad = pfad;
handles.auswertungordnertemp = auswertungordnertemp;
handles.messung = messung;
%% Überprüfen um was für eine Messung es sich handelt WF oder LZ oder Krohne Messung
if strncmpi(handles.system_choice,'Krohne',6)==1
    %% Auswertung der Krohne Messungen
    handles.currentfolder = currentfolder;
    handles.f = f;
    Einlesen_Krohne_Langzeit(handles);
elseif strncmpi(messung,'LZ',2)==1
    %% Auswertung der Langzeitmessung RUB
    clearvars -except auswertungordnertemp eventdata messung handles hObject f
    f = waitbar(0.35,f,'Auswertung läuft...');
    handles.f = f;
    Einlesen_RUB_Langzeit(handles)
    waitbar(.66,f,'Messgenauigkeit wird bestimmt...');
    
elseif strncmpi(messung,'WF',2)==1
    %% Wanderfeldauswertung
    waitbar(0.45,f,'Auswertung läuft...');
    set(handles.anzeigewfpanel,'visible','on')
    clearvars -except auswertungordnertemp messung eventdata handles hObject f
    handles.f = f;
    Einlesen_RUB_Wanderfeld(handles)
else
    errordlg('Keine Kompatibilität der Messdaten für die Auswertung')
end %Ende der If-Bed.

fullpfad = fullfile(cell2mat(auswertungordnertemp),cell2mat(messung));
%% Überprüfen ob Temperaturauswertung durchgeführt werden soll
datei = dir(fullfile(fullpfad,'Temperaturmessung*.txt'));
% Überprüfen ob Temperaturmessung vorhanden ist
if size(datei,1)==0
    disp('Keine Temperaturmessung vorhanden')
else
    Auswerten_Temperatur(handles)
end

%% Überprüfen ob Chiptestauswertung durchgeführt werden soll
folder = fullfile(cell2mat(auswertungordnertemp),cell2mat(messung));
handles.folder = folder;
chiptestfileEEX = dir(fullfile(folder,'*EEX*.txt'));
if size(chiptestfileEEX,1)==0
    disp('Keine Chiptest Dateien vorhanden')
else
    Auswerten_Chiptest(handles)
end


waitbar(.90,f,'Daten werden geladen...');
close(f)


