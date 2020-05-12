function Auswerten_Temperatur(handles)

%% Temperatur Auswertung über 5 Arduinos
pfad = handles.fullpfad;
fullpfad = pfad;
datei = dir(fullfile(pfad,'Temperaturmessung*.txt'));
%% Arduino 1 Daten einlesen
fid=fopen(fullfile(datei(1).folder,datei(1).name));
tempdata = textscan(fid,'%n%n%n%n%n%s','Delimiter','\t');

ard1tempdrucksensor = tempdata{1,1};
ard1luftdruck = tempdata{1,2};
ard1templuftsensor = tempdata{1,3};
ard1luftfeuchtigkeit = tempdata{1,4};
ard1lichtinten = tempdata{1,5};
ard1zeit = tempdata{1,6};
fclose(fid);

%Messfehler filtern
if ard1lichtinten(1)==0 || ard1luftdruck(1)==0 || ard1luftfeuchtigkeit(1)==0 || ard1tempdrucksensor(1)==0||ard1templuftsensor(1)==0
    ard1lichtinten(1)=ard1lichtinten(2);
    ard1luftdruck(1)=ardlluftdruck(2);
    ard1luftfeuchtigkeit(1)=ard1luftfeuchtigkeit(2);
    ard1tempdrucksensor(1)=ard1tempdrucksensor(2);
    ard1templuftsensor(1)=ard1templuftsensor(2);
end
for a = 1:size(ard1lichtinten,1)
    if ard1lichtinten(a) == 0
        ard1lichtinten(a) = ard1lichtinten(a-1);
        ard1luftdruck(a) = ard1luftdruck(a-1);
        ard1luftfeuchtigkeit(a) = ard1luftfeuchtigkeit(a-1);
        ard1tempdrucksensor(a) = ard1tempdrucksensor(a-1);
        ard1templuftsensor(a) = ard1templuftsensor(a-1);
    end
end


ard1zeitdatetime = cell2mat(ard1zeit);
ard1zeitdatetime = datetime(ard1zeitdatetime,'InputFormat','dd.MM.yyyy_HH:mm:ss');

%% Arduino 2 Daten einlesen
fid=fopen(fullfile(datei(2).folder,datei(2).name));

tempdata = textscan(fid,'%n%n%n%n%n%s','Delimiter','\t');

ard2tempdrucksensor = tempdata{1,1};
ard2luftdruck = tempdata{1,2};
ard2templuftsensor = tempdata{1,3};
ard2luftfeuchtigkeit = tempdata{1,4};
ard2lichtinten = tempdata{1,5};
ard2zeit = tempdata{1,6};
fclose(fid);

ard2zeitdatetime = cell2mat(ard2zeit);
ard2zeitdatetime = datetime(ard2zeitdatetime,'InputFormat','dd.MM.yyyy_HH:mm:ss');

%Messfehler filtern
if ard2lichtinten(1)==0 || ard2luftdruck(1)==0 || ard2luftfeuchtigkeit(1)==0 || ard2tempdrucksensor(1)==0||ard2templuftsensor(1)==0
    ard2lichtinten(1)=ard2lichtinten(2);
    ard2luftdruck(1)=ard2luftdruck(2);
    ard2luftfeuchtigkeit(1)=ard2luftfeuchtigkeit(2);
    ard2tempdrucksensor(1)=ard2tempdrucksensor(2);
    ard2templuftsensor(1)=ard2templuftsensor(2);
end
for a = 1:size(ard2lichtinten,1)
    if ard2lichtinten(a) == 0
        ard2lichtinten(a) = ard2lichtinten(a-1);
        ard2luftdruck(a) = ard2luftdruck(a-1);
        ard2luftfeuchtigkeit(a) = ard2luftfeuchtigkeit(a-1);
        ard2tempdrucksensor(a) = ard2tempdrucksensor(a-1);
        ard2templuftsensor(a) = ard2templuftsensor(a-1);
    end
end



%% Arduino 3 Daten einlesen
fid=fopen(fullfile(datei(3).folder,datei(3).name));

tempdata = textscan(fid,'%n%n%n%n%n%s','Delimiter','\t');

ard3tempdrucksensor = tempdata{1,1};
ard3luftdruck = tempdata{1,2};
ard3templuftsensor = tempdata{1,3};
ard3luftfeuchtigkeit = tempdata{1,4};
ard3lichtinten = tempdata{1,5};
ard3zeit = tempdata{1,6};
fclose(fid);

ard3zeitdatetime = cell2mat(ard3zeit);
ard3zeitdatetime = datetime(ard3zeitdatetime,'InputFormat','dd.MM.yyyy_HH:mm:ss');

%Messfehler filtern
if ard3lichtinten(1)==0 || ard3luftdruck(1)==0 || ard3luftfeuchtigkeit(1)==0 || ard3tempdrucksensor(1)==0||ard3templuftsensor(1)==0
    ard3lichtinten(1)=ard3lichtinten(2);
    ard3luftdruck(1)=ard3luftdruck(2);
    ard3luftfeuchtigkeit(1)=ard3luftfeuchtigkeit(2);
    ard3tempdrucksensor(1)=ard3tempdrucksensor(2);
    ard3templuftsensor(1)=ard3templuftsensor(2);
end
for a = 1:size(ard3lichtinten,1)
    if ard3lichtinten(a) == 0
        ard3lichtinten(a) = ard3lichtinten(a-1);
        ard3luftdruck(a) = ard3luftdruck(a-1);
        ard3luftfeuchtigkeit(a) = ard3luftfeuchtigkeit(a-1);
        ard3tempdrucksensor(a) = ard3tempdrucksensor(a-1);
        ard3templuftsensor(a) = ard3templuftsensor(a-1);
    end
end



%% Arduino 4 Daten einlesen
fid=fopen(fullfile(datei(4).folder,datei(4).name));

tempdata = textscan(fid,'%n%n%n%n%n%s','Delimiter','\t');

ard4tempdrucksensor = tempdata{1,1};
ard4luftdruck = tempdata{1,2};
ard4templuftsensor = tempdata{1,3};
ard4luftfeuchtigkeit = tempdata{1,4};
ard4lichtinten = tempdata{1,5};
ard4zeit = tempdata{1,6};
fclose(fid);

ard4zeitdatetime = cell2mat(ard4zeit);
ard4zeitdatetime = datetime(ard4zeitdatetime,'InputFormat','dd.MM.yyyy_HH:mm:ss');

%Messfehler filtern
if ard4lichtinten(1)==0 || ard4luftdruck(1)==0 || ard4luftfeuchtigkeit(1)==0 || ard4tempdrucksensor(1)==0||ard4templuftsensor(1)==0
    ard4lichtinten(1)=ard4lichtinten(2);
    ard4luftdruck(1)=ard4luftdruck(2);
    ard4luftfeuchtigkeit(1)=ard4luftfeuchtigkeit(2);
    ard4tempdrucksensor(1)=ard4tempdrucksensor(2);
    ard4templuftsensor(1)=ard4templuftsensor(2);
end
for a = 1:size(ard4lichtinten,1)
    if ard4lichtinten(a) == 0
        ard4lichtinten(a) = ard4lichtinten(a-1);
        ard4luftdruck(a) = ard4luftdruck(a-1);
        ard4luftfeuchtigkeit(a) = ard4luftfeuchtigkeit(a-1);
        ard4tempdrucksensor(a) = ard4tempdrucksensor(a-1);
        ard4templuftsensor(a) = ard4templuftsensor(a-1);
    end
end





%% Arduino 5 Daten einlesen
fid=fopen(fullfile(datei(5).folder,datei(5).name));

tempdata = textscan(fid,'%n%n%n%n%n%s','Delimiter','\t');

ard5tempdrucksensor = tempdata{1,1};
ard5luftdruck = tempdata{1,2};
ard5templuftsensor = tempdata{1,3};
ard5luftfeuchtigkeit = tempdata{1,4};
ard5lichtinten = tempdata{1,5};
ard5zeit = tempdata{1,6};
fclose(fid);

ard5zeitdatetime = cell2mat(ard5zeit);
ard5zeitdatetime = datetime(ard5zeitdatetime,'InputFormat','dd.MM.yyyy_HH:mm:ss');

%Messfehler filtern
if ard5lichtinten(1)==0 || ard5luftdruck(1)==0 || ard5luftfeuchtigkeit(1)==0 || ard5tempdrucksensor(1)==0||ard5templuftsensor(1)==0
    ard5lichtinten(1)=ard5lichtinten(2);
    ard5luftdruck(1)=ard5luftdruck(2);
    ard5luftfeuchtigkeit(1)=ard5luftfeuchtigkeit(2);
    ard5tempdrucksensor(1)=ard5tempdrucksensor(2);
    ard5templuftsensor(1)=ard5templuftsensor(2);
end
for a = 1:size(ard5lichtinten,1)
    if ard5lichtinten(a) == 0
        ard5lichtinten(a) = ard5lichtinten(a-1);
        ard5luftdruck(a) = ard5luftdruck(a-1);
        ard5luftfeuchtigkeit(a) = ard5luftfeuchtigkeit(a-1);
        ard5tempdrucksensor(a) = ard5tempdrucksensor(a-1);
        ard5templuftsensor(a) = ard5templuftsensor(a-1);
    end
end

%% Speichern der Daten aus Temperaturmessung als Mat-File
tempmatfile = strcat('Temperaturmessung','_',cell2mat(handles.tableinput(handles.row,handles.col)),'.mat');
save(fullfile(fullpfad,tempmatfile),'ard1tempdrucksensor','ard1luftdruck','ard1templuftsensor','ard1luftfeuchtigkeit','ard1lichtinten','ard1zeit','ard1zeitdatetime','ard2tempdrucksensor','ard2luftdruck','ard2templuftsensor','ard2luftfeuchtigkeit','ard2lichtinten','ard2zeit','ard2zeitdatetime','ard3tempdrucksensor','ard3luftdruck','ard3templuftsensor','ard3luftfeuchtigkeit','ard3lichtinten','ard3zeit','ard3zeitdatetime','ard4tempdrucksensor','ard4luftdruck','ard4templuftsensor','ard4luftfeuchtigkeit','ard4lichtinten','ard4zeit','ard4zeitdatetime','ard5tempdrucksensor','ard5luftdruck','ard5templuftsensor','ard5luftfeuchtigkeit','ard5lichtinten','ard5zeit','ard5zeitdatetime')

end