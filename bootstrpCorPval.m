function [withAn_base,betAn_base,withNonAn_base,withAn,betAn,withNonAn]=bootstrpCorPval(sqCosD,fi,ss)
% selecting different random samples with replacement from cor matrix
tmp=sqCosD(fi,:);
similarMatOrd=tmp(:,fi);
baseCor=corr(similarMatOrd);
fs=21;
withAn_base=sum(sum(baseCor(1:fs,1:fs)))/(2*fs*fs);
betAn_base=sum(sum(baseCor(1:fs,fs+1:end)))/((52-fs+1)*fs);
withNonAn_base=sum(sum(baseCor(fs+1:end,fs+1:end)))/(2*(52-fs+1)*(52-fs+1));
    
for b=1:ss
    smplInd=sort(ceil(52*rand(1,52)));
    tmp=similarMatOrd(smplInd,:);
    bootsmp=tmp(:,smplInd);
    
    cboot=corr(bootsmp);
    fs=find(smplInd<=21,1,'last');
    withAn(b)=sum(sum(cboot(1:fs,1:fs)))/(2*fs*fs);
    betAn(b)=sum(sum(cboot(1:fs,fs+1:end)))/((52-fs+1)*fs);
%     betAn(b)=sum(sum(cboot(fs+1:end,1:fs)))/((52-fs+1)*fs);
    withNonAn(b)=sum(sum(cboot(fs+1:end,fs+1:end)))/(2*(52-fs+1)*(52-fs+1));
end

% figure(1);errorbar(mean(withAn),std(withAn),'r')
% hold on;errorbar(mean(betAn),std(betAn),'g')
% hold on;errorbar(mean(withNonAn),std(withNonAn),'b')

