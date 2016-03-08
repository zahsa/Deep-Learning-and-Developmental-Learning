function deeptrain_CPULayers(layerunits)
% example: layerunits = [100,200,300];



% clear all; 
% close all; clc

% DEEP NETWORK SETUP
% (parameters and final network weights will be saved in structure DN)

netName='neurons';
DN.layersize   = layerunits;
DN.nlayers     = length(DN.layersize);
DN.maxepochs   = 100;
DN.batchsize   = 89;
epsilonw   = 0.1;
epsilonvb  = 0.1;
epsilonhb  = 0.1;
weightcost = 0.0002;
DN.err = zeros(DN.maxepochs, DN.nlayers, 'single');



load('McVisBatch');
% load('McVisBatch_merged');

for layer = 1:DN.nlayers
    
    % for the first layer, input data are raw images
    % for next layers, input data are preceding hidden activations
    fprintf(1,'Training layer %d...\n', layer);
    if layer == 1
        data = single(batchdata);
    else
        data  = batchposhidprobs;
    end
    
    % initialize weights and biases
    numhid  = DN.layersize(layer);
    [numcases numdims numbatches] = size(data);
    numcases     = numcases;
    vishid       = .1*randn(numdims, numhid, 'single');
    hidbiases    = zeros(1,numhid, 'single');
    visbiases    = zeros(1,numdims, 'single');
    vishidinc    = zeros(numdims, numhid, 'single');
    hidbiasinc   = zeros(1,numhid, 'single');
    visbiasinc   = zeros(1,numdims, 'single');
    batchposhidprobs = zeros(DN.batchsize, numhid, numbatches, 'single');
    
    for epoch = 1:DN.maxepochs

        errsum = 0;
        for mb = 1:numbatches
            data_mb = data(:, :, mb);
            % learn an RBM with 1-step contrastive divergence
            rbm_CPU;
            errsum = errsum + err;
            if epoch == DN.maxepochs
                batchposhidprobs(:, :, mb) = poshidprobs;
            end
        end
        DN.err(epoch, layer) = errsum;
      

    end
    % save learned weights
    DN.L{layer}.hidbiases  = gather(hidbiases);
    DN.L{layer}.vishid     = gather(vishid);
    DN.L{layer}.visbiases  = gather(visbiases);
    

end


% saveName=sprintf('DNMc%s_maxEp%d',netName,epoch);
saveName='weights';
% saveName='weights_merged';
save(saveName,'DN');