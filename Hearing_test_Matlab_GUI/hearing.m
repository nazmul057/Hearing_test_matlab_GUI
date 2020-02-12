function varargout = hearing(varargin)
% HEARING MATLAB code for hearing.fig
%      HEARING, by itself, creates a new HEARING or raises the existing
%      singleton*.
%
%      H = HEARING returns the handle to a new HEARING or the handle to
%      the existing singleton*.
%
%      HEARING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEARING.M with the given input arguments.
%
%      HEARING('Property','Value',...) creates a new HEARING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hearing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hearing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hearing

% Last Modified by GUIDE v2.5 12-Feb-2020 10:11:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hearing_OpeningFcn, ...
                   'gui_OutputFcn',  @hearing_OutputFcn, ...
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


% --- Executes just before hearing is made visible.
function hearing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hearing (see VARARGIN)

% Choose default command line output for hearing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hearing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hearing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in take_value.
function take_value_Callback(hObject, eventdata, handles)
% hObject    handle to take_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%h_val_matrix = [];
h_val = getappdata(0,'db');
f_val = getappdata(0,'freq');
setappdata(0, 'thres', h_val)
setappdata(0,'load_f',f_val)
%h_val_matrix = [h_val_matrix, h_val];

%disp(h_val_matrix)

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startTest.
function startTest_Callback(hObject, eventdata, handles)

frequencies = [250 500 1000];


thres_matrix = [];
loaded_freqs = [];
set(handles.edit1, 'string' , 'continue test')


for freq = frequencies
    for db = 90:-1:-30
        amp = 0.001*(10^(db/20));
        %amp = 5;
        fs = 20500;
        duration = 0.8;
        %freq = 100;
        values = 0:1/fs:duration;
        a = amp*sin(2*pi*freq*values);
        out_r = [zeros(size(a)); a];
        sound(out_r)
        pause(0.1)
        setappdata(0,'db',db)
        setappdata(0,'freq',freq)
    end
    pause(1)
    %w = waitforbuttonpress;
    uiwait(msgbox('In this test, if you have not clicked take value then click "take value" and click ok. If you have clicked that, then just click ok'));
    %pause
    thres_val = getappdata(0,'thres');
    thres_matrix = [thres_matrix thres_val];
    now_load_f = getappdata(0,'load_f');
    loaded_freqs = [loaded_freqs now_load_f];
end

disp(thres_matrix)
plot(loaded_freqs, thres_matrix)
set(gca, 'Ydir', 'reverse')

uiwait(msgbox('To continue for left ear test click ok'));

frequencies = [250 500 1000];


thres_matrix = [];
loaded_freqs = [];
set(handles.edit1, 'string' , 'continue test')


for freq = frequencies
    for db = 90:-1:-30
        amp = 0.001*(10^(db/20));
        %amp = 5;
        fs = 20500;
        duration = 0.8;
        %freq = 100;
        values = 0:1/fs:duration;
        a = amp*sin(2*pi*freq*values);
        out_l = [a, zeros(size(a))];
        sound(out_l)
        pause(0.1)
        setappdata(0,'db',db)
        setappdata(0,'freq',freq)
    end
    pause(1)
    %w = waitforbuttonpress;
    uiwait(msgbox('In this test, if you have not clicked take value then click "take value" and click ok. If you have clicked that, then just click ok'));
    %pause
    thres_val = getappdata(0,'thres');
    thres_matrix = [thres_matrix thres_val];
    now_load_f = getappdata(0,'load_f');
    loaded_freqs = [loaded_freqs now_load_f];
end

disp(thres_matrix)
plot(loaded_freqs, thres_matrix)
set(gca, 'Ydir', 'reverse')

% hObject    handle to startTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseTest.
function pauseTest_Callback(hObject, eventdata, handles)
% hObject    handle to pauseTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
