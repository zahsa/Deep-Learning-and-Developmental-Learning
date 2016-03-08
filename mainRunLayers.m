function mainRunLayers(layerunits)
% clear all
nlayers=length(layerunits);
trn=1;
for rn=1:trn
    % color+form+motion
    %     load('McRaeVisFeatMatEdit');
    %     S=double(McRaeVisFeatMatEdit);
    
    % form
        load('McRaeVisFormFeatMat');
        S=double(McRaeVisFeatMat);
    
    %form+color
      
    
%     % nS=normalizeFeat(S);
%     % nS=zscore(S);
    nS=(S-min(min(S)))/max(max(S));
    save('stim','nS');
    batchMcL;
    
    deeptrain_CPULayers(layerunits);
%     load('weights','DN');
%     w1=[DN.L{1,1}.vishid;DN.L{1,1}.hidbiases];
%     
% %     load('Kat52conceptsvis');
%     %     load('Kat52conceptsvisform');
%     load('Kat52conceptsvisStat');
%     data = double(KatvisStatShr);
%     
%     %     data=(S-min(min(S)))/max(max(S));
%     N=size(data,1);
%     data = [data ones(N,1)];
%     
%     w1probs = 1./(1 + exp(-data*w1));
%     tr_patterns1=double(w1probs);
%     
%     save('Mcvisdeep','tr_patterns1');
%     if nlayers > 1
%         w2=[DN.L{1,2}.vishid;DN.L{1,2}.hidbiases];
%         w1probs = [w1probs  ones(N,1)];
%         w2probs = 1./(1 + exp(-w1probs*w2));
%         tr_patterns2=double(w2probs);
%         save('Mcvisdeep','tr_patterns2','-append')
%     end
%     if nlayers>2
%         w3=[DN.L{1,3}.vishid;DN.L{1,3}.hidbiases];
%         w2probs = [w2probs  ones(N,1)];
%         w3probs = 1./(1 + exp(-w2probs*w3));
%         tr_patterns3=double(w3probs);
%         save('Mcvisdeep','tr_patterns3','-append')
%         
%     end
%     if nlayers>3
%         w4=[DN.L{1,4}.vishid;DN.L{1,4}.hidbiases];
%         w3probs = [w3probs  ones(N,1)];
%         w4probs = 1./(1 + exp(-w3probs*w4));
%         tr_patterns4=double(w4probs);
%         save('Mcvisdeep','tr_patterns4','-append')
%         
%     end
%     if nlayers>4
%         w5=[DN.L{1,5}.vishid;DN.L{1,5}.hidbiases];
%         w4probs = [w4probs  ones(N,1)];
%         w5probs = 1./(1 + exp(-w4probs*w5));
%         tr_patterns5=double(w5probs);
%         save('Mcvisdeep','tr_patterns5','-append')
%         
%     end
%     
%     %     load('Mc122concepts');
%     %     data = double(McvisdsShr);
    
end
