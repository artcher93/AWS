function Einlesen_RUB_Wanderfeld(handles)

Ergebnisse = 0;
anzahlPun = 0;
massend = 0;
messungen = 0;
param_all = zeros(19,1);
auswertungordnertemp = handles.auswertungordnertemp;
messung = handles.messung;
f = handles.f;
%% Einstellungen
  auswertungordner = strcat(cell2mat(auswertungordnertemp),'\');
  messungtemp = messung;
  messung = strcat(cell2mat(messung),'*');


% %% Ordnerliste erstellen
 ordnerliste = dir(fullfile(auswertungordner,messung));

 ordnernamen = {ordnerliste.name};
 anzahlDir = numel(ordnernamen);
 pfadtemp = fullfile(auswertungordner,messungtemp);
  %% Einstellungen auslesen aus Txt (noch anpassen)
    ordnerdir = dir(cell2mat(pfadtemp));
    txtfilefolder = fullfile(pfadtemp,ordnerdir(5).name);
    file = fopen(txtfilefolder{1,1});
    einstellungentemp1 = textscan(file,'%s %n','Delimiter',';');
    einstellungentemp2 = einstellungentemp1{1,1};
    einstellungen = einstellungentemp2(1:24,1);

%% Messungen einlesen
for k=1:anzahlDir
    clear dateinamenrow;
    messungen = 0;
    anzahlPun = 0;
    massend = 0;
    massstart = 0;
    anzahlMes = 0;
   
    pfad = [auswertungordner,ordnernamen{1,k},'\'];

    %% Parameter einlesen
    file = fopen(fullfile(pfad,'\param_file.txt'),'r');
    if(file ~= '')
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        fgetl(file);
        massstart = textscan(file,'MassStart= %f');
        fgetl(file);
        massend = textscan(file,'MassEnd= %n',21);
        fgetl(file);
        numpermass = textscan(file,'NumPerMass= %n',22);
        %fgetl(file); % advance the file pointer one line
        %data = textscan(file,'%n %n %n');
        fclose(file); 
    end



    %% Einlesen der Messungen
    dateiliste = dir(fullfile(pfad,'*W_20*.txt'));
    %sortieren
    dateinamenrow(:,1) = [dateiliste.datenum];
    dateinamenrow(:,2) = 1:numel(dateinamenrow(:,1));
    [sx,sy] = sortrows(dateinamenrow,1);
    dateiliste = dateiliste(sy);
    dateinamen = {dateiliste.name};
    %Messwerteauslesen und in eine Matrix speichern
    anzahlMes = numel(dateinamen);
    % Bestimmung der X-Achse



    %Matrix mit den Paramtern
    paramliste = zeros(anzahlMes+1, 24);
    %paramliste(1,1) = 'SystemPressure';
%     uwavektor=uwas:uwastep:uwae;
    Uwamplitude=zeros(1,anzahlMes);
    Uwoffset=zeros(1,anzahlMes);
    
    for i=1:anzahlMes
        file = fopen(fullfile(pfad,dateinamen{i}),'r');
        %Mit oder ohne Parameter?
        data = textscan(file,'SystemPressure= %f');
%         if data{1,1} ~= 0
            paramliste(i+1,1) = data{1,1};
            fgetl(file);
            data = textscan(file,'Ueex= %f');
            paramliste(i+1,2) = data{1,1};
            fgetl(file);
            data = textscan(file,'Uiex= %f');
            paramliste(i+1,3) = data{1,1};
            fgetl(file);
            data = textscan(file,'Uifo= %f');
            paramliste(i+1,4) = data{1,1};
            fgetl(file);
            uwas = cell2mat(textscan(file,'UwAmplStart=  %f'));
            paramliste(i+1,5) = data{1,1}; 
            fgetl(file);
            uwae = cell2mat(textscan(file,'UwAmplEnd=  %f'));
            paramliste(i+1,6) = data{1,1}; 
            fgetl(file);
            uwastep = cell2mat(textscan(file,'UwAmplStepsize=  %f'));
            paramliste(i+1,7) = data{1,1}; 
            fgetl(file);
            Uwamplitude(i+1) = cell2mat(textscan(file,'UwAmplAktuell=  %f'));
            paramliste(i+1,8) = data{1,1};
            fgetl(file);
             uwos = cell2mat(textscan(file,'UwOffsetStart= %f'));
            paramliste(i+1,9) = data{1,1};
            fgetl(file);
             uwoe = cell2mat(textscan(file,'UwOffsetEnd= %f'));
            paramliste(i+1,10) = data{1,1};
            fgetl(file);
             uwostep = cell2mat(textscan(file,'UwOffsetStepsize= %f'));
            paramliste(i+1,11) = data{1,1};
            fgetl(file);
            Uwoffset(1+i) = cell2mat(textscan(file,'UwOffsetAktuell= %f'));
            paramliste(i+1,12) = data{1,1};
            fgetl(file);
            data = textscan(file,'Usi= %f');
            paramliste(i+1,13) = data{1,1};
            fgetl(file);
            data = textscan(file,'Usa= %f');
            paramliste(i+1,14) = data{1,1};
            fgetl(file);
            data = textscan(file,'Pmw= %f');
            paramliste(i+1,15) = data{1,1};
            fgetl(file);
            data = textscan(file,'forwardPmw= %f');
            paramliste(i+1,16) = data{1,1};
            fgetl(file);
            data = textscan(file,'backwardPmw= %f');
            paramliste(i+1,17) = data{1,1};
            fgetl(file);
            corfak = cell2mat(textscan(file,'K= %f'));
            paramliste(i+1,12) = data{1,1};
            fgetl(file);
            data = textscan(file,'Poti= %f');
            paramliste(i+1,19) = data{1,1};
            fgetl(file);
            data = textscan(file,'MassStart= %f');
            paramliste(i+1,20) = data{1,1};
            fgetl(file);
            data = textscan(file,'MassEnd= %f');
            paramliste(i+1,21) = data{1,1};
            fgetl(file);
            data = textscan(file,'NumPerMass= %f');
            paramliste(i+1,22) = data{1,1};
            fgetl(file);
            data = textscan(file,'Average= %f');
            paramliste(i+1,23) = data{1,1};
            fgetl(file);
            data = textscan(file,'NumCycles= %f');
            paramliste(i+1,24) = data{1,1};
            fgetl(file);
      
            fgetl(file);
            
 
%         end

             
        
        if(anzahlPun == 0 &&  massend ~= 0)
            anzahlPun = (massend{1,1}-massstart{1,1})*numpermass{1,1}+1;
            messungen = zeros(anzahlMes+1,anzahlPun+1);
            messungen(1,2:end) = massstart{1,1}:1/numpermass{1,1}:massend{1,1};
            messungen(2:end,1) = [dateiliste.datenum].';
        elseif(anzahlPun == 0 &&  paramliste(2,21) ~= 0)
            anzahlPun = (paramliste(2,21)-paramliste(2,20))*paramliste(2,22)+1;
            messungen = zeros(anzahlMes+1,anzahlPun+1);
            messungen(1,2:end) = paramliste(2,20):1/paramliste(2,22):paramliste(2,21);
            messungen(2:end,1) = [dateiliste.datenum].';
        elseif(anzahlPun == 0 &&  paramliste(2,21) == 0)
            fclose(file);
            break;
        end
        
        if(size(Ergebnisse) < 20)
            Ergebnisse = zeros(anzahlPun+1,1);
            param_all = zeros(24,1);
        end
        
        data = textscan(file,'%n %n %n');
        messungen(i+1,2:end)=data{1,2};
        fclose(file); 
    end

    %% speichern in eine große Tabelle
    Ergebnisse = horzcat(Ergebnisse,messungen(2:end,:).');
%     Ergebnisse = vertcat(Uwamplitude,Ergebnisse);%dritte Zeile für Amplitudeneinstellungen
%     Ergebnisse = vertcat(Uwoffset,Ergebnisse); %zweite Zeile für Offsreteinstellungen
    param_all = horzcat(param_all,paramliste(2:end,:).');
    k = k + 1;
end

Ergebnisse(1:end,1) = messungen(1,:).';

%% Bestimmung des maximalen Peaks einer jeden Messung
messUmfang = size(Ergebnisse(1,:));
MP = zeros(messUmfang(2),2);
for i=1:messUmfang(2)-1
    [MP(i,1), MP(i,2)] = max(Ergebnisse(200:end,i+1));
end

%% Bestimmung des Offsets einer jeden Messung
Offset = zeros(anzahlMes,2);
for i=1:anzahlMes
    [Offset(i,1), Offset(i,2)] = min(messungen(i+1,1:end));
end

%% Bestimmung der Varianz eines jeden Massepunktes
Varianz = zeros(anzahlPun, 2);
Varianz = var(messungen(2:end,:));

Mittelwert = mean(messungen(2:end,:));

%% Wanderfeldoffset als Vektor
uwovektor=uwos:uwostep:uwoe;
%% Wanderfeldamplitude
 uwavektor=uwas:uwastep:uwae;
% uwovektor=zeros(size(uwovektortemp)+[0,1])
% uwovektor(2:end)=uwovektortemp
waitbar(.66,f,'Messgenauigkeit wird bestimmt...');

%% Speichern Ergebnisse
messstart = datestr(Ergebnisse(1,2),'dd_mm_yyyy');
messend = datestr(Ergebnisse(1,end),'dd_mm_yyyy');
messstarttemp = datestr(Ergebnisse(1,2));
messendtemp = datestr(Ergebnisse(1,end));
messstarttemp = datevec(datenum(messstarttemp));
messendtemp = datevec(datenum(messendtemp));
time_interval_in_hours = etime(messendtemp,messstarttemp)/60/60;
time_interval_in_hours = round(time_interval_in_hours,1);
messdauer = time_interval_in_hours;
filename = strcat(messstart,'-',messend,'-',num2str(messdauer),'_Auswertung','.mat');
save(fullfile(pfad,filename),'Ergebnisse','corfak','uwovektor','uwos','uwoe','uwostep','uwas','uwastep','Uwamplitude','Uwoffset','einstellungen')

Auswerten_Wanderfeld(handles)

