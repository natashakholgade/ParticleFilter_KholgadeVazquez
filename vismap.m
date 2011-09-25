function vismap(D)

I=zeros([size(D),3]);

I(:,:,1)=D; I(:,:,2)=D; I(:,:,3)=D;

I=reshape(I,numel(D),3);
Idx=D<-.5; Idx=Idx(:);
I(Idx,1)=0; I(Idx,2)=0; I(Idx,3)=1;

I=reshape(I,[size(D),3]);

imshow(I); axis xy;

end