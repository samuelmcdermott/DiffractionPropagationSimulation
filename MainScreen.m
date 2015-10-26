function varargout = MainScreen(varargin)
% MAINSCREEN MATLAB code for MainScreen.fig
%      MAINSCREEN, by itself, creates a new MAINSCREEN or raises the existing
%      singleton*.
%
%      H = MAINSCREEN returns the handle to a new MAINSCREEN or the handle to
%      the existing singleton*.
%
%      MAINSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINSCREEN.M with the given input arguments.
%
%      MAINSCREEN('Property','Value',...) creates a new MAINSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainScreen

% Last Modified by GUIDE v2.5 09-Oct-2015 16:02:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainScreen_OpeningFcn, ...
    'gui_OutputFcn',  @MainScreen_OutputFcn, ...
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


% --- Executes just before MainScreen is made visible.
function MainScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainScreen (see VARARGIN)

% Choose default command line output for MainScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainScreen_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_distance_Callback(hObject, eventdata, handles)
% hObject    handle to slider_distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_distance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_distance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_distance as text
%        str2double(get(hObject,'String')) returns contents of edit_distance as a double


% --- Executes during object creation, after setting all properties.
function edit_distance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_open_image.
function btn_open_image_Callback(hObject, eventdata, handles)
% hObject    handle to btn_open_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[object_image_filename, object_image_pathname] = uigetfile({'*.jpg;*.bmp;*.png','All Image Files'},'Open object image');

object_image = imread([object_image_pathname object_image_filename]);

imshow(object_image,'parent',handles.object_axes);
object_image = double(object_image);
assignin('base','base_object_image',object_image);
set(handles.btn_run,'Enable','on')

% --- Executes on button press in btn_save_diffraction.
function btn_save_diffraction_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save_diffraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[diffraction_filename,diffraction_pathname] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'Save Image');
diffraction_image = getframe(handles.diffraction_axes);
imwrite(diffraction_image.cdata,[diffraction_pathname diffraction_filename]);
% --- Executes on button press in btn_run.
function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get the object image from the base workspace
object_image = evalin('base', 'base_object_image');

%find which radio button (propagation type) has been selected
switch get(get(handles.btn_group_diffraction_type,'SelectedObject'),'Tag')
    
    case 'radio_fourier'
        %run fourier transform
        diffraction_image = fourierTransform(object_image);
        
    case 'radio_fresnel_transfer'
        %get parameters and run fresnel transfer function
        wavelength = str2double(get(handles.edit_wavelength,'string'));
        propagation_distance = str2double(get(handles.edit_distance,'string'));
        plane_side_length = str2double(get(handles.edit_plane_length,'string'));
        diffraction_image = fresnelTransfer(object_image, plane_side_length,wavelength,propagation_distance);
        
    case 'radio_fresnel_ir'
        %get paramters and run fresnel impulse response
        wavelength = str2double(get(handles.edit_wavelength,'string'));
        propagation_distance = str2double(get(handles.edit_distance,'string'));
        plane_side_length = str2double(get(handles.edit_plane_length,'string'));
        diffraction_image = fresnelImpulseResponse(object_image, plane_side_length,wavelength,propagation_distance);
        
    case 'radio_fraunhofer'
        %get parameters and run fraunhofer diffraction
        wavelength = str2double(get(handles.edit_wavelength,'string'));
        propagation_distance = str2double(get(handles.edit_distance,'string'));
        plane_side_length = str2double(get(handles.edit_plane_length,'string'));
        diffraction_image = fraunhofer(object_image, plane_side_length,wavelength,propagation_distance);
        
    case 'radio_angular_spectrum'
        %get parameters and run angular spectrum diffraction
        wavelength = str2double(get(handles.edit_wavelength,'string'));
        propagation_distance = str2double(get(handles.edit_distance,'string'));
        plane_side_length = str2double(get(handles.edit_plane_length,'string'));
        diffraction_image = angularSpectrum(object_image, plane_side_length,wavelength,propagation_distance);
end
%choose a nice looking colourmap
%colormap(handles.diffraction_axes,cbrewer('div','Spectral',64));
%display image in diffraction image axes
imagesc(diffraction_image,'parent',handles.diffraction_axes);
%turn off tick marks
set(handles.diffraction_axes,'xtick',[],'ytick',[])




% --- Executes when selected object is changed in btn_group_diffraction_type.
function btn_group_diffraction_type_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btn_group_diffraction_type
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%depending on whether the technique needs the parameters, make them
%visible/invisible
switch get(get(handles.btn_group_diffraction_type,'SelectedObject'),'Tag')
    case 'radio_fourier'
        set(handles.uipanel_parameters,'Visible','off');
    case 'radio_fresnel_transfer'
        set(handles.uipanel_parameters,'Visible','on');
    case 'radio_fresnel_ir'
        set(handles.uipanel_parameters,'Visible','on');
    case 'radio_fraunhofer'
        set(handles.uipanel_parameters,'Visible','on');
    case 'radio_angular_spectrum'
        set(handles.uipanel_parameters,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function edit_wavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_length as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_length as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
