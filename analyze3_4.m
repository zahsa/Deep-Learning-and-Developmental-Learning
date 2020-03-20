%----- Zahra Sadeghi--------------------------
%----- University of Tehran-------------------
%----- zahra.sadeghi@ut.ac.ir-----------------

%--do t-test and measure the difference between correlations at each level
%of hierarchy

clear all
load('Kat52conceptsvisform');
load('prefOrdTerms','prefOrdTerms');
for i=1:52
    fi(i)=find(strcmp(prefOrdTerms(i),lblKatvisdsShr)==1);
end



visCosDistK=pdist(KatvisdsShr,'cosine');
sqCosVisDistK=squareform(visCosDistK);




ss=10;%sample size
n=ss;
wamoo=[];was=[];bamoo=[];bas=[];wnamoo=[];wnas=[];
pv_withAn=[];pv_betAn=[];pv_withNonAn=[];

[~,~,~,withAn,betAn,withNonAn]=bootstrpCorPval(sqCosVisDistK,fi,ss);

[H0_h1,H0_p1]=ttest(withAn,betAn)
[H0_h2,H0_p2]=ttest(withNonAn,betAn)
[H0_h3,H0_p3]=ttest(withNonAn,withAn)

wamoo=[wamoo;mean(withAn)];was=[was;std(withAn)];
bamoo=[bamoo;mean(betAn)];bas=[bas;std(betAn)];
wnamoo=[wnamoo;mean(withNonAn)];wnas=[wnas;std(withNonAn)];

%--deep data
load('Mcvisdeep3LvisForm');
L1cosD = pdist(tr_patterns1,'cosine');
L1sqCosD=squareform(L1cosD);
[~,~,~,withAn,betAn,withNonAn]=bootstrpCorPval(L1sqCosD,fi,ss);

[H1_h1,H1_p1]=ttest(withAn,betAn)
[H1_h2,H1_p2]=ttest(withNonAn,betAn)
[H1_h3,H1_p3]=ttest(withNonAn,withAn)

wamoo=[wamoo;mean(withAn)];was=[was;std(withAn)];
bamoo=[bamoo;mean(betAn)];bas=[bas;std(betAn)];
wnamoo=[wnamoo;mean(withNonAn)];wnas=[wnas;std(withNonAn)];


L2cosD = pdist(tr_patterns2,'cosine');
L2sqCosD=squareform(L2cosD);
[~,~,~,withAn,betAn,withNonAn]=bootstrpCorPval(L2sqCosD,fi,ss);

[H2_h1,H2_p1]=ttest(withAn,betAn)
[H2_h2,H2_p2]=ttest(withNonAn,betAn)
[H2_h3,H2_p3]=ttest(withNonAn,withAn)

wamoo=[wamoo;mean(withAn)];was=[was;std(withAn)];
bamoo=[bamoo;mean(betAn)];bas=[bas;std(betAn)];
wnamoo=[wnamoo;mean(withNonAn)];wnas=[wnas;std(withNonAn)];

L3cosD = pdist(tr_patterns3,'cosine');
L3sqCosD=squareform(L3cosD);
[~,~,~,withAn,betAn,withNonAn]=bootstrpCorPval(L3sqCosD,fi,ss);

[H3_h1,H3_p1]=ttest(withAn,betAn)
[H3_h2,H3_p2]=ttest(withNonAn,betAn)
[H3_h3,H3_p3]=ttest(withNonAn,withAn)

wamoo=[wamoo;mean(withAn)];was=[was;std(withAn)];
bamoo=[bamoo;mean(betAn)];bas=[bas;std(betAn)];
wnamoo=[wnamoo;mean(withNonAn)];wnas=[wnas;std(withNonAn)];


figure;errorbar(wamoo,was,'-r+');hold on
errorbar(bamoo,bas,'-bs');hold on
errorbar(wnamoo,wnas,'-go');
XTickLabel={'','basic','','L1','','L2','','L3'};
b=get(gca,'XTick');
set(gca,'XTickLabel',XTickLabel,'XTick',b)
legend('within animal','between animal and non animal','within non-animal');
ylabel('average correlation')




