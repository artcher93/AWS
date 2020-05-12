function varargout = AuswertungGUI1_3(varargin)
% AUSWERTUNGGUI1_3 MATLAB code for AuswertungGUI1_3.fig
%      AUSWERTUNGGUI1_3, by itself, creates a new AUSWERTUNGGUI1_3 or raises the existing
%      singleton*.
%
%      H = AUSWERTUNGGUI1_3 returns the handle to a new AUSWERTUNGGUI1_3 or the handle to
%      the existing singleton*.
%
%      AUSWERTUNGGUI1_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUSWERTUNGGUI1_3.M with the given input arguments.
%
%      AUSWERTUNGGUI1_3('Property','Value',...) creates a new AUSWERTUNGGUI1_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AuswertungGUI1_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AuswertungGUI1_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AuswertungGUI1_3

% Last Modified by GUIDE v2.5 14-Apr-2020 16:41:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @AuswertungGUI1_3_OpeningFcn, ...
    'gui_OutputFcn',  @AuswertungGUI1_3_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AuswertungGUI1_3 is made visible.
function AuswertungGUI1_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AuswertungGUI1_3 (see VARARGIN)

% Choose default command line output for AuswertungGUI1_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%%Pfad der GUIFunktionen in Searchpath einbinden


%%Tools unsichtbar/sichtbar machen
set(handles.pausebtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.testbtn,'visible','off')
set(handles.slideroffset,'Visible','off')
set(handles.amplbtn,'Visible','off')
set(handles.ganzmessbtn,'Visible','off')
set(handles.uitablewf,'Visible','off')
set(handles.sliderampl,'Visible','off')
set(handles.offsetbtn,'Visible','off')
set(handles.bildaxes,'Visible','off')
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt,'Visible','off')
set(handles.mittelwerttable,'Visible','off')
set(handles.selmesstable,'Visible','off')
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
set(handles.maximumbtn,'Visible','off')
set(handles.systempressurebtn,'Visible','off')
set(handles.einzelmessdatabtn,'Visible','off')
set(handles.thermocambtn,'visible','off')
set(handles.anzeigepanel,'visible','off')
set(handles.anzeigewfpanel,'visible','off')
set(handles.maxfixcheckbox,'Visible','off')
set(handles.checkbox_maximumWF,'Visible','off')
set(handles.einstellungenbtn_krohne,'Visible','off')
set(handles.checkbox_krohne_10_mess,'Visible','off')
set(handles.plot_as_fig_btn_krohne,'Visible','off')
try
    set(handles.check,'Visible','off')
    clear handles.check
end

guiversion = {'1_3'};
handles.guiversion = guiversion;
guidata(hObject, handles)
% UIWAIT makes AuswertungGUI1_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
try
    if isfile(fullfile(cd,'folder.txt')) == 0
        errordlg('Keinen Messordner ausgewählt, bitte auswählen!')
    else
        fid = fopen('folder.txt');
        mess_folder = fgetl(fid);
        fclose(fid);
        try
            gui_funk_path ='GUI-Funktionen';
            addpath(fullfile(mess_folder,gui_funk_path));
        catch
            errordlg('GUI-Funktionen nicht vorhanden. Bitte in Messordner GUI-Funktionen einbinden oder falschen Messordner ausgewählt');
        end
        
        RUB_sys_dir = dir(fullfile(mess_folder,'RUB*'));
        Krohne_sys_dir = dir(fullfile(mess_folder,'Krohne*'));
        
        system_popup_input = {RUB_sys_dir.name;Krohne_sys_dir.name};
        
        set(handles.system_popup,'String',system_popup_input)
        system_choice = get(handles.system_popup,'String');
        system_choice_val = get(handles.system_popup,'Value');
        %% Auslesen der ersten Ordner und anzeigen
        system_choice = cell2mat(system_choice(system_choice_val));
        
        % Chiptypen und Charge aus Orndernamen auslesen
        mess_folder_chiptypen = fullfile(mess_folder,system_choice);
        chiptypen = dir(mess_folder_chiptypen);
        chiptypen = chiptypen(~ismember({chiptypen.name},{'.' '..'}));%unnötige Zeilen entfernen
        for a = 1:size(chiptypen,1)
            charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
            charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
            charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
            zahler_charge(a) = size(charge_temp,1);
        end
        charge = cell(size(chiptypen,1),max(zahler_charge));
        charge_mit_typen = charge;
        
        for a = 1:size(chiptypen,1)
            charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
            charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
            charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
            for b = 1:size(charge_temp,1)
                charge(a,b) = {charge_temp(b).name};
                charge_mit_typen(a,b) = strcat(chiptypen(a).name,'/',{charge_temp(b).name});
            end
        end
        
        %Daten passend für Chippopup machen
        chippopup_input = reshape(charge_mit_typen, size(charge_mit_typen,1)*size(charge_mit_typen,2), 1);
        chippopup_input = sort(chippopup_input(~cellfun('isempty',chippopup_input)));
        set(handles.chippopup,'String',chippopup_input);
        
        %% Daten für handles speichern
        handles.mess_folder = mess_folder;
        handles.mess_folder_chiptypen = mess_folder_chiptypen;
        handles.system_choice = system_choice;
        guidata(hObject, handles)
        
        % Chipopup aufrufen
        chippopup_Callback(handles.laden,eventdata,handles);
        
    end
catch
    system_popup_input = {'Systemwahl'};
    set(handles.system_popup,'String',system_popup_input)
    errordlg('Keinen Messordner oder falschen Messordner ausgewählt, bitte auswählen!')
    
end


% --- Outputs from this function are returned to the command line.
function varargout = AuswertungGUI1_3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in chippopup.
function chippopup_Callback(hObject, eventdata, handles)
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')

%Daten aus handles beziehen
mess_folder_chiptypen = handles.mess_folder_chiptypen;

chip_choice = get(handles.chippopup,'String');
chip_choice_val = get(handles.chippopup,'Value');
if size(chip_choice,1) < chip_choice_val
    chip_choice_val = size(chip_choice,1);
end

chip_choice = chip_choice(chip_choice_val);

aktueller_messordner = cell2mat(fullfile(mess_folder_chiptypen,chip_choice));
chipname_temp = dir(aktueller_messordner);
chipname_temp = chipname_temp(~ismember({chipname_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
% Überprüfen ob Messungen vorhanden sind
if size(chipname_temp,1) == 0
    errordlg('Keine Messugen vorhanden, bitte Messungen einfügen!')
else
    chipname = cell(1,length(chipname_temp));
    for a = 1:length(chipname)
        chipname(1,a) = cellstr(chipname_temp(a).name);
    end
    
    %Messungen im Unterodner finden
    chipname_subfolder = cell(1,length(chipname_temp));
    for x = 1:length(chipname_temp)
        chipname_subfolder(x)=fullfile(aktueller_messordner,chipname(x));
    end
    
    zaehlvar2 = zeros(1,length(chipname));
    for a = 1:length(chipname_subfolder)
        zaehlvar2(a) = size(dir(cell2mat(chipname_subfolder(a))),1)-2;
    end
    
    
    messungen = cell(length(zaehlvar2));
    for z=1:length(chipname_subfolder)
        temp = dir(cell2mat(chipname_subfolder(1,z)));
        temp = temp(~ismember({temp.name},{'.' '..'}));
        temp = temp(~ismember({temp.name},{'Einzelmessungen'}));
        
        for t = 1:length(temp)
            messungen(z,t) = cellstr(temp(t).name);
        end
        
    end
    %% Daten passend für UITable machen
    unterordnertemp = aktueller_messordner;
    %zählt wie viele Messungen es gibt
    counter = sum(~cellfun(@isempty,messungen),2);
    counter2 = sum(~cellfun(@isempty,messungen),2);
    
    
    
    %richtiges cell array erstellen
    messungennew = reshape(transpose(messungen),[size(messungen,1)*size(messungen,2),1]);
    
    %Entfernt die leeren cell arrays
    messungennew = messungennew(~cellfun('isempty',messungennew));
    
    % Überprüft ob Messungen vorhanden sind
    if length(messungen)==0
        msgbox('Keine Messungen vorhanden')
        
    else
        
        %Zeilen für chipname finden
        zeile = zeros(length(counter2),1);
        zeile(1)=1;
        for b = 1:length(counter2)-1
            zeile(b+1) = zeile(b)+counter2(b);
        end
        
        %Chipnamen in richtige zeile initialisieren
        chipnamenew = cell(length(messungennew),1);
        
        for u = 1:length(counter2)
            chipnamenew(zeile(u))=chipname(u);
        end
        
        
        %überprüfen ob mat Dateien im Ordner sind
        check = cell(size(messungen));
        startdate = cell(size(messungen));
        measurement_time = cell(size(messungen));
        
        for c = 1:length(chipname)
            auswertungtemp = fullfile(unterordnertemp,chipname(c));
            for d = 1:counter2(c)
                auswertungtemp2 = fullfile(auswertungtemp,messungen(c,d));
                mess_matfile = dir(fullfile(cell2mat(auswertungtemp2),'*Auswertung*.mat'));
                if length(mess_matfile)==0
                    check(c,d)={'*'};
                    startdate(c,d) = {'*'};
                    measurement_time(c,d) = {'*'};
                    checkversion(c,d)={'*'};
                else
                    check(c,d)=cellstr(mess_matfile(1).name);
                    load(fullfile(cell2mat(auswertungtemp2),mess_matfile.name))
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
                    %                     messdauer(messdauer==0)=[];
                    startdate(c,d) = cellstr(messstart);
                    measurement_time(c,d) = cellstr(num2str(messdauer));
                    %GUI Version
                    try
                        checkversion(c,d)=guiversion;
                    catch
                        checkversion(c,d) = {'1_3'};
                    end
                    
                end
                
            end
        end
        
        %check array passend für UITable machen
        check = reshape(transpose(check),[size(check,1)*size(check,2),1]);
        check = check(~cellfun('isempty',check));
        
        startdate = reshape(transpose(startdate),[size(startdate,1)*size(startdate,2),1]);
        startdate = startdate(~cellfun('isempty',startdate));
        
        measurement_time = reshape(transpose(measurement_time),[size(measurement_time,1)*size(measurement_time,2),1]);
        measurement_time = measurement_time(~cellfun('isempty',measurement_time));
        
        checkversion = reshape(transpose(checkversion),[size(checkversion,1)*size(checkversion,2),1]);
        checkversion = checkversion(~cellfun('isempty',checkversion));
    end
    
    tableinput =[chipnamenew,messungennew,startdate,measurement_time,checkversion];
    set(handles.tabelle,'Data', tableinput)
    
    %% Daten für handles speichern
    handles.aktueller_messordner = aktueller_messordner;
    handles.unterordnertemp = unterordnertemp;
    handles.tableinput = tableinput;
    guidata(hObject, handles)
    
end


% --- Executes during object creation, after setting all properties.
function chippopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chippopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in auswerten.
function auswerten_Callback(hObject, eventdata, handles)
% hObject    handle to auswerten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
messung = tableinput(row,col);
ordner = cell(1);

%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end


auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
%Daten in handles speichern
handles.auswertungordnertemp = auswertungordnertemp;
handles.messung = messung;
handles.ordner = ordner;
guidata(hObject, handles)
currentfolder = cell2mat(fullfile (auswertungordnertemp,messung));
% Überprüfen ob Messungen vorhanden sind
check = dir(cell2mat(fullfile(auswertungordnertemp,messung)));
check = check(~ismember({check.name},{'.' '..'}));
if size(check,1) == 0
    msgbox('Keine Messungen vorhanden');
else
    
    %Überprüfen ob bereits ausgewertet wurde
    checkfolder2 = fullfile(auswertungordnertemp,messung,'*Auswertung*.mat');
    check2 = dir(cell2mat(checkfolder2));
    if size(check2,1) >=1
        msgbox('Bereits ausgewertet')
    else      
        %% Überprüfen ob zu viele Messungen in einem Ordner sind
        messungentemp = dir([currentfolder,'\1l*']);
        if size(messungentemp,1)>1
            msgbox('Zu viele Messungen in einem Ordner','Error')
        else 
%             try
                Messdatenerkennung(handles)
                %Tabelle laden
                chippopup_Callback(handles.chippopup, eventdata, handles)
                % %Anzeige der Messung
                laden_Callback(handles.laden,eventdata,handles);
%             catch e
%                 fprintf(1,'The identifier was:\n%s',e.identifier);
%                 fprintf(1,'There was an error! The message was:\n%s',e.message);
%                 % more error handling...
%             end
            
        end % If-Bed (Ausgewertet oder nicht)
    end %If-Bed (Überprüfung ob Messung vorhanden)
end %if-Bed. (Richtige Messanzahl in einem Ordner)


% --- Executes on button press in laden.
function laden_Callback(hObject, eventdata, handles)
set(handles.anzeigepanel,'visible','off')
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
set(handles.slideroffset,'Visible','off')
set(handles.amplbtn,'Visible','off')
set(handles.ganzmessbtn,'Visible','off')
set(handles.uitablewf,'Visible','off')
set(handles.offsetbtn,'Visible','off')
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt,'Visible','off')
set(handles.mittelwerttable,'Visible','off')
set(handles.maximumbtn,'Visible','off')
set(handles.systempressurebtn,'Visible','off')
set(handles.einstellungenbtn_krohne,'Visible','off')
set(handles.checkbox_krohne_10_mess,'Visible','off')
set(handles.plot_as_fig_btn_krohne,'Visible','off')
set(handles.selmesstable,'Visible','on')
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
set(handles.einzelmessdatabtn,'Visible','on')

%Überprüfen ob eine der mehrere Messungen angeklickt wurden und anzeigen
if size(handles.selected_cells,1) > 1 %Mehrere Messungen anzeigen
    set(handles.anzeigewfpanel,'Visible','off')
    set(handles.maxfixcheckbox,'Visible','off')
    set(handles.checkbox_maximumWF,'Visible','off')
    set(handles.einstellungenbtn_krohne,'Visible','off')
    set(handles.checkbox_krohne_10_mess,'Visible','off')
    set(handles.plot_as_fig_btn_krohne,'Visible','off')
    set(handles.checkbox_krohne_10_mess,'Visible','off')
    try
        set(handles.check,'Visible','off')
    catch
    end
    f = waitbar(0.5,'Loading Data...','windowstyle', 'modal');
    frames = java.awt.Frame.getFrames();
    frames(end).setAlwaysOnTop(1);
    
    tableinput = handles.tableinput;
    selected_cells = handles.selected_cells;
    
    messungen = cell(size(selected_cells,1),1);
    row = selected_cells(1,1);
    col = selected_cells(1,2);
    ordner = cell(1);
    allfolder = cell(size(selected_cells,1),1);
    allmatfile = cell(size(selected_cells,1),1);
    %Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
    if isempty(tableinput{row,1})==0
        ordner(1) = tableinput(row,1);
    else
        while isempty(tableinput{row,1}) == 1
            row = row-1;
            ordner(1) = tableinput(row,1);
        end
    end
    %Ergebnis Matrizen laden und als Cell-Array speichern
    ergebnissenew = cell(1,length(selected_cells));
    for a = 1:size(selected_cells,1)
        
        messungen(a,1) = tableinput(selected_cells(a,1),2);
        open = dir(cell2mat(fullfile(handles.unterordnertemp,ordner,messungen(a,1),'*-*.mat')));
        allmatfile(a,1) = cellstr(open.name);
        allfolder(a,1) = fullfile(handles.unterordnertemp,ordner,messungen(a,1),allmatfile(a,1));
        load(cell2mat(allfolder(a,1)))
        ergebnissenew(a) = {Ergebnisse};
        offsetmessnew(a) = {offsetmess};
        Korrekturfaktor(a) = mean(corfaktor);
        Maximumnew(a) = mean(maximum);
        Messgenauigkeit(a) = mean(messgenaunew);
    end
    
    % Ploten der Messungen nacheinander
    axes(handles.axes1)
    for x = 1:size(ergebnissenew,2)
        Ergebnissetemp = ergebnissenew{1,x};
        meshz(Ergebnissetemp(1,2:end),Ergebnissetemp(2:end,1),Ergebnissetemp(2:end,2:end))
        hold on
    end
    datetick('x','dd-mmm-yyyy','keepticks')
    xlabel('Zeit')
    ylabel('Masse')
    zlabel('Intensität')
    hold off
    
    %Bild einfügen und überprüfen ob Bild vorhanden
    axes(handles.bildaxes);
    txt = fopen('folder.txt');
    selpath = fgetl(txt);
    selpicpath = fgetl(txt);
    if exist(fullfile(selpicpath,strcat(cell2mat(ordner),'.png'))) == 0
        %     disp('Kein Bild vorhanden')
        set(handles.bildaxes,'Visible','off')
        set(get(handles.bildaxes,'children'),'visible','off')
    else
        set(handles.bildaxes,'Visible','on')
        axes(handles.bildaxes);
        bild = imread(fullfile(selpicpath,strcat(cell2mat(ordner),'.png')));
        image(bild);
        axis image;
        axis off
    end
    
    
    %Daten passend für UITable machen
    messungentable = cell(length(messungen)*4,1);
    variantennametable = repmat({'Varianz';'Korrekturfaktor';'Maximum';'Auflösung'},length(messungen),1);
    variantentable = cell(length(messungen)*4,1);
    
    for a = 1:length(messungen)
        counter(1)=1;
        counter(a+1) = counter(a)+4;
        messungentable(counter(a)) = messungen(a);
        variantentable(counter(a)) = {0};
        variantentable(counter(a)+1) = num2cell(Korrekturfaktor(a));
        variantentable(counter(a)+2) = num2cell(Maximumnew(a));
        variantentable(counter(a)+3) = num2cell(Messgenauigkeit(a));
        
    end
    
    selmesstableinput = [messungentable,variantennametable,variantentable];
    set(handles.selmesstable,'Data',selmesstableinput)
    
    
    set(handles.pausebtn,'visible','on')
    set(handles.selmessbtn,'visible','on')
    
    %Bild einfügen und überprüfen ob Bild vorhanden
    axes(handles.bildaxes);
    txt = fopen('folder.txt');
    selpath = fgetl(txt);
    selpicpath = fgetl(txt);
    if exist(fullfile(selpicpath,strcat(cell2mat(ordner),'.png'))) == 0
        %     disp('Kein Bild vorhanden')
        set(handles.bildaxes,'Visible','off')
        set(get(handles.bildaxes,'children'),'visible','off')
    else
        set(handles.bildaxes,'Visible','on')
        axes(handles.bildaxes);
        bild = imread(fullfile(selpicpath,strcat(cell2mat(ordner),'.png')));
        image(bild);
        axis image;
        axis off
    end
    
    
    %Daten passend für UITable machen
    messungentable = cell(length(messungen)*4,1);
    variantennametable = repmat({'Varianz';'Korrekturfaktor';'Maximum';'Auflösung'},length(messungen),1);
    variantentable = cell(length(messungen)*4,1);
    
    for a = 1:length(messungen)
        counter(1)=1;
        counter(a+1) = counter(a)+4;
        messungentable(counter(a)) = messungen(a);
        variantentable(counter(a)) = {0};
        variantentable(counter(a)+1) = num2cell(Korrekturfaktor(a));
        variantentable(counter(a)+2) = num2cell(Maximumnew(a));
        variantentable(counter(a)+3) = num2cell(Messgenauigkeit(a));
        
    end
    
    selmesstableinput = [messungentable,variantennametable,variantentable];
    set(handles.selmesstable,'Data',selmesstableinput)
    close(f)
    
    %% Eine Messung laden
else
    %Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
    if isempty(tableinput{row,1})==0
        ordner(1) = tableinput(row,1);
    else
        while isempty(tableinput{row,1}) == 1
            row = row-1;
            ordner(1) = tableinput(row,1);
        end
    end
    clear row
    row = handles.row;
    auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
    loadfolder = fullfile(auswertungordnertemp,tableinput(row,col));
    handles.mess_folder = loadfolder;
    guidata(hObject, handles)
    
    %Bild einfügen und überprüfen ob Bild vorhanden
    txt = fopen('folder.txt');
    selpath = fgetl(txt);
    selpicpath = fgetl(txt);
    if exist(fullfile(selpicpath,strcat(cell2mat(ordner),'.png'))) == 0
        %     disp('Kein Bild vorhanden')
        set(handles.bildaxes,'Visible','off')
        set(get(handles.bildaxes,'children'),'visible','off')
    else
        set(handles.bildaxes,'Visible','on')
        axes(handles.bildaxes);
        bild = imread(fullfile(selpicpath,strcat(cell2mat(ordner),'.png')));
        image(bild);
        axis image;
        axis off
    end
    %% Überprüfen um was für eine Messung es sich handelt
    %% Anzeigen der Krohne-Messung
    if strncmpi(handles.system_choice,'Krohne',6) == 1
        set(handles.selmesstable,'Visible','off')
        set(handles.slideroffset,'Visible','off')
        set(handles.amplbtn,'Visible','off')
        set(handles.ganzmessbtn,'Visible','off')
        set(handles.uitablewf,'Visible','off')
        set(handles.offsetbtn,'Visible','off')
        set(handles.offsettxt,'Visible','off')
        set(handles.ampltxt,'Visible','off')
        set(handles.maxfixcheckbox,'visible','off')
        set(handles.checkbox_maximumWF,'Visible','off')
        set(handles.anzeigewfpanel,'visible','off')
        set(handles.pausebtn,'visible','off')
        set(handles.selmessbtn,'visible','off')
        set(handles.maxfixcheckbox,'visible','off')
        set(handles.maximumbtn,'Visible','off')
        set(handles.systempressurebtn,'Visible','off')
        set(handles.thermocambtn,'visible','off')
        
        
        set(handles.anzeigepanel,'Visible','on')
        set(handles.maximumbtn,'Visible','on')
        set(handles.mittelwerttable,'Visible','on')
        set(handles.plot_as_fig_btn_krohne,'Visible','on')
        set(handles.systempressurebtn,'Visible','on')
        set(handles.thermocambtn,'Visible','on')
        try
            set(handles.check,'Visible','off')
            clear handles.check
        end
        mess_folder = cell2mat(handles.mess_folder);
        matfile = dir(fullfile(mess_folder,'*Auswertung*.mat'));
        if size(matfile,1)==0
            errordlg('Keine Auswertung vorhanden, bitte vorher auswerten')
        else
            handles.matfile = matfile;
            sel_path = fullfile(mess_folder,matfile.name);
            handles.sel_path = sel_path;
            load(fullfile(mess_folder,matfile.name));
            axes(handles.axes1);
            guidata(hObject, handles)
            %Überprüfen ob Systemdruck mit ausgewertet wurde
            if exist('systempressure') ==0
                set(handles.systempressurebtn,'Enable','off')
            else
                set(handles.systempressurebtn,'Enable','on')
            end
            
            %Überprüfen ob Maximum mit ausgewertet wurde
            if exist('maximum') ==0
                set(handles.maximumbtn,'Enable','off')
            else
                set(handles.maximumbtn,'Enable','on')
            end
            %Überprüfen ob Temperaturmessung vorhanden ist
            tempfile = dir(fullfile(cell2mat(loadfolder),'Temperatur*.mat'));
            if size(tempfile,1)==0
                set(handles.tempbtn,'Enable','off')
            else
                set(handles.tempbtn,'Enable','on')
            end
            
            %Überprüfen ob ThermoCamDaten verfügbar sind
            thermofile = dir(fullfile(cell2mat(loadfolder),'Thermo*.mat'));
            if size(thermofile,1) == 0
                set(handles.thermocambtn,'Enable','off')
            else
                set(handles.thermocambtn,'Enable','on')
            end
            
            N=1330;
            M=650;
            if size(Stromstaerke,2) < 10
                set(handles.checkbox_krohne_10_mess,'Visible','off');
                for a = 1:size(Stromstaerke,2)
                    plot(Masse,Stromstaerke(1:end,a),'DisplayName',datestr(mess_time(a),'HH:MM:SS'))
                    xlabel('Masse [m/z]')
                    ylabel('I[A]')
                    hold on
                    % Checkboxes einfügen
                    handles.check(a)=uicontrol('style','checkbox','string', ...
                        datestr(mess_time(a),'HH:MM:SS'),'tag',mess_time(a), ...
                        'Value',1,'Visible','on', ...
                        'position',[N-150 M/2-a*20 100 25],'userdata',a, ...
                        'callback',{@CheckboxKrohneSys,a,handles});
                    
                end
                guidata(hObject, handles)
                title({cell2mat(einstellungen(1)),cell2mat(einstellungen(end))},'Interpreter', 'none')
                hold off
                legend show
            else
                axes(handles.axes1);
                set(handles.checkbox_krohne_10_mess,'Visible','on')
                meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
                datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
                xlabel('Zeit')
                ylabel('Masse')
                zlabel('Intensität')
                axis tight
                colormap parula
            end
            
            try
                %Mittelwerte berechnen und überprüfen ob Korrekturfaktor vorhanden ist
                if  size(einstellungen,1) <= 1
                    Maximumnew = mean(maximum);
                    Messgenauigkeit = mean(messgenaunew);
                    
                    %Tabelle erstellen
                    table = {'Maximum',Maximumnew;'Auflösung',Messgenauigkeit};
                    set(handles.mittelwerttable,'Data',table)
                else
                    Korrekturfaktor = mean(corfaktor);
                    Maximumnew = mean(maximum);
                    Messgenauigkeit = mean(messgenaunew);
                    
                    %Tabelle erstellen
                    table = {'Korrekturfaktor',Korrekturfaktor;'Maximum',Maximumnew;'Auflösung',Messgenauigkeit};
                    set(handles.mittelwerttable,'Data',table)
                end
            catch
                errordlg('Nicht alle Daten vorhanden, bitte Auswertung löschen und erneut auswerten')
            end
            axes(handles.axes1);
        end
    elseif strncmpi(tableinput(row,col),'WF',2) == 1 %Art der Messung überprüfen
        set(handles.einzelmessdatabtn,'Visible','off')
        set(handles.einstellungenbtn_krohne,'Visible','off')
        set(handles.checkbox_krohne_10_mess,'Visible','off')
        set(handles.plot_as_fig_btn_krohne,'Visible','off')
        %Überprüfen ob eine Mat-File vorhanden ist
        checkfolder = fullfile(loadfolder,'*.mat');
        check = dir(cell2mat(checkfolder));
        if size(check,1) == 0
            msgbox('Keine MAT-Datei vorhanden')
        else
            try
                set(handles.check,'Visible','off')
            catch
            end
            set(handles.pausebtn,'visible','off')
            set(handles.selmessbtn,'visible','off')
            set(handles.slideroffset,'Visible','on')
            set(handles.amplbtn,'Visible','on')
            set(handles.ganzmessbtn,'Visible','on')
            set(handles.uitablewf,'Visible','on')
            set(handles.offsetbtn,'Visible','on')
            set(handles.offsettxt,'Visible','off')
            set(handles.ampltxt,'Visible','on')
            set(handles.maxfixcheckbox,'visible','on')
            set(handles.checkbox_maximumWF,'Visible','on')
            set(handles.mittelwerttable,'Visible','off')
            set(handles.maximumbtn,'Visible','off')
            set(handles.systempressurebtn,'Visible','off')
            set(handles.thermocambtn,'visible','off')
            set(handles.anzeigepanel,'visible','off')
            set(handles.selmesstable,'Visible','off')
            
            axes(handles.axes1);
            chipttestfile = dir(fullfile(cell2mat(loadfolder),'Chiptest*.mat'));
            if size(chipttestfile,1)==0
                set(handles.chiptestbtn,'enable','off')
            else
                set(handles.chiptestbtn,'enable','on')
            end
            matfile = dir(fullfile(cell2mat(loadfolder),'*Auswertung*.mat'));
            handles.matfile = matfile;
            load(fullfile(cell2mat(loadfolder),matfile(1).name))
            %Plot der ersten Messungen für Uwampl
            [col] = find(Uwamplitude == Uwamplitude(2));
            txtdisp = sprintf('Uwampl = %f', Uwamplitude(2));
            set(handles.ampltxt,'String',txtdisp)
            meshz(Uwoffset(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
            xlabel('Wanderfeldoffset')
            ylabel('Masse')
            zlabel('Intensität')
            % Reset der Farben für die Achse
            colormap parula
            
            set(handles.anzeigewfpanel,'visible','on')
            
            if get(handles.maxfixcheckbox,'Value') == 1 % Auf Maximum fixieren
                maxvalue = max(max(Ergebnisse(2:end,2:end)));
                minvalue = min(min(Ergebnisse(2:end,2:end)));
                axis(handles.axes1);
                zlim([minvalue maxvalue])
            else
                axis tight
            end
            
            if get(handles.checkbox_maximumWF,'Value') == 1 % Mittelwerte anzeigen
                hold on
                scatter3(Uwoffset(col),maximum_masse(col),maximum(col),'filled','red')
                hold off
            end
            
            %UI Table für den Startwert von Uwampl
            messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
            set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwoffset(col)))
            uwae = Uwamplitude(end);
            handles.uwae = uwae;
            sliderstep = uwastep/(uwae-uwas);
            handles.sliderstep = sliderstep;
            guidata(hObject, handles)
            set(handles.slideroffset,'SliderStep',[sliderstep,sliderstep],'Min',uwas,'Max',uwae,'Value',uwas)
        end
    elseif strncmpi(tableinput(row,col),'LZ',2) == 1
        set(handles.einstellungenbtn_krohne,'Visible','off')
        set(handles.checkbox_krohne_10_mess,'Visible','off')
        set(handles.plot_as_fig_btn_krohne,'Visible','on')
        %Überprüfen ob eine Mat-File vorhanden ist
        checkfolder = fullfile(loadfolder,'*Auswertung*.mat');
        check = dir(cell2mat(checkfolder));
        if size(check,1) == 0
            msgbox('Keine MAT-Datei vorhanden')
        else
            
            %Überprüfen ob ThermoCamDaten verfügbar sind
            thermofile = dir(fullfile(cell2mat(loadfolder),'Thermo*.mat'));
            
            if size(thermofile,1) == 0
                set(handles.thermocambtn,'Enable','off')
            else
                set(handles.thermocambtn,'Enable','on')
            end
            
            %Überprüfen ob Temperaturmessung vorhanden ist
            tempfile = dir(fullfile(cell2mat(loadfolder),'Temperatur*.mat'));
            
            if size(tempfile,1)==0
                set(handles.tempbtn,'Enable','off')
            else
                set(handles.tempbtn,'Enable','on')
            end
            try
                set(handles.check,'Visible','off')
            catch
            end
            set(handles.selmesstable,'Visible','off')
            set(handles.slideroffset,'Visible','off')
            set(handles.amplbtn,'Visible','off')
            set(handles.ganzmessbtn,'Visible','off')
            set(handles.uitablewf,'Visible','off')
            set(handles.offsetbtn,'Visible','off')
            set(handles.offsettxt,'Visible','off')
            set(handles.ampltxt,'Visible','off')
            set(handles.maxfixcheckbox,'visible','off')
            set(handles.checkbox_maximumWF,'Visible','off')
            set(handles.anzeigewfpanel,'visible','off')
            set(handles.pausebtn,'visible','off')
            set(handles.selmessbtn,'visible','off')
            set(handles.maxfixcheckbox,'visible','off')
            set(handles.mittelwerttable,'Visible','on')
            set(handles.maximumbtn,'Visible','on')
            set(handles.systempressurebtn,'Visible','on')
            set(handles.thermocambtn,'visible','on')
            set(handles.anzeigepanel,'visible','on')
            axes(handles.axes1);
            matfile = dir(fullfile(cell2mat(loadfolder),'*Auswertung*.mat'));
            handles.matfile = matfile;
            load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
            meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
            datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
            xlabel('Zeit')
            ylabel('Masse')
            zlabel('Intensität')
            axis tight
            % Reset der Farben für die Achse
            colormap parula
            set(handles.slideroffset,'Visible','off')
            set(handles.sliderampl,'Visible','off')
            set(handles.uitablewf,'Visible','off')
            
            %Überprüfen ob Systemdruck mit ausgewertet wurde
            load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
            if exist('systempressure') ==0
                set(handles.systempressurebtn,'Enable','off')
            else
                set(handles.systempressurebtn,'Enable','on')
            end
            
            %Mittelwerte berechnen und überprüfen ob Korrekturfaktor vorhanden ist
            if  size(einstellungen,1) <= 1
                Maximumnew = mean(maximum);
                Messgenauigkeit = mean(messgenaunew);
                
                %Tabelle erstellen
                table = {'Maximum',Maximumnew;'Auflösung',Messgenauigkeit};
                set(handles.mittelwerttable,'Data',table)
            else
                Korrekturfaktor = mean(corfaktor);
                Maximumnew = mean(maximum);
                Messgenauigkeit = mean(messgenaunew);
                
                %Tabelle erstellen
                table = {'Korrekturfaktor',Korrekturfaktor;'Maximum',Maximumnew;'Auflösung',Messgenauigkeit};
                set(handles.mittelwerttable,'Data',table)
            end
            guidata(hObject, handles)
        end
    
        
    end
    
    
end % Ende Überprüfung ob mehrere Messungen angeklickt wurden

function CheckboxKrohneSys(source, data, index, handles)
mess_folder = cell2mat(handles.mess_folder);
mess_data = dir(fullfile(mess_folder,'*Auswertung*.mat'));
%     time_temp = evalin('base','time_temp');
sel_checkbox = get(source,'String');
checkbox_val = get(source,'Value');
checkbox_tag = get(source,'Tag');
ax = handles.axes1;
ax_lines = findobj(ax,'Type','line');
hold on
if checkbox_val == 0
    for a = 1:length(ax_lines);
        if strcmp(ax_lines(a).DisplayName,sel_checkbox) == 1
            delete(ax_lines(a));
        end
    end
else
    axes(handles.axes1);
    load(fullfile(mess_folder,mess_data.name))
    mess_row = find(checkbox_tag == mess_time);
    plot(Masse, Stromstaerke(1:end,mess_row),'DisplayName',datestr(mess_time(mess_row),'HH:MM:SS'))
end
hold off
legend show




% --- Executes on button press in speichern.
function speichern_Callback(hObject, eventdata, handles)
% hObject    handle to speichern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Speichern anpassen an Art der Messung
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);

%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
clear row
row = handles.row;
auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
mess_folder = fullfile(auswertungordnertemp,tableinput(row,col));
handles.mess_folder = mess_folder;

matfile = dir(fullfile(cell2mat(mess_folder),'*Auswertung*.mat'));

if size(matfile,1)==0
   errordlg('Keine Auswertungsdatei gefunden') 
else
    save_path=uigetdir;
    movefile(fullfile(cell2mat(mess_folder),matfile.name),fullfile(save_path,matfile.name))
end
chippopup_Callback(handles.chippopup, eventdata, handles)
disp('MAT-File gespeichert')

% --- Executes on button press in auswahl.
function auswahl_Callback(hObject, eventdata, handles)
selpath = uigetdir;
handles.selpath = selpath;
txt = fopen('folder.txt','wt');
fprintf(txt,'%s',selpath);
guidata(hObject, handles)
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')

% --- Executes on button press in aktualisieren.
function aktualisieren_Callback(hObject, eventdata, handles)


%%Tools unsichtbar/sichtbar machen
set(handles.pausebtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.testbtn,'visible','off')
set(handles.slideroffset,'Visible','off')
set(handles.amplbtn,'Visible','off')
set(handles.ganzmessbtn,'Visible','off')
set(handles.uitablewf,'Visible','off')
set(handles.sliderampl,'Visible','off')
set(handles.offsetbtn,'Visible','off')
set(handles.bildaxes,'Visible','off')
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt,'Visible','off')
set(handles.mittelwerttable,'Visible','off')
set(handles.selmesstable,'Visible','off')
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
set(handles.maximumbtn,'Visible','off')
set(handles.systempressurebtn,'Visible','off')
set(handles.einzelmessdatabtn,'Visible','off')
set(handles.thermocambtn,'visible','off')
set(handles.anzeigepanel,'visible','off')
set(handles.anzeigewfpanel,'visible','off')
set(handles.maxfixcheckbox,'Visible','off')
set(handles.checkbox_maximumWF,'Visible','off')
set(handles.einstellungenbtn_krohne,'Visible','off')
set(handles.checkbox_krohne_10_mess,'Visible','off')
set(handles.plot_as_fig_btn_krohne,'Visible','off')
try
    set(handles.check,'Visible','off')
    clear handles.check
end

guiversion = {'1_3'};
handles.guiversion = guiversion;
guidata(hObject, handles)
% UIWAIT makes AuswertungGUI1_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
try
    if isfile(fullfile(cd,'folder.txt')) == 0
        errordlg('Keinen Messordner ausgewählt, bitte auswählen!')
    else
        fid = fopen('folder.txt');
        mess_folder = fgetl(fid);
        fclose(fid);
        try
            gui_funk_path ='GUI-Funktionen';
            addpath(fullfile(mess_folder,gui_funk_path));
        catch
            errordlg('GUI-Funktionen nicht vorhanden. Bitte in Messordner GUI-Funktionen einbinden oder falschen Messordner ausgewählt');
        end
        
        RUB_sys_dir = dir(fullfile(mess_folder,'RUB*'));
        Krohne_sys_dir = dir(fullfile(mess_folder,'Krohne*'));
        
        system_popup_input = {RUB_sys_dir.name;Krohne_sys_dir.name};
        
        set(handles.system_popup,'String',system_popup_input)
        system_choice = get(handles.system_popup,'String');
        system_choice_val = get(handles.system_popup,'Value');
        %% Auslesen der ersten Ordner und anzeigen
        system_choice = cell2mat(system_choice(system_choice_val));
        
        % Chiptypen und Charge aus Orndernamen auslesen
        mess_folder_chiptypen = fullfile(mess_folder,system_choice);
        chiptypen = dir(mess_folder_chiptypen);
        chiptypen = chiptypen(~ismember({chiptypen.name},{'.' '..'}));%unnötige Zeilen entfernen
        for a = 1:size(chiptypen,1)
            charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
            charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
            charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
            zahler_charge(a) = size(charge_temp,1);
        end
        charge = cell(size(chiptypen,1),max(zahler_charge));
        charge_mit_typen = charge;
        
        for a = 1:size(chiptypen,1)
            charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
            charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
            charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
            for b = 1:size(charge_temp,1)
                charge(a,b) = {charge_temp(b).name};
                charge_mit_typen(a,b) = strcat(chiptypen(a).name,'/',{charge_temp(b).name});
            end
        end
        
        %Daten passend für Chippopup machen
        chippopup_input = reshape(charge_mit_typen, size(charge_mit_typen,1)*size(charge_mit_typen,2), 1);
        chippopup_input = sort(chippopup_input(~cellfun('isempty',chippopup_input)));
        set(handles.chippopup,'String',chippopup_input);
        
        %% Daten für handles speichern
        handles.mess_folder = mess_folder;
        handles.mess_folder_chiptypen = mess_folder_chiptypen;
        handles.system_choice = system_choice;
        guidata(hObject, handles)
        
        % Chipopup aufrufen
        chippopup_Callback(handles.laden,eventdata,handles);
        
    end
catch
    system_popup_input = {'Systemwahl'};
    set(handles.system_popup,'String',system_popup_input)
    errordlg('Keinen Messordner oder falschen Messordner ausgewählt, bitte auswählen!')
    
end 




function tabelle_CellSelectionCallback(hObject, eventdata, handles)


if isempty(eventdata.Indices)==1
    
else
    row = eventdata.Indices(1);
    handles.row = row;
    col = eventdata.Indices(2);
    handles.col = col;
    selected_cells = eventdata.Indices;
    handles.selected_cells = selected_cells;
    guidata(hObject, handles)
end




% --- Executes when entered data in editable cell(s) in tabelle.
function tabelle_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabelle (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)









% --- Executes on button press in checkboxauswertung.
function checkboxauswertung_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxauswertung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxauswertung


% --- Executes on button press in checkboxmessgenau.
function checkboxmessgenau_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxmessgenau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxmessgenau


% --- Executes on slider movement.
function slideroffset_Callback(hObject, eventdata, handles)
% hObject    handle to slideroffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slid
%% Slider Funktion
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt, 'Visible','on')
%Letzte Plot Ansicht auslesen und einstellen
axes(handles.axes1);
[caz cel] = view;
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
val = round(get(handles.slideroffset,'Value')*1000)/1000;
[col2]=find(Uwamplitude(:)>=val,1,'first');
newval=Uwamplitude(col2);
txtdisp = sprintf('Uwampl = %f',newval);
set(handles.ampltxt,'String',txtdisp)
[col]=find(Uwamplitude(:)==newval);
set(handles.slideroffset,'Value',newval);
meshz(Uwoffset(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
view(handles.axes1, [caz cel]);
title('Wanderfeldmessung')
xlabel('Wanderfeldoffset')
ylabel('Masse')
zlabel('Intensität')

if get(handles.maxfixcheckbox,'Value') == 1 % Auf Maximum fixieren
    maxvalue = max(max(Ergebnisse(2:end,2:end)));
    minvalue = min(min(Ergebnisse(2:end,2:end)));
    axis(handles.axes1);
    zlim([minvalue maxvalue])
else
    axis tight
end

if get(handles.checkbox_maximumWF,'Value') == 1 % Maximum anzeigen
    hold on
    scatter3(Uwoffset(col),maximum_masse(col),maximum(col),'filled','red')
    hold off
end
%% UITable Funktion
messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwoffset(col)))




% --- Executes during object creation, after setting all properties.
function slideroffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideroffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ganzmessbtn.
function ganzmessbtn_Callback(hObject, eventdata, handles)
% hObject    handle to ganzmessbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
xlabel('Zeit')
ylabel('Masse')
zlabel('Intensität')
axis tight
% --- Executes on button press in amplbtn.
function amplbtn_Callback(hObject, eventdata, handles)
% hObject    handle to amplbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slideroffset,'Visible','off')
set(handles.sliderampl,'Visible','on')
set(handles.ampltxt,'Visible','off')
set(handles.offsettxt,'Visible','on')
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))

%Plot der ersten Messungen für Uwoffset
[col] = find(Uwoffset == Uwoffset(2));
txtdisp = sprintf('Uwoffset = %f',Uwoffset(2));
set(handles.offsettxt,'String',txtdisp);
meshz(Uwamplitude(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
xlabel('Wanderfeldamplitude')
ylabel('Masse')
zlabel('Intensität')

if get(handles.maxfixcheckbox,'Value') == 1 % Auf Maximum fixieren
    maxvalue = max(max(Ergebnisse(2:end,2:end)));
    minvalue = min(min(Ergebnisse(2:end,2:end)));
    axis(handles.axes1);
    zlim([minvalue maxvalue])
else
    axis tight
end

if get(handles.checkbox_maximumWF,'Value') == 1 % Maximum anzeigen
    hold on
    scatter3(Uwamplitude(col),maximum_masse(col),maximum(col),'filled','red')
    hold off
end
%UI Table für den Startwert von Uwampl
messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwamplitude(col)))

uwoe = Uwoffset(end);
sliderstep = uwostep/(uwoe-uwos);
set(handles.sliderampl,'SliderStep',[sliderstep,sliderstep],'Min',uwos,'Max',uwoe,'Value',uwos)




% --- Executes on slider movement.
function sliderampl_Callback(hObject, eventdata, handles)
% hObject    handle to sliderampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.ampltxt,'Visible','off')
set(handles.offsettxt, 'Visible','on')
axes(handles.axes1);
[caz cel] = view;
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
val = round(get(handles.sliderampl,'Value')*1000)/1000;
[col2]=find(Uwoffset(:)>=val,1,'first');
newval=Uwoffset(col2);
txtdisp = sprintf('Uwoffset = %f',newval);
set(handles.offsettxt,'String',txtdisp)
[col]=find(Uwoffset(:)==newval);
set(handles.sliderampl,'Value',newval);
meshz(Uwamplitude(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
view(handles.axes1,[caz cel])
title('Wanderfeldmessung')
xlabel('Wanderfeldamplitude')
ylabel('Masse')
zlabel('Intensität')
if get(handles.maxfixcheckbox,'Value') == 1 % Auf Maximum fixieren
    maxvalue = max(max(Ergebnisse(2:end,2:end)));
    minvalue = min(min(Ergebnisse(2:end,2:end)));
    axis(handles.axes1);
    zlim([minvalue maxvalue])
else
    axis tight
end

if get(handles.checkbox_maximumWF,'Value') == 1 % Maximum anzeigen
    hold on
    scatter3(Uwamplitude(col),maximum_masse(col),maximum(col),'filled','red')
    hold off
end

%Tabelle der Messgenauigkeiten & Quantisierungsstufen
messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
%         tabelle.ColumnName = {'Messgenauigkeit','Quant.Stf.'};
set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwamplitude(col)))


%  messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
% set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwoffset(col)))

% --- Executes during object creation, after setting all properties.
function sliderampl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in offsetbtn.
function offsetbtn_Callback(hObject, eventdata, handles)
% hObject    handle to offsetbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sliderampl,'Visible','off')
set(handles.slideroffset,'Visible','on')
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt,'Visible','on')
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
%Plot der ersten Messungen für Uwampl
[col] = find(Uwamplitude == Uwamplitude(2));
txtdisp = sprintf('Uwampl = %f', Uwamplitude(2));
set(handles.ampltxt,'String',txtdisp);
meshz(Uwoffset(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
xlabel('Wanderfeldoffset')
ylabel('Masse')
zlabel('Intensität')
if get(handles.maxfixcheckbox,'Value') == 1 % Auf Maximum fixieren
    maxvalue = max(max(Ergebnisse(2:end,2:end)));
    minvalue = min(min(Ergebnisse(2:end,2:end)));
    axis(handles.axes1);
    zlim([minvalue maxvalue])
else
    axis tight
end

if get(handles.checkbox_maximumWF,'Value') == 1 % Maximum anzeigen
    hold on
    scatter3(Uwoffset(col),maximum_masse(col),maximum(col),'filled','red')
    hold off
end


%UI Table für den Startwert von Uwampl
messgenautable = transpose([messgenaunew(col);quantstufen(col)]);
set(handles.uitablewf,'Data',messgenautable,'RowName',transpose(Uwoffset(col)))

uwae = Uwamplitude(end);
sliderstep = uwastep/(uwae-uwas);
set(handles.slideroffset,'SliderStep',[sliderstep,sliderstep],'Min',uwas,'Max',uwae,'Value',uwas)



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bildfolderbtn.
function bildfolderbtn_Callback(hObject, eventdata, handles)
% hObject    handle to bildfolderbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Beim Dateiordner bitte kein Leerzeichen setzen
selpicpath = uigetdir
handles.selpicpath = selpicpath;
txttemp = fopen('folder.txt');
selpath = fgetl(txttemp)
paths = cellstr(char(selpath,selpicpath))
txt = fopen('folder.txt','wt');
% dlmwrite('folder.txt',paths,'delimiter','')
for k = 1:size(paths,1)
    fprintf(txt,'%s\n',cell2mat(paths(k,:)));
end


guidata(hObject, handles)
%     fid = fopen('SampleScript.m','w');
%     for r=1:size(CellArray,1)
%         fprintf(fid,'%s\n',CellArray(r,:));
%     end


% --- Executes on button press in loschenbtn.
function loschenbtn_Callback(hObject, eventdata, handles)
% hObject    handle to loschenbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);

%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
clear row
row = handles.row;
auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
loadfolder = fullfile(auswertungordnertemp,tableinput(row,col));
delete(fullfile(cell2mat(loadfolder),'*Auswertung*.mat'))
tableinput(row,col+1) = {'*'};
tableinput(row,col+2) = {'*'};
tableinput(row,col+3) = {'*'};
handles.tableinput = tableinput;
guidata(hObject,handles)
set(handles.tabelle,'Data', tableinput)

disp('Auswertung gelöscht')

% --- Executes on button press in selmessbtn.
function selmessbtn_Callback(hObject, eventdata, handles)
% hObject    handle to selmessbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Mehrere Langzeitmessungen anzeigen auf Masse angepasst
f = waitbar(0.5,'Loading Data...','windowstyle', 'modal');
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(1);

tableinput = handles.tableinput;
selected_cells = handles.selected_cells;
messungen = cell(size(selected_cells,1),1);
row = selected_cells(1,1);
col = selected_cells(1,2);
ordner = cell(1);
allfolder = cell(size(selected_cells,1),1);
allmatfile = cell(size(selected_cells,1),1);
%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
%Ergebnis Matrizen laden und als Cell-Array speichern
ergebnissenew = cell(1,length(selected_cells));
for a = 1:size(selected_cells,1)
    
    messungen(a,1) = tableinput(selected_cells(a,1),2);
    open = dir(cell2mat(fullfile(handles.unterordnertemp,ordner,messungen(a,1),'*Auswertung*.mat')));
    allmatfile(a,1) = cellstr(open.name);
    allfolder(a,1) = fullfile(handles.unterordnertemp,ordner,messungen(a,1),allmatfile(a,1));
    load(cell2mat(allfolder(a,1)))
    ergebnissenew(a) = {Ergebnisse};
    offsetmessnew(a) = {offsetmess};
    Korrekturfaktor(a) = mean(corfaktor);
    Maximumnew(a) = mean(maximum);
    Messgenauigkeit(a) = mean(messgenaunew);
    
    
end

%Überprüfen der längsten Messung
for b = 1:length(ergebnissenew)
    grossetemp(b) = size(ergebnissenew{b},1);
end

grosse = max(grossetemp);
[col1] = find(grosse==grossetemp,1);
for c = 1:length(ergebnissenew)
    wert1(c) = abs(size(ergebnissenew{c},1)-grosse);
end

%Matritzen aneinander anhängen
bezugsmatrix = ergebnissenew{col1};
massen = bezugsmatrix(:,1);
for d = 1:length(ergebnissenew)
    if wert1(d) ~= 0
        massenanh = bezugsmatrix((grosse-wert1(d)+1):end,1);
        offsetanh = repmat(offsetmessnew{d},length(massenanh),1);
        anhang = horzcat(massenanh,offsetanh);
        ergebnissenew{d} = vertcat(ergebnissenew{d},anhang);
        ergebnistemp = ergebnissenew{d};
        ergebnistemp(:,1)=[];
        ergebnissenew{d} = ergebnistemp;
    else
        ergebnistemp = ergebnissenew{d};
        ergebnistemp(:,1)=[];
        ergebnissenew{d} = ergebnistemp;
    end
end

%Zusammenhängen und Ploten
axes(handles.axes1)
ergebnisseganz = horzcat(massen,ergebnissenew{1:end});
minimumzaxis = min(min(ergebnisseganz(2:end,2:end)));
maximumzaxis =  max(max(ergebnisseganz(2:end,2:end)));

% Ergebnisse nach Zeit sortieren
ergebnisse_sorted_by_time = ergebnisseganz(:,2:end);
[~,idx] = sort(ergebnisse_sorted_by_time(1,:));
ergebnisse_sorted_by_time = ergebnisse_sorted_by_time(:,idx);
ergebnisseganz = [ergebnisseganz(:,1) ergebnisse_sorted_by_time];

handles.ergebnissenew = ergebnissenew;
handles.ergebnisseganz = ergebnisseganz;
guidata(hObject,handles)
meshz(ergebnisseganz(1,2:end),ergebnisseganz(2:end,1),ergebnisseganz(2:end,2:end))
datetick('x','dd-mmm-yyyy','keepticks')
zlim([minimumzaxis maximumzaxis])
xlabel('Zeit')
ylabel('Masse')
zlabel('Intensität')
close(f)

% --- Executes on button press in pausebtn.
function pausebtn_Callback(hObject, eventdata, handles)
% hObject    handle to pausebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.anzeigepanel,'visible','off')
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
%% Mehrere Langzeitmessungen anzeigen mit Pause
if size(handles.selected_cells,1) < 2
    msgbox('Messungen auswählen')
else
    f = waitbar(0.5,'Loading Data...','windowstyle', 'modal');
    frames = java.awt.Frame.getFrames();
    frames(end).setAlwaysOnTop(1);
    set(handles.slideroffset,'Visible','off')
    set(handles.amplbtn,'Visible','off')
    set(handles.ganzmessbtn,'Visible','off')
    set(handles.uitablewf,'Visible','off')
    set(handles.offsetbtn,'Visible','off')
    set(handles.offsettxt,'Visible','off')
    set(handles.ampltxt,'Visible','off')
    set(handles.mittelwerttable,'Visible','off')
    set(handles.maximumbtn,'Visible','off')
    set(handles.systempressurebtn,'Visible','off')
    set(handles.selmesstable,'Visible','on')
    
    tableinput = handles.tableinput;
    selected_cells = handles.selected_cells;
    
    messungen = cell(size(selected_cells,1),1);
    row = selected_cells(1,1);
    col = selected_cells(1,2);
    ordner = cell(1);
    allfolder = cell(size(selected_cells,1),1);
    allmatfile = cell(size(selected_cells,1),1);
    %Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
    if isempty(tableinput{row,1})==0
        ordner(1) = tableinput(row,1);
    else
        while isempty(tableinput{row,1}) == 1
            row = row-1;
            ordner(1) = tableinput(row,1);
        end
    end
    
    %Ergebnis Matrizen laden und als Cell-Array speichern
    ergebnissenew = cell(1,length(selected_cells));
    for a = 1:size(selected_cells,1)
        
        messungen(a,1) = tableinput(selected_cells(a,1),2);
        open = dir(cell2mat(fullfile(handles.unterordnertemp,ordner,messungen(a,1),'*Auswertung*.mat')));
        allmatfile(a,1) = cellstr(open.name);
        allfolder(a,1) = fullfile(handles.unterordnertemp,ordner,messungen(a,1),allmatfile(a,1));
        load(cell2mat(allfolder(a,1)))
        ergebnissenew(a) = {Ergebnisse};
        offsetmessnew(a) = {offsetmess};
        Korrekturfaktor(a) = mean(corfaktor);
        Maximumnew(a) = mean(maximum);
        Messgenauigkeit(a) = mean(messgenaunew);
        
    end
    
    %Überprüfen der längsten Messung
    for b = 1:length(ergebnissenew)
        grossetemp(b) = size(ergebnissenew{b},1);
    end
    
    grosse = max(grossetemp);
    [col1] = find(grosse==grossetemp,1);
    for c = 1:length(ergebnissenew)
        wert1(c) = abs(size(ergebnissenew{c},1)-grosse);
        gesamtsize(c) = size(ergebnissenew{c},2);
    end
    
    pausenwerte = round(sum(gesamtsize)*0.08); %x Werte werden angehängt
    
    %% Matritzen aneinander anhängen + Pause
    bezugsmatrix = ergebnissenew{col1};
    massen = bezugsmatrix(:,1);
    for d = 1:length(ergebnissenew)
        if wert1(d) ~= 0
            massenanh = bezugsmatrix((grosse-wert1(d)+1):end,1);
            offsetanh = repmat(offsetmessnew{d},length(massenanh),1);
            anhang = horzcat(massenanh,offsetanh);
            ergebnissetemp1 = ergebnissenew{d};
            minimum = min(ergebnissetemp1(end));
            ergebnissenew{d} = vertcat(ergebnissenew{d},anhang);
            minanhtemp = repmat(ones(1,pausenwerte)*(minimum-minimum*0.1),size(bezugsmatrix,1)-1,1);
            lasttime = ergebnissetemp1(1,end);
            
            %Stündlich Zeit zum letzten Zeitwert addieren hier 7% der Gesamtmessungen Stunden (+0,0417 = + 1Std)
            for y = 1:pausenwerte
                addtime(y) = y*0.0417;
                newtime(y) = lasttime+addtime(y);
            end
            
            minanh = vertcat(newtime,minanhtemp);
            ergebnissenew{d} = horzcat(ergebnissenew{d},minanh);
            ergebnistemp = ergebnissenew{d};
            ergebnistemp(:,1)=[];
            ergebnissenew{d} = ergebnistemp;
            
        else
            
            ergebnissetemp1 = ergebnissenew{d};
            minimum = min(ergebnissetemp1(end));
            minanhtemp = repmat(ones(1,pausenwerte)*(minimum-minimum*0.1),size(bezugsmatrix,1)-1,1);
            lasttime = ergebnissetemp1(1,end);
            
            %Stündlich Zeit zum letzten Zeitwert addieren hier 15 Stunden (+0,0417 = + 1Std)
            for y = 1:pausenwerte
                addtime(y) = y*0.0417;
                newtime(y) = lasttime+addtime(y);
            end
            
            minanh = vertcat(newtime,minanhtemp);
            ergebnissenew{d} = horzcat(ergebnissenew{d},minanh);
            ergebnistemp = ergebnissenew{d};
            ergebnistemp(:,1)=[];
            ergebnissenew{d} = ergebnistemp;
        end
    end
    
    axes(handles.axes1)
    ergebnisseganz = horzcat(massen,ergebnissenew{1:end});
    handles.ergebnissenew = ergebnissenew;
    handles.ergebnisseganz = ergebnisseganz;
    guidata(hObject,handles)
    
    %ersetze Zeitwerte mit Messungsanzahl
    ergebnisseganznew= ergebnisseganz;
    ersatz = 1:length(ergebnisseganz(1,2:end));
    ergebnisseganznew(1,2:end) = ersatz;
    %lösche den letzten Anhang
    deletecol = size(ergebnisseganznew,2);
    deletecol = deletecol-pausenwerte;
    ergebnisseganznew(:,deletecol:end)=[];
    
    assignin('base','ergebnisseganznew',ergebnisseganznew)
    assignin('base','pausenwerte',pausenwerte)
    
    %Plot mit Pause Z Achse skaliert min maxwerte
    minimumzaxis = min(min(ergebnisseganznew(2:end,2:end)));
    maximumzaxis =  max(max(ergebnisseganznew(2:end,2:end)));
    meshz(ergebnisseganznew(1,2:end),ergebnisseganznew(2:end,1),ergebnisseganznew(2:end,2:end))
    % datetick('x','dd-mmm-yyyy','keepticks')
    zlim([minimumzaxis maximumzaxis])
    xlabel('Messungen')
    ylabel('Masse')
    zlabel('Intensität')
    % axis tight
    
    
    
    
    %Bild einfügen und überprüfen ob Bild vorhanden
    axes(handles.bildaxes);
    txt = fopen('folder.txt');
    selpath = fgetl(txt);
    selpicpath = fgetl(txt);
    if exist(fullfile(selpicpath,strcat(cell2mat(ordner),'.png'))) == 0
        %     disp('Kein Bild vorhanden')
        set(handles.bildaxes,'Visible','off')
        set(get(handles.bildaxes,'children'),'visible','off')
    else
        set(handles.bildaxes,'Visible','on')
        axes(handles.bildaxes);
        bild = imread(fullfile(selpicpath,strcat(cell2mat(ordner),'.png')));
        image(bild);
        axis image;
        axis off
    end
    close(f)
end

%Daten passend für UITable machen
messungentable = cell(length(messungen)*4,1);
variantennametable = repmat({'Varianz';'Korrekturfaktor';'Maximum';'Auflösung'},length(messungen),1);
variantentable = cell(length(messungen)*4,1);

for a = 1:length(messungen)
    counter(1)=1;
    counter(a+1) = counter(a)+4;
    messungentable(counter(a)) = messungen(a);
    variantentable(counter(a)+1) = num2cell(Korrekturfaktor(a));
    variantentable(counter(a)+2) = num2cell(Maximumnew(a));
    variantentable(counter(a)+3) = num2cell(Messgenauigkeit(a));
    
end

selmesstableinput = [messungentable,variantennametable,variantentable];
set(handles.selmesstable,'Data',selmesstableinput)


% --- Executes on button press in einzelmessbtn.
function einzelmessbtn_Callback(hObject, eventdata, handles)

set(handles.pausebtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.selmessbtn,'visible','off')
set(handles.testbtn,'visible','off')
set(handles.slideroffset,'Visible','off')
set(handles.amplbtn,'Visible','off')
set(handles.ganzmessbtn,'Visible','off')
set(handles.uitablewf,'Visible','off')
set(handles.sliderampl,'Visible','off')
set(handles.offsetbtn,'Visible','off')
set(handles.bildaxes,'Visible','off')
set(handles.offsettxt,'Visible','off')
set(handles.ampltxt,'Visible','off')
set(handles.mittelwerttable,'Visible','off')
set(handles.selmesstable,'Visible','off')
set(handles.anzeigepanel,'visible','off')
set(handles.anzeigewfpanel,'visible','off')
set(handles.maxfixcheckbox,'Visible','off')
set(handles.checkbox_maximumWF,'Visible','off')
set(handles.einstellungenbtn_krohne,'Visible','off')
set(handles.checkbox_krohne_10_mess,'Visible','off')
set(handles.plot_as_fig_btn_krohne,'Visible','off')

try
    set(handles.check,'Visible','off')
    clear handles.check
end
%% Einzelmessungen laden und Ploten
set(handles.einzelnextbtn,'Visible','on')
set(handles.einzelprebtn,'Visible','on')
set(handles.einzelnextbtn,'Enable','on')
set(handles.einzelprebtn,'Enable','on')
axes(handles.axes1)
counter = 1;
handles.counter = counter;
guidata(hObject,handles)
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
einzelmessordner = fullfile(handles.unterordnertemp,tableinput{row,col},'Einzelmessungen');
einzelmessopen = dir(fullfile(einzelmessordner,'*.mat'));
einzelmessopen = einzelmessopen(~ismember({einzelmessopen.name},{'.' '..'}));
if size(einzelmessopen,1)==0
    errordlg('Keine Einzelmessungen vorhanden')
    set(handles.einzelnextbtn,'Enable','off')
    set(handles.einzelprebtn,'Enable','off')
else
messname = {einzelmessopen.name};
load(fullfile(einzelmessordner,messname{counter}));
titlename = ['Chip: ',cell2mat(tableinput(row,col)),newline,'Messzeit: ',datestr(Ergebnisse(1,2))];
plot(Ergebnisse(2:end,1),Ergebnisse(2:end,2))
title(titlename)
xlabel('Masse')
ylabel('Intensität')
set(handles.mittelwerttable,'Visible', 'on')
mittelwerttable_input = {'Maximum',maximum;'Auflösung',messgenaunew;'Offset',offsetmess};
set(handles.mittelwerttable,'Data', mittelwerttable_input)
end


% --- Executes on button press in einzelnextbtn.

function einzelnextbtn_Callback(hObject, eventdata, handles)
% hObject    handle to einzelnextbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Nächste Einzelmessung laden und ploten
counter = handles.counter;
counter = counter +1;
handles.counter = counter;
guidata(hObject,handles)
axes(handles.axes1)
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
einzelmessordner = fullfile(handles.unterordnertemp,tableinput{row,col},'Einzelmessungen');
einzelmessopen = dir(fullfile(einzelmessordner,'*.mat'));
messname = {einzelmessopen.name};
if counter > size(einzelmessopen,1)
    set(handles.einzelnextbtn,'Enable','off')
else
    set(handles.einzelnextbtn,'Enable','on')
    load(fullfile(einzelmessordner,messname{counter}));
    titlename = ['Chip: ',cell2mat(tableinput(row,col)),newline,'Messzeit: ',datestr(Ergebnisse(1,2))];
    plot(Ergebnisse(2:end,1),Ergebnisse(2:end,2))
    title(titlename)
    xlabel('Masse')
    ylabel('Intensität')
    set(handles.mittelwerttable,'Visible', 'on')
    mittelwerttable_input = {'Maximum',maximum;'Auflösung',messgenaunew;'Offset',offsetmess};
    set(handles.mittelwerttable,'Data', mittelwerttable_input)
end
if counter >= 1
    set(handles.einzelprebtn,'Enable','on')
end
% --- Executes on button press in einzelprebtn.
function einzelprebtn_Callback(hObject, eventdata, handles)
% hObject    handle to einzelprebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Vorherige Einzelmessung laden und ploten
counter = handles.counter;
counter = counter -1;
handles.counter = counter;
guidata(hObject,handles)
axes(handles.axes1)
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
einzelmessordner = fullfile(handles.unterordnertemp,tableinput{row,col},'Einzelmessungen');
einzelmessopen = dir(fullfile(einzelmessordner,'*.mat'));
einzelmessopen = einzelmessopen(~ismember({einzelmessopen.name},{'.' '..'}));
messname = {einzelmessopen.name};
if counter <=0 || counter > size(einzelmessopen,1)
    set(handles.einzelprebtn,'Enable','off')
else
    set(handles.einzelprebtn,'Enable','on')
    load(fullfile(einzelmessordner,messname{counter}));
    titlename = ['Chip: ',cell2mat(tableinput(row,col)),newline,'Messzeit: ',datestr(Ergebnisse(1,2))];
    plot(Ergebnisse(2:end,1),Ergebnisse(2:end,2))
    title(titlename)
    xlabel('Masse')
    ylabel('Intensität')
    set(handles.mittelwerttable,'Visible', 'on')
    mittelwerttable_input = {'Maximum',maximum;'Auflösung',messgenaunew;'Offset',offsetmess};
    set(handles.mittelwerttable,'Data', mittelwerttable_input)
end
if counter < size(einzelmessopen,1)
    set(handles.einzelnextbtn,'Enable','on')
end


% --- Executes on button press in einstellungbtn.
function einstellungbtn_Callback(hObject, eventdata, handles)
% hObject    handle to einstellungbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
clear row
row = handles.row;
auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
loadfolder = fullfile(auswertungordnertemp,tableinput(row,col));
matfile = dir(fullfile(cell2mat(loadfolder),'*.mat'));
load(cell2mat(fullfile(loadfolder,matfile(1).name)));
f = msgbox(einstellungen);


% --- Executes on button press in checkboxtemp.
function checkboxtemp_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxtemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxtemp


% --- Executes on button press in tempbtn.
function tempbtn_Callback(hObject, eventdata, handles)
% hObject    handle to tempbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Laden der Daten
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);
set(handles.selmesstable,'Visible','off')
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')
%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
clear row
row = handles.row;
auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
loadfolder = fullfile(auswertungordnertemp,tableinput(row,col));
loadfolder = cell2mat(loadfolder);
tempfile = dir(fullfile(loadfolder,'Temperatur*.mat'));
handles.mess_folder=loadfolder;
handles.tempfile = tempfile;
guidata(hObject, handles)
%Werte in Workspace speichern für TemperaturGUI
assignin('base','tempfile',tempfile)
assignin('base','loadfolder',loadfolder)

if size(tempfile,1)==0
    msgbox('Keine Temperaturmessung vorhanden')
else
    TemperaturGUI(handles);
end




% --- Executes on button press in maximumbtn.
function maximumbtn_Callback(hObject, eventdata, handles)
% hObject    handle to maximumbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
zeit = datetime(datestr(Ergebnisse(1,2:end)));
figure
plot(zeit,maximum(2:end))
axis manual
title('Maximum über die Zeit')
ylabel('Maximum')
xlabel('Zeit')


% --- Executes on button press in systempressurebtn.
function systempressurebtn_Callback(hObject, eventdata, handles)
% hObject    handle to systempressurebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear systempressure
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
if exist('systempressure') ==0
    msgbox('Kein SystemPressure ausgewertet')
else
    zeit = datetime(datestr(Ergebnisse(1,2:end)));
    figure
    plot(zeit,systempressure)
    title('System Druck über die Zeit')
    ylabel('SystemPressure')
    xlabel('Zeit')
end


% --- Executes on button press in einzelmessdatabtn.
function einzelmessdatabtn_Callback(hObject, eventdata, handles)
% hObject    handle to einzelmessdatabtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Laden der Matfile
load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
assignin('base','Ergebnisse',Ergebnisse)
GUISlider


% --- Executes on button press in thermocambtn.
function thermocambtn_Callback(hObject, eventdata, handles)
% hObject    handle to thermocambtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Laden und Ploten der Thermokamera Daten
loadfolder = cell2mat(handles.mess_folder);
thermofile = dir(fullfile(loadfolder,'Thermo*.mat'));

if size(thermofile,1) == 0
    
    msgbox('Keine Thermokamera Daten vorhanden')
else
    load(fullfile(loadfolder,thermofile.name))
    figure
    plot(ThermoCamData.Chip)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Chip')
    
    figure
    plot(ThermoCamData.Chip_Max)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Chip Max')
    
    figure
    plot(ThermoCamData.Chip_Min)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Chip Min')
    
    figure
    plot(ThermoCamData.Wanderfeldverstrker)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Wanderfeldverstärker')
    
    figure
    plot(ThermoCamData.Wanderfeldverstrker_Max)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Wanderfeldverstärker Max')
    
    figure
    plot(ThermoCamData.Wanderfeldverstrker_Min)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Wanderfeldverstärker Min')
    
    figure
    plot(ThermoCamData.Mikrowellenverstrker)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Mikrowellenverstärker')
    
    figure
    plot(ThermoCamData.Mikrowellenverstrker_Max)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Mikrowellenverstärker Max')
    
    figure
    plot(ThermoCamData.Mikrowellenverstrker_Min)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Mikrowellebverstärker Min')
    
    figure
    plot(ThermoCamData.ZuleitungMikrowelle)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Zuleitung Mikrowelle')
    
    figure
    plot(ThermoCamData.ZuleitungMikrowelle_Max)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Zuleitung Mikrowelle Max')
    
    figure
    plot(ThermoCamData.ZuleitungMikrowelle_Min)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Zuleitung Mikrowelle Min')
    
    figure
    plot(ThermoCamData.TemperaturRaumTisch)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Raum Tisch')
    
    figure
    plot(ThermoCamData.TemperaturRaumTisch_Max)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Raum Tisch Max')
    
    figure
    plot(ThermoCamData.TemperaturRaumTisch_Min)
    xlabel('Index')
    ylabel('Temperatur')
    title('Temperatur Raum Tisch Min')
    
end


% --------------------------------------------------------------------
function OrdnerMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OrdnerMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ordnerauswahl_Callback(hObject, eventdata, handles)
% hObject    handle to ordnerauswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selpath = uigetdir;
handles.selpath = selpath;
txt = fopen('folder.txt','wt');
fprintf(txt,'%s',selpath);
guidata(hObject, handles)
set(handles.einzelnextbtn,'Visible','off')
set(handles.einzelprebtn,'Visible','off')

% --------------------------------------------------------------------
function bildordnerauswahl_Callback(hObject, eventdata, handles)
% hObject    handle to bildordnerauswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Beim Dateiordner bitte kein Leerzeichen setzen
selpicpath = uigetdir;
handles.selpicpath = selpicpath;
txttemp = fopen('folder.txt');
selpath = fgetl(txttemp)
paths = cellstr(char(selpath,selpicpath));
txt = fopen('folder.txt','wt');
% dlmwrite('folder.txt',paths,'delimiter','')
for k = 1:size(paths,1)
    fprintf(txt,'%s\n',cell2mat(paths(k,:)));
end


% --- Executes on button press in testbtn.
function testbtn_Callback(hObject, eventdata, handles)
% hObject    handle to testbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
try
    set(handles.check,'Visible','off')
catch
end

% --- Executes on button press in chiptestbtn.
function chiptestbtn_Callback(hObject, eventdata, handles)
% hObject    handle to chiptestbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadfolder = cell2mat(handles.mess_folder);
chiptestfile = dir(fullfile(loadfolder,'Chiptest*.mat'));
for a=1:size(chiptestfile,1)
    load(fullfile(loadfolder,chiptestfile(a).name))
end

markvectorEF = [60,61,71,81,91,92,102,112];

figure('units','normalized','outerposition',[0 0 1 1]) %%Im Vollbild öffnen
plot(chiptestEF(:,1))
hold on
plot(chiptestEF(:,2))
% legend('Chiptest 1','Chiptest 2')
ylim([min(chiptestEF(:,1))-min(chiptestEF(:,1))*0.2 max(chiptestEF(:,1))+max(chiptestEF(:,1))*0.2])
title('Chiptest EF')

plot(ones(length(chiptestEF))*markvectorEF(1),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 30;
y = 700;
text(x,y,'EF on','HorizontalAlignment','center')
x = 30;
y = 714;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(2),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 60.5;
y = 790;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 60.5;
y = 805;
text(x,y,'EF off','HorizontalAlignment','center')
x = 60.5;
y = 819;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(3),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 66;
y = 700;
text(x,y,'EF on','HorizontalAlignment','center')
x = 66;
y = 714;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(4),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 76;
y = 790;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 76;
y = 805;
text(x,y,'EF off','HorizontalAlignment','center')
x = 76;
y = 819;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(5),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 86;
y = 700;
text(x,y,'EF on','HorizontalAlignment','center')
x = 86;
y = 714;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(6),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 91.5;
y = 790;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 91.5;
y = 805;
text(x,y,'EF off','HorizontalAlignment','center')
x = 91.5;
y = 819;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(7),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 97;
y = 700;
text(x,y,'EF on','HorizontalAlignment','center')
x = 97;
y = 714;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(8),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 107;
y = 790;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 107;
y = 805;
text(x,y,'EF off','HorizontalAlignment','center')
x = 107;
y = 819;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEF))*markvectorEF(7),chiptestEF(:,1),'k--','LineWidth',0.5)
x = 117;
y = 700;
text(x,y,'EF on','HorizontalAlignment','center')
legend('Chiptest 1','Chiptest 2')
x = 117;
y = 714;
text(x,y,'EEX on','HorizontalAlignment','center')


markvectorEEX = [60,61,71,72,82,84,94,104,114,174,184];

figure('units','normalized','outerposition',[0 0 1 1]) %%Im Vollbild öffnen
% figure(2)
plot(chiptestEEX(:,1))
hold on
plot(chiptestEEX(:,2))
title('Chiptest EEX')
ylim([min(chiptestEEX(:,1))-min(chiptestEEX(:,1))*0.2 max(chiptestEEX(:,1))+max(chiptestEEX(:,1))*0.2])

plot(ones(length(chiptestEEX))*markvectorEEX(1),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 25;
y = 450;
text(x,y,'EEX on ')

plot(ones(length(chiptestEEX))*markvectorEEX(2),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 60.5;
y = 490;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 60.5;
y = 500;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(3),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 66;
y = 450;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(4),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 71.5;
y = 490;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 71.5;
y = 500;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(5),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 77;
y = 450;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(6),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 83;
y = 490;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 83;
y = 500;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(7),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 89;
y = 450;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(8),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 99;
y = 490;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 99;
y = 500;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(9),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 109;
y = 450;
text(x,y,'EEX on','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(10),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 144;
y = 490;
text(x,y,'\downarrow','FontSize',14,'HorizontalAlignment','center')
x = 144;
y = 500;
text(x,y,'EEX off','HorizontalAlignment','center')

plot(ones(length(chiptestEEX))*markvectorEEX(11),chiptestEEX(:,1),'k--','LineWidth',0.5)
x = 179;
y = 450;
text(x,y,'EEX on','HorizontalAlignment','center')

legend('Chiptest 1','Chiptest 2')


% --- Executes on button press in maxfixcheckbox.
function maxfixcheckbox_Callback(hObject, eventdata, handles)

if get(handles.maxfixcheckbox,'Value') == 1
    load(fullfile(handles.matfile.folder,handles.matfile.name))
    maxvalue = max(max(Ergebnisse(2:end,2:end)));
    minvalue = min(min(Ergebnisse(2:end,2:end)));
    axis(handles.axes1);
    zlim([minvalue maxvalue])
end


% --- Executes on button press in checkbox_maximumWF.
function checkbox_maximumWF_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_maximumWF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.checkbox_maximumWF,'Value') == 1
    if strcmp(get(handles.slideroffset,'visible'),'on')==1
        load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
        val = round(get(handles.slideroffset,'Value')*1000)/1000;
        [col2]=find(Uwamplitude(:)>=val,1,'first');
        newval=Uwamplitude(col2);
        [col]=find(Uwamplitude(:)==newval);
        axes(handles.axes1)
        hold on
        maximum_plot = scatter3(Uwoffset(col),maximum_masse(col),maximum(col),'filled','red');
        hold off
        
    else
        load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
        val = round(get(handles.sliderampl,'Value')*1000)/1000;
        [col2]=find(Uwoffset(:)>=val,1,'first');
        newval=Uwoffset(col2);
        txtdisp = sprintf('Uwoffset = %f',newval);
        set(handles.offsettxt,'String',txtdisp)
        [col]=find(Uwoffset(:)==newval);
        axes(handles.axes1)
        hold on
        maximum_plot = scatter3(Uwamplitude(col),maximum_masse(col),maximum(col),'filled','red');
        hold off
    end
else
    if strcmp(get(handles.slideroffset,'visible'),'on')==1
        axes(handles.axes1);
        [caz cel] = view;
        load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
        val = round(get(handles.slideroffset,'Value')*1000)/1000;
        [col2]=find(Uwamplitude(:)>=val,1,'first');
        newval=Uwamplitude(col2);
        txtdisp = sprintf('Uwampl = %f',newval);
        set(handles.ampltxt,'String',txtdisp)
        [col]=find(Uwamplitude(:)==newval);
        set(handles.slideroffset,'Value',newval);
        meshz(Uwoffset(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
        view(handles.axes1, [caz cel]);
        title('Wanderfeldmessung')
        xlabel('Wanderfeldoffset')
        ylabel('Masse')
        zlabel('Intensität')
        axis tight
        
    else
        axes(handles.axes1);
        [caz cel] = view;
        load(fullfile(cell2mat(handles.mess_folder),handles.matfile(1).name))
        val = round(get(handles.sliderampl,'Value')*1000)/1000;
        [col2]=find(Uwoffset(:)>=val,1,'first');
        newval=Uwoffset(col2);
        txtdisp = sprintf('Uwoffset = %f',newval);
        set(handles.offsettxt,'String',txtdisp)
        [col]=find(Uwoffset(:)==newval);
        set(handles.sliderampl,'Value',newval);
        meshz(Uwamplitude(col),Ergebnisse(2:end,1),Ergebnisse(2:end,col))
        view(handles.axes1, [caz cel]);
        title('Wanderfeldmessung')
        xlabel('Wanderfeldamplitude')
        ylabel('Masse')
        zlabel('Intensität')
        axis tight
    end
end


% --- Executes on button press in einstellungenbtn_krohne.
function einstellungenbtn_krohne_Callback(hObject, eventdata, handles)
% hObject    handle to einstellungenbtn_krohne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadfolder = cell2mat(handles.mess_folder);
mess_txt = dir(fullfile(loadfolder,'*.txt'));
filename = fullfile(loadfolder,mess_txt(1).name);

delimiter = {'\t','#'};
endRow = 18;

formatSpec = '%*s%s%*s%*s%[^\n\r]';

fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
Einstellungen = dataArray{1,1};
msgbox({Einstellungen},'Einstellungen')


% --- Executes on button press in plot_as_fig_btn_krohne.
function plot_as_fig_btn_krohne_Callback(hObject, eventdata, handles)
% hObject    handle to plot_as_fig_btn_krohne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mess_folder = cell2mat(handles.mess_folder);
mess_data = dir(fullfile(mess_folder,'*Auswertung*.mat'));
sel_path = fullfile(mess_folder,mess_data.name);
handles.sel_path = sel_path;
load(fullfile(mess_folder,mess_data.name));
figure

if strncmpi(handles.system_choice,'Krohne',6)==1
    
    if size(Stromstaerke,2) < 10
        for a = 1:size(Stromstaerke,2)
            plot(Masse,Stromstaerke(1:end,a),'DisplayName',datestr(mess_time(a),'HH:MM:SS'))
            xlabel('Masse [m/z]')
            ylabel('I[A]')
            hold on
        end
        guidata(hObject, handles)
        title({cell2mat(einstellungen(1)),cell2mat(einstellungen(end))},'Interpreter', 'none')
        hold off
        legend show
    else
        meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
        datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
        xlabel('Zeit')
        ylabel('Masse')
        zlabel('Intensität')
        axis tight
    end
    
else
    meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
    datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
    xlabel('Zeit')
    ylabel('Masse')
    zlabel('Intensität')
    axis tight
end


% --- Executes on button press in checkbox_krohne_10_mess.
function checkbox_krohne_10_mess_Callback(hObject, eventdata, handles)

mess_folder = cell2mat(handles.mess_folder);
mess_data = dir(fullfile(mess_folder,'*Auswertung*.mat'));
sel_path = fullfile(mess_folder,mess_data.name);
handles.sel_path = sel_path;
load(fullfile(mess_folder,mess_data.name));

N=1330;
M=650;
checkbox_val = get(handles.checkbox_krohne_10_mess,'Value');
if checkbox_val==1
    for a = 1:10
        plot(Masse,Stromstaerke(1:end,a),'DisplayName',datestr(mess_time(a),'HH:MM:SS'))
        xlabel('Masse [m/z]')
        ylabel('I[A]')
        hold on
        % Checkboxes einfügen
        handles.check(a)=uicontrol('style','checkbox','string', ...
            datestr(mess_time(a),'HH:MM:SS'),'tag',mess_time(a), ...
            'Value',1,'Visible','on', ...
            'position',[N-150 M/2-a*20 100 25],'userdata',a, ...
            'callback',{@CheckboxKrohneSys,a,handles});
        
    end
    guidata(hObject, handles)
    title({cell2mat(einstellungen(1)),cell2mat(einstellungen(end))},'Interpreter', 'none')
    hold off
    legend show
else
    axes(handles.axes1);
    try
        set(handles.check,'Visible','off')
        clear handles.check
    end
    axes(handles.axes1);
    set(handles.checkbox_krohne_10_mess,'Visible','on')
    meshz(Ergebnisse(1,2:end),Ergebnisse(2:end,1),Ergebnisse(2:end,2:end))
    datetick('x','dd-mmm-yyyy HH:MM:SS','keepticks')
    xlabel('Zeit')
    ylabel('Masse')
    zlabel('Intensität')
    axis tight
end


% --- Executes on selection change in system_popup.
function system_popup_Callback(hObject, eventdata, handles)

fid = fopen('folder.txt');
mess_folder = fgetl(fid);
fclose(fid);
system_choice = get(handles.system_popup,'String');
system_choice_val = get(handles.system_popup,'Value');
system_choice = cell2mat(system_choice(system_choice_val));

% Chiptypen und Charge aus Orndernamen auslesen
mess_folder_chiptypen = fullfile(mess_folder,system_choice);
chiptypen = dir(mess_folder_chiptypen);
chiptypen = chiptypen(~ismember({chiptypen.name},{'.' '..'}));%unnötige Zeilen entfernen
for a = 1:size(chiptypen,1)
    charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
    charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
    charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
    zahler_charge(a) = size(charge_temp,1);
end
charge = cell(size(chiptypen,1),max(zahler_charge));
charge_mit_typen = charge;

for a = 1:size(chiptypen,1)
    charge_temp = dir(fullfile(mess_folder_chiptypen,chiptypen(a).name));
    charge_temp = charge_temp(~ismember({charge_temp.name},{'.' '..'}));%unnötige Zeilen entfernen
    charge_temp = charge_temp(~ismember({charge_temp.name},{'Chiptest'}));
    for b = 1:size(charge_temp,1)
        charge(a,b) = {charge_temp(b).name};
        charge_mit_typen(a,b) = strcat(chiptypen(a).name,'/',{charge_temp(b).name});
    end
end

%Daten passend für Chippopup machen
chippopup_input = reshape(charge_mit_typen, size(charge_mit_typen,1)*size(charge_mit_typen,2), 1);
chippopup_input = sort(chippopup_input(~cellfun('isempty',chippopup_input)));
set(handles.chippopup,'String',chippopup_input);

%% Daten für handles speichern
handles.mess_folder = mess_folder;
handles.mess_folder_chiptypen = mess_folder_chiptypen;
handles.system_choice = system_choice;
guidata(hObject, handles)

% Chipopup aufrufen
chippopup_Callback(handles.chippopup,eventdata,handles);



% --- Executes during object creation, after setting all properties.
function system_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to system_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function mess_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mess_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_data_ws.
function load_data_ws_Callback(hObject, eventdata, handles)
tableinput = handles.tableinput;
row = handles.row;
col = handles.col;
ordner = cell(1);

%Jeweiligen Chip zu der Messung suchen (überprüfen ob cell leer ist)
if isempty(tableinput{row,1})==0
    ordner(1) = tableinput(row,1);
else
    while isempty(tableinput{row,1}) == 1
        row = row-1;
        ordner(1) = tableinput(row,1);
    end
end
clear row
row = handles.row;
auswertungordnertemp = fullfile(handles.unterordnertemp,ordner);
mess_folder = fullfile(auswertungordnertemp,tableinput(row,col));
handles.mess_folder = mess_folder;
matfile = dir(fullfile(cell2mat(mess_folder),'*Auswertung*.mat'));

if size(matfile,1)==0
    errordlg('Keine Auswertungsdatei gefunden')
else
    mess_daten = load(fullfile(cell2mat(mess_folder),matfile.name));
    assignin('base','mess_daten',mess_daten)
end

