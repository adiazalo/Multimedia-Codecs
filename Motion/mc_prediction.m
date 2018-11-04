function [mcpr,pred] = mc_prediction(prev,curr,mvx,mvy)

[rFrame,cFrame] = size(curr);
[rV,cV] = size(mvx);
blky = rFrame/rV
blkx = cFrame/cV
% blkx = zeros(rBlk,cBlk);
% blky = zeros(rBlk,cBlk);
mcpr = zeros(rFrame,cFrame);
pred = zeros(rFrame,cFrame);

n = 1;
rIndex = 1;
cIndex = 1;
while cIndex<cFrame
    while rIndex<rFrame
        %extract block from curr
        currBlk = curr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1);
        
        %exrtact the block from prev
%         xComp = mvx(n);
%         yComp = mvy(n);
%         rPrevIndex = (yComp-1)*blky+1;
%         cPrevIndex = (xComp-1)*blkx+1;

        cPrevIndex = mvx(n);
        rPrevIndex = mvy(n);
        
        %store previous blk in in same location where current blk is in curr
        prevBlk = prev(rPrevIndex:rPrevIndex+blky-1, cPrevIndex:cPrevIndex+blkx-1);
        pred(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1) = prevBlk;
        
        %store the diff
        mcpr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1) = currBlk-prevBlk;
        
        n = n + 1;
        rIndex = rIndex + blky;
    end
    rIndex = 1;
    cIndex = cIndex + blkx;
end