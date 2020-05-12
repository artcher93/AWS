
function Einlesen_RUB_Langzeit(handles)
clearvars -except auswertungordnertemp eventdata messung handles hObject f
%% Einstellungen
% ordnerpfad = 'D:\OneDrive - ruhr-uni-bochum.de\Arbeit\MATLAB\';
% chip = 'Dauertest_20170224';
fullpfad = handles.fullpfad;
pfad = handles.pfad;
f = handles.f;
%% Messungen auslesen
ordnerliste = dir(fullpfad);
ordnerliste = ordnerliste(~ismember({ordnerliste.name},{'.' '..'}));

%% Messungen sortieren
[~, reindex] = sort(str2double(regexp({ordnerliste.name},'\d+','match','once')));
ordnerliste = ordnerliste(reindex);

%% Auswertung Überprüfen
ordnermess = dir(fullfile(fullpfad,'*l_20*.txt'));  %Daten mit messungen
checkmess = fopen(fullfile(fullpfad,ordnermess(1).name));
% Überprüfen wie viele Parameter es gibt und speichern
zahler = 0;
val = length(fgetl(checkmess));
while val~=0
    val = length(fgetl(checkmess));
    zahler = 1+zahler;
    if zahler >= 50
        val = 0;
        zahler=0;
    end
end


masse = textscan(checkmess,'%n %n %n');
masse = masse{1,1};
fclose(checkmess);

%% Auswertungsart bestimmen

%% Langzeitmessung mit Parametern in der Textfile
if zahler==19
    %parameter auslesen
    checkmess = fopen(fullfile(fullpfad,ordnermess(1).name),'r');
    einstellungen = textscan(checkmess,'%s %f','Delimiter',';');
    einstellungen = einstellungen{1,1}(1:zahler,1);
    
    %TXT-File mit Ergebnissen sortieren
    [~, reindex] = sort(str2double(regexp({ordnermess.name},'\d+','match','once')));
    ordnermess = ordnermess(reindex);
    
    % Zeit und Txtfiles auslesen
    messtime = zeros(1,length(ordnermess)+1);
    messtime(2:end) = [ordnermess.datenum];
    txtfiles = transpose({ordnermess.name});
    fclose(checkmess);
    
    %% Messdaten auslesen
    %Einstellungen zum Auslesen
    delimiter = '\t';
    startRow = 20;
    formatSpec = '%s%f%f%[^\n\r]';
    
    %Auslesen
    for a = 1:length(txtfiles)
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
        Ergebnissetemp = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);
        Ergebnissetemp = Ergebnissetemp{1,2};
        fclose(fileID);
        
        %Systemdruck auslesen
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        systempressure(a) = cell2mat(textscan(fileID,'SystemPressure= %f'));
        fclose(fileID);
        
        % Daten in Matrix speichern
        Ergebnisse(:,a) = Ergebnissetemp;
    end
    Ergebnisse = vertcat(messtime,horzcat(masse,Ergebnisse));
    
    
    
    
    
    %% Langzeitmessung mit Hytserese
elseif zahler==25
    waitbar(0.45,f,'Auswertung läuft...');
    %parameter auslesen
    checkmess = fopen(fullfile(fullpfad,ordnermess(1).name),'r');
    einstellungen = textscan(checkmess,'%s %f','Delimiter',';');
    einstellungen = einstellungen{1,1}(1:zahler,1);
    
    %TXT-File mit Ergebnissen sortieren
    [~, reindex] = sort(str2double(regexp({ordnermess.name},'\d+','match','once')));
    ordnermess = ordnermess(reindex);
    
    % Zeit und Txtfiles auslesen
    messtime = zeros(1,length(ordnermess)+1);
    messtime(2:end) = [ordnermess.datenum];
    txtfiles = transpose({ordnermess.name});
    fclose(checkmess);
    
    %% Messdaten auslesen
    %Einstellungen zum Auslesen
    delimiter = '\t';
    startRow = 26;
    formatSpec = '%s%f%f%[^\n\r]';
    
    %Auslesen
    for a = 1:length(txtfiles)
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
        Ergebnissetemp = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);
        Ergebnissetemp = Ergebnissetemp{1,2};
        fclose(fileID);
        
        %Systemdruck auslesen
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        systempressure(a) = cell2mat(textscan(fileID,'SystemPressure= %f'));
        fclose(fileID);
        
        % Daten in Matrix speichern
        Ergebnisse(:,a) = Ergebnissetemp;
    end
    Ergebnisse = vertcat(messtime,horzcat(masse,Ergebnisse));
    
    
    %% Langzeitmessung mit Ionenstärke
elseif zahler == 23
    waitbar(0.45,f,'Auswertung läuft...');
    %parameter auslesen
    checkmess = fopen(fullfile(fullpfad,ordnermess(1).name),'r');
    einstellungen = textscan(checkmess,'%s %f','Delimiter',';');
    einstellungen = einstellungen{1,1}(1:zahler,1);
    
    %TXT-File mit Ergebnissen sortieren
    [~, reindex] = sort(str2double(regexp({ordnermess.name},'\d+','match','once')));
    ordnermess = ordnermess(reindex);
    
    % Zeit und Txtfiles auslesen
    messtime = zeros(1,length(ordnermess)+1);
    messtime(2:end) = [ordnermess.datenum];
    txtfiles = transpose({ordnermess.name});
    fclose(checkmess);
    
    %% Messdaten auslesen
    %Einstellungen zum Auslesen
    delimiter = '\t';
    startRow = 24;
    formatSpec = '%s%f%f%[^\n\r]';
    
    %Auslesen
    for a = 1:length(txtfiles)
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
        Ergebnissetemp = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);
        Ergebnissetemp = Ergebnissetemp{1,2};
        fclose(fileID);
        
        %Systemdruck auslesen
        fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
        systempressure(a) = cell2mat(textscan(fileID,'SystemPressure= %f'));
        fclose(fileID);
        
        % Daten in Matrix speichern
        Ergebnisse(:,a) = Ergebnissetemp;
    end
    Ergebnisse = vertcat(messtime,horzcat(masse,Ergebnisse));
    
    %% Langzeitmessung ohne Parameter in Txt-File
elseif zahler == 0
    waitbar(0.45,f,'Auswertung läuft...');
    %Überprüfen ob param-file txt vorhanden ist und parameter auslesen
    paramfile = 'param_file.txt';
    file = dir(fullfile(fullpfad,paramfile));
    if size(file,1)~=0
        fileID = fopen(fullfile(fullpfad,paramfile),'r');
        einstellungen = textscan(fileID,'%s %f','Delimiter',';');
        einstellungen = einstellungen{1,1};
        fclose(fileID);
        
        %% Messdaten auslesen
        ordnermess = dir(fullfile(fullpfad,'*l_20*.txt'));  %Daten mit messungen
        
        % Ordner sortieren
        [~, reindex] = sort(str2double(regexp({ordnermess.name},'\d+','match','once')));
        ordnermess = ordnermess(reindex);
        
        %Erste Daten auslesen Masse, Zeit und Txtfiles
        checkmess = fopen(fullfile(fullpfad,ordnermess(1).name),'r');
        masse = textscan(checkmess,'%n %n %n');
        masse = masse{1,1};
        messtime = zeros(1,size(ordnermess,1)+1);
        messtime(2:end) = [ordnermess.datenum];
        txtfiles = transpose({ordnermess.name});
        fclose(checkmess);
        
        %Einstellungen zum Auslesen
        delimiter = '\t';
        formatSpec = '%f%f%f%[^\n\r]';
        %Auslesen
        for a = 1:size(txtfiles,1)
            fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
            Ergebnissetemp = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
            Ergebnissetemp = Ergebnissetemp{1,2};
            fclose(fileID);
            
            % Daten in Matrix speichern
            Ergebnisse(:,a) = Ergebnissetemp;
        end
        Ergebnisse = vertcat(messtime,horzcat(masse,Ergebnisse));
    else %% Lagzeitmessung ohne paramfile und ohne parameter in Txt-File
        einstellungen = 0;
        %% Messdaten auslesen
        ordnermess = dir(fullfile(fullpfad,'*l_20*.txt'));  %Daten mit messungen
        
        % Ordner sortieren
        [~, reindex] = sort(str2double(regexp({ordnermess.name},'\d+','match','once')));
        ordnermess = ordnermess(reindex);
        
        %Erste Daten auslesen Masse, Zeit und Txtfiles
        checkmess = fopen(fullfile(fullpfad,ordnermess(1).name),'r');
        masse = textscan(checkmess,'%n %n %n');
        masse = masse{1,1};
        messtime = zeros(1,size(ordnermess,1)+1);
        messtime(2:end) = [ordnermess.datenum];
        txtfiles = transpose({ordnermess.name});
        fclose(checkmess);
        
        %Einstellungen zum Auslesen
        delimiter = '\t';
        formatSpec = '%f%f%f%[^\n\r]';
        %Auslesen
        for a = 1:size(txtfiles,1)
            fileID = fopen(fullfile(fullpfad,txtfiles{a}),'r');
            Ergebnissetemp = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
            Ergebnissetemp = Ergebnissetemp{1,2};
            fclose(fileID);
            
            % Daten in Matrix speichern
            Ergebnisse(:,a) = Ergebnissetemp;
        end
        Ergebnisse = vertcat(messtime,horzcat(masse,Ergebnisse));
    end
end

%% Speichern der Ergebnisse und Einstellungen
% Überprüfen ob Systempressure vorhanden oder nicht
if zahler == 19

    guiversion = handles.guiversion;
    
    messstart = datestr(Ergebnisse(1,2),'dd_mm_yyyy');
    messtart_full = datestr(Ergebnisse(1,2),'dd.mm.yyyy HH:MM:SS');
    messend = datestr(Ergebnisse(1,end),'dd_mm_yyyy');
    messstarttemp = datestr(Ergebnisse(1,2));
    messendtemp = datestr(Ergebnisse(1,end));
    messstarttemp = datevec(datenum(messstarttemp));
    messendtemp = datevec(datenum(messendtemp));
    time_interval_in_hours = etime(messendtemp,messstarttemp)/60/60;
    time_interval_in_hours = round(time_interval_in_hours,1);
    messdauer = time_interval_in_hours;
    messdauer(messdauer==0)=[];
    filename = strcat(messstart,'-',messend,'-',num2str(messdauer),'_Auswertung','.mat');
    save(fullfile(fullpfad,filename),'Ergebnisse','einstellungen','systempressure','messtart_full','guiversion')
elseif zahler == 23 %Langezeitmessung mit Ionenstärke

    guiversion = handles.guiversion;
    
    messstart = datestr(Ergebnisse(1,2),'dd_mm_yyyy');
    messtart_full = datestr(Ergebnisse(1,2),'dd.mm.yyyy HH:MM:SS');
    messend = datestr(Ergebnisse(1,end),'dd_mm_yyyy');
    messstarttemp = datestr(Ergebnisse(1,2));
    messendtemp = datestr(Ergebnisse(1,end));
    messstarttemp = datevec(datenum(messstarttemp));
    messendtemp = datevec(datenum(messendtemp));
    time_interval_in_hours = etime(messendtemp,messstarttemp)/60/60;
    time_interval_in_hours = round(time_interval_in_hours,1);
    messdauer = time_interval_in_hours;
    messdauer(messdauer==0)=[];
    filename = strcat(messstart,'-',messend,'-',num2str(messdauer),'_Auswertung','.mat');
    save(fullfile(fullpfad,filename),'Ergebnisse','einstellungen','systempressure','messtart_full','guiversion')
elseif size(einstellungen,1) <= 1 %Keine Parameter vorhanden somit auch kein Korrekturfaktor
    guiversion = handles.guiversion;
    
    messstart = datestr(Ergebnisse(1,2),'dd_mm_yyyy');
    messtart_full = datestr(Ergebnisse(1,2),'dd.mm.yyyy HH:MM:SS');
    messend = datestr(Ergebnisse(1,end),'dd_mm_yyyy');
    messstarttemp = datestr(Ergebnisse(1,2));
    messendtemp = datestr(Ergebnisse(1,end));
    messstarttemp = datevec(datenum(messstarttemp));
    messendtemp = datevec(datenum(messendtemp));
    time_interval_in_hours = etime(messendtemp,messstarttemp)/60/60;
    time_interval_in_hours = round(time_interval_in_hours,1);
    messdauer = time_interval_in_hours;
    messdauer(messdauer==0)=[];
    filename = strcat(messstart,'-',messend,'-',num2str(messdauer),'_Auswertung','.mat');
    save(fullfile(fullpfad,filename),'Ergebnisse','einstellungen','messtart_full','guiversion')
else % Kein Systempressure vorhanden
    guiversion = handles.guiversion;
    
    messstart = datestr(Ergebnisse(1,2),'dd_mm_yyyy');
    messtart_full = datestr(Ergebnisse(1,2),'dd.mm.yyyy HH:MM:SS');
    messend = datestr(Ergebnisse(1,end),'dd_mm_yyyy');
    messstarttemp = datestr(Ergebnisse(1,2));
    messendtemp = datestr(Ergebnisse(1,end));
    messstarttemp = datevec(datenum(messstarttemp));
    messendtemp = datevec(datenum(messendtemp));
    time_interval_in_hours = etime(messendtemp,messstarttemp)/60/60;
    time_interval_in_hours = round(time_interval_in_hours,1);
    messdauer = time_interval_in_hours;
    messdauer(messdauer==0)=[];
    filename = strcat(messstart,'-',messend,'-',num2str(messdauer),'_Auswertung','.mat');
    save(fullfile(fullpfad,filename),'Ergebnisse','einstellungen','messtart_full','guiversion')
end

Auswerten_Langzeit(handles)