%----- Zahra Sadeghi--------------------------
%----- University of Tehran-------------------
%----- zahra.sadeghi@ut.ac.ir-----------------

clear all
load('McRaeVisFeat','McRaeVisFeat');
load('conceptNm','conceptNm');
load('featType','featType');
load('prodFreq','prodFreq');
load('FeatureNm','FeatureNm');

McRaeVisFeat_fill=McRaeVisFeat;


McRaeVisFeatMat=zeros(size(McRaeVisFeat_fill,1)-1,size(McRaeVisFeat_fill,2)-1);
for i=1:size(McRaeVisFeat_fill,1)-1
    conc=McRaeVisFeat_fill{i+1};
    c=find(strcmp(conceptNm,conc)==1);
    ft=FeatureNm(c);
    for j=1:length(McRaeVisFeat_fill)-1
        feat=McRaeVisFeat_fill{1,j+1};
        ift=find(strcmp(ft,feat)==1);
        if isempty(ift)
            McRaeVisFeat_fill{i+1,j+1}=0;
            McRaeVisFeatMat(i,j)=0;
        else           
            McRaeVisFeat_fill{i+1,j+1}=prodFreq(c(ift));
            McRaeVisFeatMat(i,j)=prodFreq(c(ift));
        end
    end
end


% save('McRaeVisFeatMat','McRaeVisFeatMat')
% save('McRaeVisFeat_fill','McRaeVisFeat_fill');

%save into excel
xfile='.\McRaePerceptProdFreq.xlsx';
xlswrite(xfile,McRaeVisFeatMat ,'sheet1', 'B2');


% for i=1:size(McRaeVisFeat_fill,1)
%     if ~isempty(McRaeVisFeat_fill{i,1})
%         xlswrite(xfile, McRaeVisFeat_fill{i,1},'sheet1', sprintf('A%s',int2str(i)));
%     end
% end
% then a transpose would be needed
% for j=1:size(McRaeVisFeat_fill,2)
%     if ~isempty(McRaeVisFeat_fill{i,1})
%         xlswrite(xfile, McRaeVisFeat_fill{i,1},'sheet1', sprintf('B%s',int2str(i)));
%     end
% end

n=0;
for i=1:size(McRaeVisFeatMat,2)
    if isempty(find(McRaeVisFeatMat(:,i)>0, 1))
        n=n+1;removeCol(n)=i;
    end
end
McRaeVisFeatMat=McRaeVisFeatMat(:,1:547);
n=0;
for i=1:size(McRaeVisFeatMat,1)
    if isempty(find(McRaeVisFeatMat(i,:)>0, 1))
        n=n+1;removeRow(n)=i;
    end
end

% imagesc(McRaeVisFeatMat)
%put labels on axis
% bb=McRaeVisFeat(1,:);

%Mc
%correpsonding index in McRae for the 122 items
load('retfeatInd');
load('featTerms');
retfeatTerms=featTerms(retfeatInd);
load('visFormConceptNmUniq');

n=0;
for i=1:length(retfeatTerms)
    f=find((strcmp(retfeatTerms(i),visFormConceptNmUniq))==1);
    if ~isempty(f);
       n=n+1;
       MCnameindxlist(n)=f;
    end
end
McvisdsShr=McRaeVisFeatMat(MCnameindxlist,:);
lblMcvisdsShr=visFormConceptNmUniq(MCnameindxlist);

save('Mc122concepts','McvisdsShr','lblMcvisdsShr');

visCosDist=pdist(McvisdsShr,'cosine');
sqCosVisDist=squareform(visCosDist);

xfile='.\McRaePerceptProdFreq.xlsx';
xlswrite(xfile,McvisdsShr ,'sheet2', 'B2');

%Katia concepts
[~,katiaconcepts]=xlsread(xfile ,'KatiaConcepts', 'A1:A52');
n=0;
for i=1:length(katiaconcepts)
    f=find((strcmp(katiaconcepts(i),visFormConceptNmUniq))==1);
    if ~isempty(f);
       n=n+1;
       Katnameindxlist(n)=f;
    end
end
KatvisdsShr=McRaeVisFeatMat(Katnameindxlist,:);
lblKatvisdsShr=visFormConceptNmUniq(Katnameindxlist);
% save('Kat52concepts','KatvisdsShr','lblKatvisdsShr');

save('Kat52conceptsvisform','Katnameindxlist','KatvisdsShr','lblKatvisdsShr');

load('Kat52conceptsvisform');
visCosDistK=pdist(KatvisdsShr,'cosine');
sqCosVisDistK=squareform(visCosDistK);

load('Mc122concepts');
visCosDistM=pdist(McvisdsShr,'cosine');
sqCosVisDistM=squareform(visCosDistM);
