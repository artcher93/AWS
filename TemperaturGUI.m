function varargout = TemperaturGUI(varargin)
% TEMPERATURGUI MATLAB code for TemperaturGUI.fig
%      TEMPERATURGUI, by itself, creates a new TEMPERATURGUI or raises the existing
%      singleton*.
%
%      H = TEMPERATURGUI returns the handle to a new TEMPERATURGUI or the handle to
%      the existing singleton*.
%
%      TEMPERATURGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPERATURGUI.M with the given input arguments.
%
%      TEMPERATURGUI('Property','Value',...) creates a new TEMPERATURGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TemperaturGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TemperaturGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TemperaturGUI

% Last Modified by GUIDE v2.5 02-Oct-2019 19:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TemperaturGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TemperaturGUI_OutputFcn, ...
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


% --- Executes just before TemperaturGUI is made visible.
function TemperaturGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TemperaturGUI (see VARARGIN)
% Choose default command line output for TemperaturGUI
handles.output = hObject;
%Werte aus AuswertungGUI übernehmen
handles.loadfolder = varargin{1}.loadfolder;
handles.tempfile = varargin{1}.tempfile;

loadfolder = handles.loadfolder;
% tempfile = tempfile;

arduino = 'arduino1';
handles.arduino = arduino;
% Update handles structure
guidata(hObject, handles);

%% Arduino 1 anzeigen beim öffnen
set(handles.titletxt,'String','Arduino 1 am System')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard1zeitdatetime,ard1tempdrucksensor(1:end,1),ard1zeitdatetime,ard1templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard1zeitdatetime,ard1luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard1zeitdatetime,ard1lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard1zeitdatetime,ard1luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)
ylabel(handles.druckax,'Druck [hPa]')
% UIWAIT makes TemperaturGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = TemperaturGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in allplotbtn.
function allplotbtn_Callback(hObject, eventdata, handles)
% hObject    handle to allplotbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Laden der Daten
load(fullfile(handles.loadfolder,handles.tempfile.name))

% Überprüfen welcher adruino ausgewählt wurde und alle ergebnisse einzeln
% ploten
if strcmp(handles.arduino,'arduino1')==1
    f1 = figure;
    plot(ard1zeitdatetime,ard1tempdrucksensor(1:end,1),ard1zeitdatetime,ard1templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    f2 = figure;
    plot(ard1zeitdatetime,ard1luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
    f3 = figure;
    plot(ard1zeitdatetime,ard1lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
    f4 = figure;
    plot(ard1zeitdatetime,ard1luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino2')==1
    f1 = figure;
    plot(ard2zeitdatetime,ard2tempdrucksensor(1:end,1),ard2zeitdatetime,ard2templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    f2 = figure;
    plot(ard2zeitdatetime,ard2luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
    f3 = figure;
    plot(ard2zeitdatetime,ard2lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
    f4 = figure;
    plot(ard2zeitdatetime,ard2luftdruck,'Parent',f4)
    title('Druck über die Zeit')
elseif strcmp(handles.arduino,'arduino3')==1
    f1 = figure;
    plot(ard3zeitdatetime,ard3tempdrucksensor(1:end,1),ard3zeitdatetime,ard3templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    f2 = figure;
    plot(ard3zeitdatetime,ard3luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
    f3 = figure;
    plot(ard3zeitdatetime,ard3lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
    f4 = figure;
    plot(ard3zeitdatetime,ard3luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino4')==1
    strcmp(handles.arduino,'arduino4')==1
    f1 = figure;
    plot(ard4zeitdatetime,ard4tempdrucksensor(1:end,1),ard4zeitdatetime,ard4templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    f2 = figure;
    plot(ard4zeitdatetime,ard4luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
    f3 = figure;
    plot(ard4zeitdatetime,ard4lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
    f4 = figure;
    plot(ard4zeitdatetime,ard4luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino5')==1
    f1 = figure;
    plot(ard5zeitdatetime,ard5tempdrucksensor(1:end,1),ard5zeitdatetime,ard5templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    f2 = figure;
    plot(ard5zeitdatetime,ard5luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
    f3 = figure;
    plot(ard5zeitdatetime,ard5lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
    f4 = figure;
    plot(ard5zeitdatetime,ard5luftdruck,'Parent',f4)
    title('Druck über die Zeit')
end
    

% --- Executes on button press in tempplotbtn.
function tempplotbtn_Callback(hObject, eventdata, handles)
% hObject    handle to tempplotbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load(fullfile(handles.loadfolder,handles.tempfile.name))

% Überprüfen welcher adruino ausgewählt wurde und alle ergebnisse einzeln
% ploten
if strcmp(handles.arduino,'arduino1')==1
    f1 = figure;
    plot(ard1zeitdatetime,ard1tempdrucksensor(1:end,1),ard1zeitdatetime,ard1templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
elseif strcmp(handles.arduino,'arduino2')==1
    f1 = figure;
    plot(ard2zeitdatetime,ard2tempdrucksensor(1:end,1),ard2zeitdatetime,ard2templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
elseif strcmp(handles.arduino,'arduino3')==1
    f1 = figure;
    plot(ard3zeitdatetime,ard3tempdrucksensor(1:end,1),ard3zeitdatetime,ard3templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
    
elseif strcmp(handles.arduino,'arduino4')==1
    strcmp(handles.arduino,'arduino4')==1
    f1 = figure;
    plot(ard4zeitdatetime,ard4tempdrucksensor(1:end,1),ard4zeitdatetime,ard4templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
elseif strcmp(handles.arduino,'arduino5')==1
    f1 = figure;
    plot(ard5zeitdatetime,ard5tempdrucksensor(1:end,1),ard5zeitdatetime,ard5templuftsensor,'Parent',f1)
    title('Temperatur-Temperatursensor/Drucksensor')
    ylabel('Temperatur [C]')
    legend('Temperatursensor','Drucksensor')
    
end 
    
% --- Executes on button press in lichtplobtn.
function lichtplobtn_Callback(hObject, eventdata, handles)
% hObject    handle to lichtplobtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Laden der Daten
load(fullfile(handles.loadfolder,handles.tempfile.name))

% Überprüfen welcher adruino ausgewählt wurde und alle ergebnisse einzeln
% ploten
if strcmp(handles.arduino,'arduino1')==1
    f3 = figure;
    plot(ard1zeitdatetime,ard1lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
elseif strcmp(handles.arduino,'arduino2')==1
    f3 = figure;
    plot(ard2zeitdatetime,ard2lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
elseif strcmp(handles.arduino,'arduino3')==1
    f3 = figure;
    plot(ard3zeitdatetime,ard3lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
elseif strcmp(handles.arduino,'arduino4')==1  
    f3 = figure;
    plot(ard4zeitdatetime,ard4lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
elseif strcmp(handles.arduino,'arduino5')==1
        
    f3 = figure;
    plot(ard5zeitdatetime,ard5lichtinten,'Parent',f3)
    title('Lichtintensität über die Zeit')
    ylabel('Licht')
    
end

% --- Executes on button press in luftplotbtn.
function luftplotbtn_Callback(hObject, eventdata, handles)
% hObject    handle to luftplotbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Laden der Daten
load(fullfile(handles.loadfolder,handles.tempfile.name))

% Überprüfen welcher adruino ausgewählt wurde und alle ergebnisse einzeln
% ploten
if strcmp(handles.arduino,'arduino1')==1
    f2 = figure;
    plot(ard1zeitdatetime,ard1luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    

elseif strcmp(handles.arduino,'arduino2')==1
    f2 = figure;
    plot(ard2zeitdatetime,ard2luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
elseif strcmp(handles.arduino,'arduino3')==1   
    f2 = figure;
    plot(ard3zeitdatetime,ard3luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
elseif strcmp(handles.arduino,'arduino4')==1
    
    f2 = figure;
    plot(ard4zeitdatetime,ard4luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
    
elseif strcmp(handles.arduino,'arduino5')==1
    
    f2 = figure;
    plot(ard5zeitdatetime,ard5luftfeuchtigkeit,'Parent',f2)
    title('Luftfeuchtigkeit über die Zeit')
    ylabel('Luftfeuchtigkeit')
end

% --- Executes on button press in druckplotbtn.
function druckplotbtn_Callback(hObject, eventdata, handles)
% hObject    handle to druckplotbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Laden der Daten
load(fullfile(handles.loadfolder,handles.tempfile.name))

% Überprüfen welcher adruino ausgewählt wurde und alle ergebnisse einzeln
% ploten
if strcmp(handles.arduino,'arduino1')==1    
    f4 = figure;
    plot(ard1zeitdatetime,ard1luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino2')==1   
    f4 = figure;
    plot(ard2zeitdatetime,ard2luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino3')==1   
    f4 = figure;
    plot(ard3zeitdatetime,ard3luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino4')==1
    f4 = figure;
    plot(ard4zeitdatetime,ard4luftdruck,'Parent',f4)
    title('Druck über die Zeit')
    
elseif strcmp(handles.arduino,'arduino5')==1
    f4 = figure;
    plot(ard5zeitdatetime,ard5luftdruck,'Parent',f4)
    title('Druck über die Zeit')
end

% --- Executes on button press in systempressurebtn.
function systempressurebtn_Callback(hObject, eventdata, handles)
% hObject    handle to systempressurebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mydir = dir(fullfile(handles.loadfolder,'*.mat'));
load(fullfile(handles.loadfolder,mydir(1).name));

if exist('systempressure') ==0
    msgbox('Kein SystemPressure ausgewertet')
else
    zeit = datetime(datestr(Ergebnisse(1,2:end)));
    figsystempressure = figure;
    plot(zeit,systempressure,'Parent', figsystempressure)
    title('System Druck über die Zeit')
    ylabel('SystemPressure')
    xlabel('Zeit')
end

% --- Executes on button press in maximumplotbtn.
function maximumplotbtn_Callback(hObject, eventdata, handles)
% hObject    handle to maximumplotbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Laden der Matfile und Plot der Daten
mydir = dir(fullfile(handles.loadfolder,'*.mat'));
load(fullfile(handles.loadfolder,mydir(1).name));
% Plot
zeit = datetime(datestr(Ergebnisse(1,2:end)));
figmaximum = figure;
plot(zeit,maximum(2:end),'Parent',figmaximum)
axis manual
title('Maximum über die Zeit')
ylabel('Maximum')
xlabel('Zeit')
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ArduinoMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ArduinoMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Arduino1Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Arduino1Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arduino = 'arduino1';
handles.arduino = arduino;
guidata(hObject, handles);
%% Laden der Temp-Matfile und Plot der Daten
set(handles.titletxt,'String','Arduino 1 am System')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard1zeitdatetime,ard1tempdrucksensor(1:end,1),ard1zeitdatetime,ard1templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard1zeitdatetime,ard1luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard1zeitdatetime,ard1lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard1zeitdatetime,ard1luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)
ylabel(handles.druckax,'Druck [hPa]')
% --------------------------------------------------------------------
function Arduino2Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Arduino2Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arduino = 'arduino2';
handles.arduino = arduino;
guidata(hObject, handles);
%% Laden der Temp-Matfile und Plot der Daten
set(handles.titletxt,'String','Arduino 2 Fensterbank nahe System')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard2zeitdatetime,ard2tempdrucksensor(1:end,1),ard2zeitdatetime,ard2templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard2zeitdatetime,ard2luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard2zeitdatetime,ard2lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard2zeitdatetime,ard2luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)
ylabel(handles.druckax,'Druck [hPa]')
% --------------------------------------------------------------------
function Arduino3Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Arduino3Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arduino = 'arduino3';
handles.arduino = arduino;
guidata(hObject, handles);
%% Laden der Temp-Matfile und Plot der Daten
set(handles.titletxt,'String','Arduino 3 Unter dem Tisch')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard3zeitdatetime,ard3tempdrucksensor(1:end,1),ard3zeitdatetime,ard3templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard3zeitdatetime,ard3luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard3zeitdatetime,ard3lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard3zeitdatetime,ard3luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)

% --------------------------------------------------------------------
function Arduino4Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Arduino4Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arduino = 'arduino4';
handles.arduino = arduino;
guidata(hObject, handles);
%% Laden der Temp-Matfile und Plot der Daten
set(handles.titletxt,'String','Arduino 4 Fensterbank weiter weg')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard4zeitdatetime,ard4tempdrucksensor(1:end,1),ard4zeitdatetime,ard4templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard4zeitdatetime,ard4luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard4zeitdatetime,ard4lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard4zeitdatetime,ard4luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)
% --------------------------------------------------------------------
function Arduino5Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Arduino5Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arduino = 'arduino5';
handles.arduino = arduino;
guidata(hObject, handles);
%% Laden der Temp-Matfile und Plot der Daten
set(handles.titletxt,'String','Arduino 5 Regal')
load(fullfile(handles.loadfolder,handles.tempfile.name))

plot(ard5zeitdatetime,ard5tempdrucksensor(1:end,1),ard5zeitdatetime,ard5templuftsensor,'Parent',handles.tempax)
set(handles.tempax,'xticklabelrotation',45)
title(handles.tempax,'Temperatur-Temperatursensor/Drucksensor')
ylabel(handles.tempax,'Temperatur [C]')
legend(handles.tempax,'Temperatursensor','Drucksensor')

plot(ard5zeitdatetime,ard5luftfeuchtigkeit,'Parent',handles.luftax)
set(handles.luftax,'xticklabelrotation',45)
title(handles.luftax,'Luftfeuchtigkeit über die Zeit')
ylabel(handles.luftax,'Luftfeuchtigkeit')

plot(ard5zeitdatetime,ard5lichtinten,'Parent',handles.lichtax)
set(handles.lichtax,'xticklabelrotation',45)
title(handles.lichtax,'Lichtintensität über die Zeit')
ylabel(handles.lichtax,'Licht')

plot(ard5zeitdatetime,ard5luftdruck,'Parent',handles.druckax)
title(handles.druckax,'Druck über die Zeit')
set(handles.druckax,'xticklabelrotation',45)


% --- Executes on button press in zoom_checkbox.
function zoom_checkbox_Callback(hObject, eventdata, handles)
val_checkbox = get(handles.zoom_checkbox,'value');
if val_checkbox == 1
linkaxes([handles.druckax handles.lichtax handles.tempax handles.luftax],'x')
else 
linkaxes([handles.druckax handles.lichtax handles.tempax handles.luftax],'off')
end

