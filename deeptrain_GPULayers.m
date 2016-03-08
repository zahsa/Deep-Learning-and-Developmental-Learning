function deeptrain_GPULayers(layerunits)
% example: layerunits = [100,200,300];

% Version 1.000
%
% Code provided by Ruslan Salakhutdinov and Geoff Hinton
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.

% Version 1.100
%
% Updated by Computational Cognitive Neuroscience Lab
% University of Padova
% ccnl.psy.unipd.it
%
% Implementation on graphic processors (GPUs) using MATLAB Parallel Computing Toolbox

% clear all; 
% close all; clc

% DEEP NETWORK SETUP
% (parameters and final network weights will be saved in structure DN)

netName='neurons';
DN.layersize   = layerunits;
DN.nlayers     = length(DN.layersize);
DN.maxepochs   = 100;
DN.batchsize   = 89;
epsilonw_GPU   = gpuArray(0.1);
epsilonvb_GPU  = gpuArray(0.1);
epsilonhb_GPU  = gpuArray(0.1);
weightcost_GPU = gpuArray(0.0002);
DN.err = zeros(DN.maxepochs, DN.nlayers, 'single');



load('McVisBatch');
% load('McVisBatch_merged');

for layer = 1:DN.nlayers
    
    % for the first layer, input data are raw images
    % for next layers, input data are preceding hidden activations
    fprintf(1,'Training layer %d...\n', layer);
    if layer == 1
        data_GPU = gpuArray(single(batchdata));
    else
        data_GPU  = batchposhidprobs;
    end
    
    % initialize weights and biases
    numhid  = DN.layersize(layer);
    [numcases numdims numbatches] = size(data_GPU);
    numcases_GPU     = gpuArray(numcases);
    vishid_GPU       = gpuArray(.1*randn(numdims, numhid, 'single'));
    hidbiases_GPU    = gpuArray(zeros(1,numhid, 'single'));
    visbiases_GPU    = gpuArray(zeros(1,numdims, 'single'));
    vishidinc_GPU    = gpuArray(zeros(numdims, numhid, 'single'));
    hidbiasinc_GPU   = gpuArray(zeros(1,numhid, 'single'));
    visbiasinc_GPU   = gpuArray(zeros(1,numdims, 'single'));
    batchposhidprobs = gpuArray(zeros(DN.batchsize, numhid, numbatches, 'single'));
    
    for epoch = 1:DN.maxepochs

        errsum = 0;
        for mb = 1:numbatches
            data_mb = data_GPU(:, :, mb);
            % learn an RBM with 1-step contrastive divergence
            rbm_GPU;
            errsum = errsum + err;
            if epoch == DN.maxepochs
                batchposhidprobs(:, :, mb) = poshidprobs_GPU;
            end
        end
        DN.err(epoch, layer) = errsum;
      
%         %deltaRule
%         sprintf('vishidinc')
%         max(max(vishidinc_GPU))
%         
%         sprintf('vishid')
%         max(max(vishid_GPU))
    end
    % save learned weights
    DN.L{layer}.hidbiases  = gather(hidbiases_GPU);
    DN.L{layer}.vishid     = gather(vishid_GPU);
    DN.L{layer}.visbiases  = gather(visbiases_GPU);
    
%     n1=10;n2=10;    
%     figure;
%     colormap gray
%     for k1 = 1:n1
%         for k2 = 1:n2
%             loc=(k1-1)*n2 + k2;
%             subplot(n1,n2,loc);
%             rl=1+fix(DN.layersize*rand(1,1));
%             imagesc(reshape(DN.L{1,1}.vishid(:,loc),32,32))
%             axis off
%         end
%     end
% %     suptitle('mm=.9');
%     figure;
%     plot(DN.err);
end


saveName=sprintf('DNMc%s_maxEp%d',netName,epoch);
saveName='weights';
% saveName='weights_merged';
% save(saveName,'DN');