function [mvx,mvy] = motion_estimation(prev, curr, blkx, blky, search_range)
[currFrRow, currFrCol] = size(curr);
%SAD_Matrix = zeros(1+2*(search_range/blky),1+2*(search_range/blkx))
SAD_Matrix = zeros(currFrRow/blky,currFrCol/blkx);
SAD_elements = numel(SAD_Matrix);
nBlks = (currFrRow*currFrCol)/(blkx*blky);
    vRange = search_range;
    hRange = search_range;

%initaliaze mvx and mvy
mvx = zeros(currFrRow/blky,currFrCol/blkx);
mvy = zeros(currFrRow/blky,currFrCol/blkx);

n = 1;
rIndex = 1;
cIndex = 1;
rWinIndex = 1;
cWinIndex = 1;
%while cIndex<144
%    while rIndex<176
%         %extract block from curr
%         currBlk = curr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1); 
%         prevBlk = prev(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1);
%         
%         n = 1;
%         while n <= nBlks
%             %check if window is in allowed space 
%             if rIndex-vRange >= 1 && rIndex-vRange+blky <= currFrRow
%                 if cIndex-hRange >=1 && cIndex-hRange+blkx <= currFrCol
%                     
%                     window = prev(rIndex-vRange:rIndex-vRange+blky-1,cIndex-hRange:cIndex-hRange+blkx-1);
% 
%                     % SAD
%                     ab = abs(currBlk - window);
%                     SAD_Matrix(n) = sum(ab(:));
%                     n=n+1;
%                     end
%                 else
%                     hRange = hRange - 1;
%                 end
%             else
%                 vRange = vRange - 1;
%         end
%             
% 
%         end
%          rIndex = rIndex + blky;
%      end
%      rIndex = 1;
%      cIndex = cIndex + blkx;
% end
while cIndex<144
    while rIndex<176
        %extract block from curr
        currBlk = curr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        while cWinIndex<144
            while rWinIndex<176
                
%                 %check if window is in allowed space
%                 if rWinIndex-vRange >= 1 && rWinIndex-vRange+blky <= currFrRow
%                     if cWinIndex-hRange >=1 && cWinIndex-hRange+blkx <= currFrCo
                        
                        % check if window is in range
%                         cond1 = abs(rIndex-rWinIndex)
%                         cond2 = abs(cIndex-cWinIndex)
                        if abs(rIndex-rWinIndex) <= search_range && abs(cIndex-cWinIndex) <= search_range
                            window = prev(rWinIndex:rWinIndex+blky-1,cWinIndex:cWinIndex+blkx-1)

                            % SAD
                            ab = abs(currBlk - window);
                            s = sum(ab(:));
                            SAD_Matrix(n) = s
                        end
                        if n<SAD_elements
                            n=n+1;
                        end
                    %end
                %end
                
                rWinIndex = rWinIndex + blky;
            end
            rWinIndex = 1;
            cWinIndex = cWinIndex + blkx;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % coordinates of min SAD
        [r,c] = find(min(min(SAD_Matrix)));

        rMatch = r*blky+1;
        cMatch = c*blky+1;

        match = prev(rMatch:rMatch+blky-1, cMatch:cMatch+blkx-1);
        
        %mvx
        %mvy
        
        rIndex = rIndex + blky;
     end
     rIndex = 1;
     cIndex = cIndex + blkx;
end




