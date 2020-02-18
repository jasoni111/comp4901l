function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%% Fill in the code
% params{i-1}.w = 2*scale*rand(layers{i}.k*layers{i}.k*c/layers{i}.group, layers{i}.num) - scale;
% params{i-1}.b = zeros(1, layers{i}.num);
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape.
% h_in
% w_in
% c
% h_out
% w_out
% num

for n = 1:size(input.data,2)
    %w*h
    input_n.data = input.data(:, n);    
    
    %k*k*c*h_out*w_out
    col = im2col_conv(input_n, layer, h_out, w_out);
    kernel_size=k*k*c;
    %k*k*c X h_out*w_out
    %for each pixel in output im, there 
    %is a k*k*c mask/kernal col for it
    col = reshape(col, kernel_size, h_out*w_out);
%     size(col')
%     size(weight)
    %[h*w X k*k*c] * [k*k*c X output channel] =[h*w X output channel]
    out=col'*param.w+param.b;
    output.data(:, n)=out(:);
end
% output.data should size h'*w'*c' X batch size

output.channel = num;
output.batch_size = size(input.data,2);
output.height = h_out;
output.width = w_out;

assert(size(output.data,1)==num*h_out*w_out);
assert( size(output.data,2)==size(input.data,2) );

end

