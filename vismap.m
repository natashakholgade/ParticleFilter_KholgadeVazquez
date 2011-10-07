function vismap(D)

% Convert probs back to original format (-1: unknown, 0: occupied, 1: free)
D = 1 - D;

% Build color image
I=zeros([size(D),3]);
I(:,:,1)=D; I(:,:,2)=D; I(:,:,3)=D;
I=reshape(I,numel(D),3);

% Fill unknown with blue
Idx=D<-.5; Idx=Idx(:);
I(Idx,1)=0; I(Idx,2)=0; I(Idx,3)=1;

I=reshape(I,[size(D),3]);

% Show image
imshow(I); axis xy;

end