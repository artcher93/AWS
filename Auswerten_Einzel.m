function Auswerten_Einzel(handles)
currentfolder = handles.currentfolder;
matfile = handles.matfile;
auswertungordnertemp = handles.auswertungordnertemp;
guiversion = handles.guiversion;
load(matfile)

%% Maximum bestimmen
ftcor = fittype( 'gauss1' );
opts1 = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts1.Display = 'Off';
opts1.Lower = [0 -Inf 0];
fitcorr = fit(Ergebnisse(2:end,1),Ergebnisse(2:end,2),ftcor,opts1);
b1 = coeffvalues(fitcorr);
maximum = b1(1);

%% Messgenauigkeit und Quantisierungstufen berechnen
% Offset bestimmen mit dem Mittelwert der ersten 30 niedriegsten Werte
sorttemp = sort(Ergebnisse(2:end,2));
offsetmess = mean(sorttemp(1:30));

% Mittlerereite bestimmmen
%Rechnen mit neuem Offset
mitte=(maximum-offsetmess)/2+offsetmess;

%Beginn der Steigung von hinten aufrollen
[coltemp]=find(Ergebnisse(2:end,2)>=mitte,2,'last')+1;
if size(coltemp,2)==1
    [col1]=find(Ergebnisse(2:coltemp(1),2)<=mitte,1,'last')+1;
    [col2]=find(Ergebnisse(2:coltemp(1),2)<=mitte,1,'last');
else
    [col1]=find(Ergebnisse(2:coltemp(2),2)<=mitte,1,'last')+1;
    [col2]=find(Ergebnisse(2:coltemp(2),2)<=mitte,1,'last');
end
test1 = size(col1);
test2 = size(col2);
if test1(1) ~= 0
    if test2(1) ~= 0
        x2=Ergebnisse(col1,1);
        x1=Ergebnisse(col2,1);
        y2=(Ergebnisse(col1,2));
        y1=Ergebnisse(col2,2);
        %% falls y2=y1 folgt m1=0 -> falscher Wert (diesen Wert filtern)
        if y2==y1
            y2=Ergebnisse(col1+1,2);
            y1=Ergebnisse(col2-1,2);
            m1 = (y2-y1)/(x2-x1);
            xs1=(mitte+m1*x1-y1)/m1;
        else
            m1 = (y2-y1)/(x2-x1);
            xs1=(mitte+m1*x1-y1)/m1;
        end
        
        [col3]=find(Ergebnisse(2:end,2)>=mitte,1,'last')+1;
        [col4]=find(Ergebnisse(2:end,2)>=mitte,1,'last')+2;
        if col4>size(Ergebnisse,1)
            x3=Ergebnisse(size(Ergebnisse,1)-1,1);
            x4=Ergebnisse(size(Ergebnisse,1),1);
            y3=(Ergebnisse(size(Ergebnisse,1)-1,2));
            y4=Ergebnisse(size(Ergebnisse,1),2);
        else
            x3=Ergebnisse(col3,1);
            x4=Ergebnisse(col4,1);
            y3=(Ergebnisse(col3,2));
            y4=Ergebnisse(col4,2);
        end
        %% falls y4=y3 folgt m2=0 -> falscher Wert (diesen Wert filtern)
        if y4==y3
            if col4>size(Ergebnisse,1)
                col4 = size(Ergebnisse,1)-2;
            end
            y4=Ergebnisse(col4+1,2);
            y3=Ergebnisse(col3-1,2);
            m2= (y4-y3)/(x4-x3);
            xs2=(mitte+m2*x3-y3)/m2;
        else
            m2= (y4-y3)/(x4-x3);
            xs2=(mitte+m2*x3-y3)/m2;
        end
        mittlbr=xs2-xs1;
        mittlbreite=mittlbr;
        
        
        %Messgenauigkeit
        %messgenau = (maximum-offsetmess)./mittlbreite; %falsche Angabe von
        %Stephan
        %Korrektur:
        messgenau(1) = ((xs1+xs2)/2)/mittlbr;
        messgenau40(1) = 40 / mittlbr;
        
        
        
    end
else
    messgenau(1) = 0;
    messgenau40(1) = 0;
end




% Werte Über 500 und unter 0 rausfiltern und NaN durch -1 ersetzen
    if messgenau > 500
        messgenau = -1;
    end
    
    if messgenau < 0
        messgenau(h) = -1;
    end
    
    if isnan(messgenau) == 1
        messgenau = -1;
    end


messgenaunew=messgenau;


% Quantiesierungsstufen berechnen
%erste Methode gleiche Werte filtern einzigartige Werte berechnen
quantstufen=size(unique(Ergebnisse(2:end,2)),1);
if strncmpi(handles.system_choice,'Krohne',6)==1
save(matfile,'Ergebnisse','chip','Masse','einstellungen','Frequenz','mess_time','mess_time_num','Stromstaerke','systempressure','corfak','messgenaunew','quantstufen','maximum','offsetmess','guiversion')
elseif exist('chip') ==0
save(matfile,'Ergebnisse','chip','messgenaunew','quantstufen','maximum','offsetmess','guiversion')
else
    save(matfile,'Ergebnisse','messgenaunew','quantstufen','maximum','offsetmess','guiversion')
end 


if exist(fullfile(cell2mat(auswertungordnertemp),'Einzelmessungen')) ~= 7
    mkdir(fullfile(cell2mat(auswertungordnertemp),'Einzelmessungen'));
end
movefile(fullfile(currentfolder,handles.txt_einzel),fullfile(cell2mat(auswertungordnertemp),'Einzelmessungen'));
movefile(matfile,fullfile(cell2mat(auswertungordnertemp),'Einzelmessungen'));