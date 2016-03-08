


initialmomentum = 0.5;
finalmomentum   = 0.9;
momentum = initialmomentum;

%%%%%%%%% START POSITIVE PHASE %%%%%%%%%
poshidprobs  = 1./(1 + exp(-data_mb * vishid - repmat(hidbiases, numcases, 1)));
posprods     = data_mb' * poshidprobs;
poshidact    = sum(poshidprobs);
posvisact    = sum(data_mb);
%%%%%%%%% END OF POSITIVE PHASE  %%%%%%%%%
poshidstates = poshidprobs > rand(numcases, numhid);

%%%%%%%%% START NEGATIVE PHASE  %%%%%%%%%
negdata     = 1./(1 + exp(-poshidstates * vishid' - repmat(visbiases, numcases, 1)));
neghidprobs = 1./(1 + exp(-negdata * vishid       - repmat(hidbiases, numcases, 1)));
negprods    = negdata' * neghidprobs;
neghidact   = sum(neghidprobs);
negvisact   = sum(negdata);
%%%%%%%%% END OF NEGATIVE PHASE %%%%%%%%%

err = sqrt(sum(sum((data_mb - negdata).^2)));
if epoch > 5,
    momentum = finalmomentum;
end

%%%%%%%%% UPDATE WEIGHTS AND BIASES %%%%%%%%%
vishidinc  = momentum * vishidinc  + epsilonw*( (posprods-negprods)/numcases - weightcost * vishid);
visbiasinc = momentum * visbiasinc + (epsilonvb/numcases)*(posvisact-negvisact);
hidbiasinc = momentum * hidbiasinc + (epsilonhb/numcases)*(poshidact-neghidact);
vishid     = vishid + vishidinc;
visbiases  = visbiases + visbiasinc;
hidbiases  = hidbiases + hidbiasinc;
%%%%%%%%% END OF UPDATES %%%%%%%%%
