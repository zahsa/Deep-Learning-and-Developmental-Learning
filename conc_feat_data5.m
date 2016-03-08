%step 1,2,3
%--correct version!!

clear all

% % xlFile='C:\Users\sce\Documents\ZAHRA\Fall 2014_Pado\Research\McRae_DeepNet\concs_feats.xlsx';
xlFile='/concs_feats.xlsx';

[b conceptNm]=xlsread(xlFile,'Sheet1','A2:A7260');
save('conceptNm','conceptNm');

[b featType]=xlsread(xlFile,'Sheet1','F2:F7260');
save('featType','featType');

[b FeatureNm]=xlsread(xlFile,'Sheet1','B2:B7260');
save('FeatureNm','FeatureNm');

[prodFreq]=xlsread(xlFile,'Sheet1','G2:G7260');
save('prodFreq','prodFreq');

load('featType','featType');
load('conceptNm','conceptNm');
load('FeatureNm','FeatureNm');

I=0;
for i=1:7259
    if length(find(strcmp(featType(i),'taxonomic')))==1 || ~isempty(find(strcmp(featType(i),'viusal-form_and_surface'))==1)
        I=I+1;
        ind(I)=i;
    end
end

% taxI=find(strcmp(featType,'taxonomic')==1);
visFormI=find(strcmp(featType,'visual-form_and_surface')==1);
save('visFormI','visFormI');

for i=1:length(visFormI)
    visFormFeat(i)=FeatureNm(visFormI(i));
    visFormConceptNm(i)=conceptNm(visFormI(i));
%     [b visFormFeat(i)]=xlsread(xlFile,'Sheet1',sprintf('B%s',int2str(visFormI(i)+1)));
%     [b conceptVisFormNm(i)]=xlsread(xlFile,'Sheet1',sprintf('A%s',int2str(visFormI(i)+1)));
end
save('visFormFeat','visFormFeat');
save('visFormConceptNm','visFormConceptNm');

visFormFeatUniq=unique(visFormFeat,'first');
visFormConceptNmUniq=unique(visFormConceptNm,'first');

save('visFormFeatUniq','visFormFeatUniq');
save('visFormConceptNmUniq','visFormConceptNmUniq');%concepts having visual features

McRaeVisFeat=[];
McRaeVisFeat=cell(length(visFormConceptNmUniq)+1,length(visFormFeatUniq)+2);

for i=1:length(visFormFeatUniq);
    McRaeVisFeat{1,i+1}=visFormFeatUniq(i);
end

for i=1:length(visFormConceptNmUniq);
    McRaeVisFeat{i+1,1}=visFormConceptNmUniq(i);
end

save('McRaeVisFeat','McRaeVisFeat');

taxI=find(strcmp(featType,'taxonomic')==1);
save('taxI','taxI');

for i=1:length(taxI)
    taxFeat(i)=FeatureNm(taxI(i));
    taxConceptNm(i)=conceptNm(taxI(i));
end

% for i=1:length(visFormI)
%     [b taxFeat(i)]=xlsread(xlFile,'Sheet1',sprintf('B%s',int2str(taxI(i)+1)));
%     [b conceptTaxNm(i)]=xlsread(xlFile,'Sheet1',sprintf('A%s',int2str(visFormI(i)+1)));
% end
save('taxFeat','taxFeat');
save('taxConceptNm','taxConceptNm');

taxFeatUniq=unique(taxFeat,'first');
taxConceptNmUniq=unique(taxConceptNm,'first');

save('taxFeatUniq','taxFeatUniq');
save('taxConceptNmUniq','taxConceptNmUniq');

% for i=1:length(taxFeat)
%     for j=1:length(taxConceptNm)
%         McRaeVisFeat{i+1,j+1}=0;
%     end
% end
% 
% for i=1:length(taxConceptNm)
%     concI=find(strcmp(taxConceptNm(i),conceptVisFormNmUniq)==1);
%     McRaeVisFeat{concI+1,length(McRaeVisFeat)}=taxFeat{i};
% end
% 
% for i=1:length(taxFeat)
%     featI=find(strcmp(visFormFeat(i),visFormFeatUniq)==1);
%     concI=find(strcmp(conceptVisFormNm(i),conceptVisFormNmUniq)==1);
%     McRaeVisFeat{concI+1,featI+1}=1;
% end

