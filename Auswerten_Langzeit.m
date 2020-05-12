%% Auswertung Langzeitmessung
%%-----------------------------------------------------------------
% Das Skript wertet die gespeicherten Daten der Langzeitmessung aus
% in der GUI
% Bearbeiter: Artur Chertkov
% Bearbeitet am: 07.04.2020
%%-----------------------------------------------------------------

function Auswerten_Langzeit(handles)
clearvars -except auswertungordnertemp eventdata messung handles hObject f
%% Einstellungen
% ordnerpfad = 'D:\OneDrive - ruhr-uni-bochum.de\Arbeit\MATLAB\';
% chip = 'Dauertest_20170224';
fullpfad = handles.fullpfad;
pfad = handles.pfad;
f = handles.f;
%% Messungen auslesen
matfile = dir(fullfile(fullpfad,'*Auswertung*'));
load(fullfile(fullpfad,matfile.name))

%% Korrekturfaktor bestimmen und Maximum
if size(einstellungen,1) <= 1
    disp('Keine Parameter vorhanden')
    
    %Maximum bestimmen
    maximum = zeros(1,size(Ergebnisse,2));
    for b = 1:size(Ergebnisse,2)-1
        ftcor = fittype( 'gauss1' );
        opts1 = fitoptions( 'Method', 'NonlinearLeastSquares' );
        opts1.Display = 'Off';
        opts1.Lower = [0 -Inf 0];
        fitcorr = fit(Ergebnisse(2:end,1),Ergebnisse(2:end,b+1),ftcor,opts1);
        b1 = coeffvalues(fitcorr);
        maximum(1,b+1) = b1(1);
    end
    
else
    %Korrekturfaktor bei Krohnesystem
if strncmpi(handles.system_choice,'Krohne',6)==1
    corfak = einstellungen{11,1};
    corfak = str2num(cell2mat(regexp(corfak,'\d*','Match')));
else
    %Korrekturfaktor bei RUBsystem
    corfak = einstellungen{12,1};
    corfak = str2num(corfak(3:end));
end
    %Korrekturfaktor und Maximum bestimmen bei 

    corfaktor = zeros(1,size(Ergebnisse,2));
    maximum = zeros(1,size(Ergebnisse,2));
    for b = 1:size(Ergebnisse,2)-1
        mass_calibrate = 40;
        ftcor = fittype( 'gauss1' );
        opts1 = fitoptions( 'Method', 'NonlinearLeastSquares' );
        opts1.Display = 'Off';
        opts1.Lower = [0 -Inf 0];
        fitcorr = fit(Ergebnisse(2:end,1),Ergebnisse(2:end,b+1),ftcor,opts1);
        b1 = coeffvalues(fitcorr);
        maximum(1,b+1) = b1(1);
        corfaktor(:,b+1) = corfak*mass_calibrate/b1(2);
        
    end
end


%% Messgenauigkeit und Quantisierungstufen berechnen
% Offset bestimmen mit dem Mittelwert der ersten 30 niedriegsten Werte
offsetmess = zeros(1,size(Ergebnisse,2)-1);
for z=1:size(Ergebnisse,2)-1
    
    sorttemp = sort(Ergebnisse(2:end,z+1));
    offsetmess(z) = mean(sorttemp(1:30));
    
end
% Mittlerereite bestimmmen
mittlbreite=zeros(1,size(Ergebnisse,2));
for kap=1:size(Ergebnisse,2)-1
    
    %Rechnen mit neuem Offset
    mitte=(maximum(kap+1)-offsetmess(kap))/2+offsetmess(kap);
    
    %Beginn der Steigung von hinten aufrollen
    [coltemp]=find(Ergebnisse(2:end,kap+1)>=mitte,2,'last')+1;
    if size(coltemp,2)==1
        [col1]=find(Ergebnisse(2:coltemp(1),kap+1)<=mitte,1,'last')+1;
        [col2]=find(Ergebnisse(2:coltemp(1),kap+1)<=mitte,1,'last');
    else
        [col1]=find(Ergebnisse(2:coltemp(2),kap+1)<=mitte,1,'last')+1;
        [col2]=find(Ergebnisse(2:coltemp(2),kap+1)<=mitte,1,'last');
    end
    test1 = size(col1);
    test2 = size(col2);
    if test1(1) ~= 0
        if test2(1) ~= 0
            x2=Ergebnisse(col1,1);
            x1=Ergebnisse(col2,1);
            y2=(Ergebnisse(col1,kap+1));
            y1=Ergebnisse(col2,kap+1);
            %% falls y2=y1 folgt m1=0 -> falscher Wert (diesen Wert filtern)
            if y2==y1
                y2=Ergebnisse(col1+1,kap+1);
                y1=Ergebnisse(col2-1,kap+1);
                m1 = (y2-y1)/(x2-x1);
                xs1=(mitte+m1*x1-y1)/m1;
            else
                m1 = (y2-y1)/(x2-x1);
                xs1=(mitte+m1*x1-y1)/m1;
            end
            
            [col3]=find(Ergebnisse(2:end,kap+1)>=mitte,1,'last')+1;
            [col4]=find(Ergebnisse(2:end,kap+1)>=mitte,1,'last')+2;
            if col4>size(Ergebnisse,1)
                x3=Ergebnisse(size(Ergebnisse,1)-1,1);
                x4=Ergebnisse(size(Ergebnisse,1),1);
                y3=(Ergebnisse(size(Ergebnisse,1)-1,kap+1));
                y4=Ergebnisse(size(Ergebnisse,1),kap+1);
            else
                x3=Ergebnisse(col3,1);
                x4=Ergebnisse(col4,1);
                y3=(Ergebnisse(col3,kap+1));
                y4=Ergebnisse(col4,kap+1);
            end
            %% falls y4=y3 folgt m2=0 -> falscher Wert (diesen Wert filtern)
            if y4==y3
                if col4>size(Ergebnisse,1)
                    col4 = size(Ergebnisse,1)-2;
                end
                y4=Ergebnisse(col4+1,kap+1);
                y3=Ergebnisse(col3-1,kap+1);
                m2= (y4-y3)/(x4-x3);
                xs2=(mitte+m2*x3-y3)/m2;
            else
                m2= (y4-y3)/(x4-x3);
                xs2=(mitte+m2*x3-y3)/m2;
            end
            mittlbr=xs2-xs1;
            mittlbreite(kap+1)=mittlbr;
            
            
            %Messgenauigkeit
            %messgenau = (maximum-offsetmess)./mittlbreite; %falsche Angabe von
            %Stephan
            %Korrektur:
            messgenau(kap) = ((xs1+xs2)/2)/mittlbr;
            messgenau40(kap) = 40 / mittlbr;
            
            
            
        end
    else
        messgenau(kap) = 0;
        messgenau40(kap) = 0;
    end
    
    
end

% Werte �ber 500 und unter 0 rausfiltern und NaN durch -1 ersetzen
for h = 1:size(messgenau,2)
    if messgenau(h) > 500
        messgenau(h) = -1;
    end
    
    if messgenau(h) < 0
        messgenau(h) = -1;
    end
    
    if isnan(messgenau(h)) == 1
        messgenau(h) = -1;
    end
end

messgenaunew=[0,messgenau];


% Quantiesierungsstufen berechnen
%erste Methode gleiche Werte filtern einzigartige Werte berechnen
quantstufen=zeros(1,size(Ergebnisse,2));
for s = 1:size(Ergebnisse,2)-1
    
    quanttemp=size(unique(Ergebnisse(2:end,s+1)),1);
    quantstufen(s+1)=quanttemp;
    
end


%% Speichern der berechneten Werte 
if strncmpi(handles.system_choice,'Krohne',6)==1
    save(fullfile(fullpfad,matfile.name),'Ergebnisse','Masse','einstellungen','Frequenz','mess_time','mess_time_num','messdauer','Stromstaerke','maximum','systempressure','corfaktor','messgenaunew','quantstufen','offsetmess','guiversion')
elseif exist('systempressure') ==0
    save(fullfile(fullpfad,matfile.name),'Ergebnisse','messgenaunew','corfaktor','quantstufen','maximum','offsetmess','einstellungen','messtart_full','guiversion')
elseif size(einstellungen,1) <= 1
    save(fullfile(fullpfad,matfile.name),'Ergebnisse','messgenaunew','quantstufen','maximum','offsetmess','einstellungen','messtart_full','guiversion')
else
    save(fullfile(fullpfad,matfile.name),'Ergebnisse','messgenaunew','corfaktor','quantstufen','maximum','offsetmess','einstellungen','systempressure','messtart_full','guiversion')
end
