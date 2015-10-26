function [diffraction_image] = fourierTransform(object_image)
%%Performs 2D fourier transform diffraction of an image and returns
%%irradiance image
%Inputs:
%   object_image: the image of the object to be diffracted
%
%Outputs:
%   diffraction_image: the irradiance image of the diffraction pattern

%2D fourier transform object signal
farfieldsignal = fft2(object_image);
%magnitude of signal
farfieldintensity = abs(farfieldsignal).^2;
%shift fft to centre
diffraction_image = fftshift(farfieldintensity);
end

