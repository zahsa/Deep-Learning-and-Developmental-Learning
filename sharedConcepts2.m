%----- Zahra Sadeghi--------------------------
%----- University of Tehran-------------------
%----- zahra.sadeghi@ut.ac.ir-----------------

%shared concepts between vis and tax
load('visFormConceptNmUniq','visFormConceptNmUniq');
load('taxConceptNmUniq','taxConceptNmUniq');

fI=0;
for i=1:length(taxConceptNmUniq)
    f=find(strcmp(taxConceptNmUniq{i},visFormConceptNmUniq)==1);
    if (~isempty(f));
        fI=fI+1;
        visUniqfInd(fI)=f;
    end
end

conceptShrd=visFormConceptNmUniq(visUniqfInd);

n=0;
for i=1:length(conceptShrd)
    shVisI=find(strcmp(conceptShrd{i},visFormConceptNm)==1);
    for j=1:length(shVisI)
        n=n+1;
        visFeatShrd(n)=visFormFeat(shVisI(j));
    end
end

n=0;
for i=1:length(conceptShrd)
    shTaxI=find(strcmp(conceptShrd{i},taxConceptNm)==1);
    for j=1:length(shTaxI)
        n=n+1;
        taxFeatShrd(n)=taxFeat(shTaxI(j));
    end
end

McRaeVisFeatTax=[];
McRaeVisFeatTax=cell(length(conceptShrd)+1,length(visFeatShrd)+2);

for i=1:length(visFeatShrd);
    McRaeVisFeatTax{1,i+1}=visFeatShrd(i);
end

for i=1:length(conceptShrd);
    McRaeVisFeatTax{i+1,1}=conceptShrd(i);
end

for i=1:length(taxFeatShrd)
    McTaeVisFeatTax{i,end}=taxFeat
for i=1:length(visFeatShrd)
    for j=1:length(conceptShrd)
        McRaeVisFeatTax{i+1,j+1}=0;
    end
end
save('McRaeVisFeat','McRaeVisFeat');
