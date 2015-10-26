function [diffraction_image, x2] = fraunhofer(object_image, obj_plane_side_length,wavelength,propagation_distance)
%%performs fraunhofer propagation of 2D image and returns irradiance
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

%pixel size of the object image
[M,~] = size(object_image);
%get the sample size of object image
dx1 = obj_plane_side_length/M;
%wavenumber
k = 2*pi/wavelength;
%the observation plane side length
obs_plane_side_length = wavelength*propagation_distance/dx1;
%the sample size of the observation plane
dx2 = wavelength*propagation_distance/obj_plane_side_length;
%the coordinates of the observation plane
x2 = -obs_plane_side_length/2:dx2:obs_plane_side_length/2-dx2;
[X2,Y2] = meshgrid(x2,x2);
%transfer function
c = 1/(1i*wavelength*propagation_distance)*exp(1i*k/(2*propagation_distance)*(X2.^2+Y2.^2));
%convolution in fourier space
diffraction_image = c.*ifftshift(fft2(fftshift(object_image)))*dx1^2;
%irradiance image
diffraction_image = abs(diffraction_image).^2;
%to bring out more detail, cube root
diffraction_image = nthroot(diffraction_image,3);

end

