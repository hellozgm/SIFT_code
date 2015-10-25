clear all;
close all;

%%  读取两幅图片
I1=imreadbw('1.jpg') ; 
I2=imreadbw('2.jpg') ;

I1=I1-min(I1(:)) ;
I1=I1/max(I1(:)) ;
I2=I2-min(I2(:)) ;
I2=I2/max(I2(:)) ;

%%  检测SIFT特征点
fprintf('Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1] = sift( I1, 'Verbosity', 1 ) ;
[frames2,descr2,gss2,dogss2] = sift( I2, 'Verbosity', 1 ) ;

%%  显示第一幅图的SIFT特征点检测结果
figure(1) ; clf ;
imagesc(imread('1.jpg')) ; hold on ;
h  = plotsiftframe(frames1,'style','arrow');
set(h,'Color','g','LineWidth',1); 
title('SIFT feature points in image 1') ;

%%  显示第二幅图的sift特征点检测结果
figure(2) ; clf ;
imagesc(imread('2.jpg')) ; hold on ;
h  = plotsiftframe(frames2,'style','arrow');
set(h,'Color','g','LineWidth',1); 
title('SIFT feature points in image 2') ;

%%  计算两幅图中匹配的特征点
fprintf('Computing matches....\n') ;
descr1=uint8(512*descr1) ;
descr2=uint8(512*descr2) ;
tic ; 
matches=siftmatch( descr1, descr2 ) ;
fprintf('Matched in %.3f s\n', toc) ;

%%  显示两幅图中匹配的特征点
figure(3) ; clf ;
plotmatches(I1,I2,frames1(1:2,:),frames2(1:2,:),matches) ;
drawnow ;

%%  检测结果
fprintf('Result：\n%d feature points in image 1\n', ...
      size(descr1, 2)) ;
fprintf('%d feature points in image 2\n', ...
      size(descr2, 2)) ;
fprintf('%d match points found\n', ...
      size(matches, 2)) ;