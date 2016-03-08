

load('Mcvisdeep3LvisForm');
% load('Mcvisdeep3LColorForm');
% load('Mcvisdeep3LvisMotionFormColor')
ct1=corrcoef(tr_patterns1');
ct2=corrcoef(tr_patterns2');
ct3=corrcoef(tr_patterns3');


%---analyze 1-----
%--raw data
% load('Kat52conceptsvisStat');
load('Kat52conceptsvisform');


load('prefOrdTerms','prefOrdTerms');
for i=1:52
    fi(i)=find(strcmp(prefOrdTerms(i),lblKatvisdsShr)==1);
end



visCosDistK=pdist(KatvisdsShr,'cosine');
sqCosVisDistK=squareform(visCosDistK);

csqCosVisDistK=corr(sqCosVisDistK);
B=csqCosVisDistK(fi,:);
B=B(:,fi);

figure;
% subplot(2,3,2)
imagesc(B)
lbls=lblKatvisdsShr(:,fi);
%remove underline in labels
lbls{47}='bin-waste';
lbls{36}='stool';
set(gca,'FontSize',5)
set(gca,'XTickLabel',lbls,'XTick',1:numel(lbls))
set(gca,'YTickLabel',lbls,'YTick',1:numel(lbls))

a=get(gca,'XTickLabel');
set(gca,'XTickLabel',[]);
b=get(gca,'XTick');
c=get(gca,'YTick');
rot=90;
th=text(b,repmat(52,length(c),1),a,'HorizontalAlignment','right','rotation',rot,'fontsize',4);
set(gca,'Fontsize',5);
% saveas( gcf, 'C:\Users\Zahra\Documents\ZDoc\simulations\McRae\fig1_1', 'emf' );



%--deep data
load('Mcvisdeep3LvisForm');
% load('Mcvisdeep3LColorForm');
% load('Mcvisdeep3LvisMotionFormColor')
L1cosD = pdist(tr_patterns1,'cosine');
L1sqCosD=squareform(L1cosD);
cL1sqCosD=corr(L1sqCosD);
cL1sqCosDp=cL1sqCosD(fi,:);
cL1sqCosDp=cL1sqCosDp(:,fi);

figure;subplot(1,3,1);imagesc(cL1sqCosDp);
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
text(-1.5,10,'land animals','Rotation',90,'FontSize',7)
text(-1.5,20,'birds','Rotation',90,'FontSize',7)
text(-1.5,27,'fruits','Rotation',90,'FontSize',7)
text(-1.5,35,'vehicle','Rotation',90,'FontSize',7)
text(-1.5,50,'artificial items','Rotation',90,'FontSize',7)



L2cosD = pdist(tr_patterns2,'cosine');
L2sqCosD=squareform(L2cosD);
cL2sqCosD=corr(L2sqCosD);
cL2sqCosDp=cL2sqCosD(fi,:);
cL2sqCosDp=cL2sqCosDp(:,fi);

subplot(1,3,2);imagesc(cL2sqCosDp);
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
text(-1.5,10,'land animals','Rotation',90,'FontSize',7)
text(-1.5,20,'birds','Rotation',90,'FontSize',7)
text(-1.5,27,'fruits','Rotation',90,'FontSize',7)
text(-1.5,35,'vehicle','Rotation',90,'FontSize',7)
text(-1.5,50,'artificial items','Rotation',90,'FontSize',7)



L3cosD = pdist(tr_patterns3,'cosine');
L3sqCosD=squareform(L3cosD);
cL1sqCosD=corr(L3sqCosD);
cL2sqCosDp=cL1sqCosD(fi,:);
cL2sqCosDp=cL2sqCosDp(:,fi);

subplot(1,3,3);imagesc(cL2sqCosDp);
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
t=text(-1.5,20,'Living things','Rotation',90,'FontSize',12)
t=text(-1.5,50,'non-Living things','Rotation',90,'FontSize',12)

hp4 = get(subplot(2,3,6),'Position')
colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)  0.025  hp4(4)])
saveas( gcf, 'C:\Users\Zahra\Documents\ZDoc\simulations\McRae\fig1_234', 'emf' );
