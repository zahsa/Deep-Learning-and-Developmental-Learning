%----- Zahra Sadeghi--------------------------
%----- University of Tehran-------------------
%----- zahra.sadeghi@ut.ac.ir-----------------


load('featType','featType');
load('conceptNm','conceptNm');
load('FeatureNm','FeatureNm');


visFormI=find(strcmp(featType,'visual-form_and_surface')==1);
visFormColorI=sort(visFormI);
save('visFormI','visFormI');

for i=1:length(visFormI)
    visFormfeat(i)=FeatureNm(visFormI(i));
    visFormConceptNm(i)=conceptNm(visFormI(i));
end
save('visFormfeat','visFormfeat');
save('visFormConceptNm','visFormConceptNm');

visFormfeatUniq=unique(visFormfeat,'first');
visFormConceptNmUniq=unique(visFormConceptNm,'first');

save('visFormfeatUniq','visFormfeatUniq');
save('visFormConceptNmUniq','visFormConceptNmUniq');%concepts having visual features

McRaeFormFeat=cell(length(visFormConceptNmUniq)+1,length(visFormfeatUniq)+1);

for i=1:length(visFormfeatUniq);
    McRaeFormFeat{1,i+1}=visFormfeatUniq(i);
end

for i=1:length(visFormConceptNmUniq);
    McRaeFormFeat{i+1,1}=visFormConceptNmUniq(i);
end

save('McRaeFormFeat','McRaeFormFeat');

