function [diffraction_image] = angularSpectrum(object_image, obj_plane_side_length,wavelength,propagation_distance)
%%performs angular spectrum propagation of 2D image and returns irradiance
%%image
%Inputs:
%   object_image: the image of the object to be diffracted
%   plane_side_length: the length of the object plane (assumed square)
%   wavelength: the wavelength of the simluated monochromatic light
%   propagation distance: the distance between the object plane and the
%   observation plane
%
%Outputs:
%   diffraction_image: the irradiance image of the diffraction pattern

%pixel size of object image
[M,~] = size(object_image);
%sample size of object image
dx1 = obj_plane_side_length/M;
%set up coordinate space of observation plane
x2 = fftshift(-M/2:M/2 - 1);
x2 = x2./(dx1*M);
[x2,y2] = meshgrid(x2,x2);
%calculate mu
mu = sqrt(1/wavelength^2 - x2.^2 - y2.^2);
% shift, fft of object image
F = (fft2(object_image));
% multiply by phase-shift and inverse transform
diffraction_image = (ifft2(F.*exp(2i*pi*propagation_distance*mu)));
%calculate irradiance image
diffraction_image = abs(diffraction_image).^2;
end

