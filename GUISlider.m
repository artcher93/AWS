
function GUISlider

%Figure erstelen und Komponenten dazu
fig = figure('Name','Einzelmessung der Langzeitmessung','Position',[300,150,1000,768],'Visible','on');
ax = axes('Units','pixels','Position',[150,200,700,500]);
txt = uicontrol('Style','text',...
    'Position',[470 100 120 20],'String',num2str(1));
txt2 = uicontrol('Style','text','Position',[450 100 65 20],'String','Messung = ');

%Slider Parameter
Ergebnisse = evalin('base','Ergebnisse');
slidermin = 2;
slidermax = size(Ergebnisse,2);
sliderstep = [1/(slidermax-slidermin)];

sld = uicontrol('Style', 'slider',...
    'SliderStep', [sliderstep sliderstep],...
    'Min',slidermin,'Max',slidermax,'Value',2,...
    'Position', [200 80 600 20],...
    'Callback', @sliderfunktion);

plot(Ergebnisse(2:end,1),Ergebnisse(2:end,2))
xlabel('Masse')
ylabel('Intensität')
title('Einzelmessungen der Langzeitmessung')

    function sliderfunktion(source,event)
        sldval = round(get(sld,'Value'));
        masse = Ergebnisse(2:end,1);
        inten = Ergebnisse(2:end,sldval);
        set(txt,'String',num2str(sldval-1))
        plot(masse,inten)
        xlabel('Masse')
        ylabel('Intensität')
        title('Einzelmessungen der Langzeitmessung')
        
        
    end
end