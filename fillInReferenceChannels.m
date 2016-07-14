function Wrot = fillInReferenceChannels(Wrotsub, connected, xc, yc)
%%
ix = find(connected<1e-6);

Wsmooth = eye(numel(connected));
for j = 1:length(ix)
    ds = (1e9 * (xc -xc(ix(j))).^2 + (yc -yc(ix(j))).^2).^.5;
%     ds = abs(yc -yc(ix(j)));
    dsort = sort(ds, 'ascend');
    ineigh = find(ds>1e-6 & ds<dsort(2)+1e-6);
    
    Wsmooth(ix(j),:)       = 0;
    Wsmooth(ix(j), ineigh) = 1./ds(ineigh);
    
end

Wsmooth = bsxfun(@rdivide, Wsmooth, sum(Wsmooth,2));

Wrot = zeros(numel(connected));
Wrot(connected>1e-6, connected>1e-6) = Wrotsub;
Wrot = Wsmooth * Wrot; 


Wrot = Wrot';
