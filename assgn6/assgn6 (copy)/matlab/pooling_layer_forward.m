function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    
    input_n.height = h_in;
    input_n.width = w_in;
    input_n.channel = c;
    
    
for n = 1:batch_size
    %w*h
    input_n.data = input.data(:, n);    
    
    %k*k*c*h_out*w_out
    col = im2col_conv(input_n, layer, h_out, w_out);
    % k*k X c X h_out*w_out
    col = reshape(col, k*k, c , h_out*w_out);
    size(col);
    
    % c X h_out*w_out
    col = squeeze(max(col,[],1));
    % h_out*w_out X c
    col=col';
    output.data(:,n)=col(:);
end
    
%     sizeout=size(output.data)
%     output.data = zeros([h_out, w_out, c, batch_size]);

    
end

