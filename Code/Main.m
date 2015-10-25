clear all;
close all;

%%  ��ȡ����ͼƬ
I1=imreadbw('1.jpg') ; 
I2=imreadbw('2.jpg') ;

I1=I1-min(I1(:)) ;
I1=I1/max(I1(:)) ;
I2=I2-min(I2(:)) ;
I2=I2/max(I2(:)) ;

%%  ���SIFT������
fprintf('Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1] = sift( I1, 'Verbosity', 1 ) ;
[frames2,descr2,gss2,dogss2] = sift( I2, 'Verbosity', 1 ) ;

%%  ��ʾ��һ��ͼ��SIFT����������
figure(1) ; clf ;
imagesc(imread('1.jpg')) ; hold on ;
h  = plotsiftframe(frames1,'style','arrow');
set(h,'Color','g','LineWidth',1); 
title('SIFT feature points in image 1') ;

%%  ��ʾ�ڶ���ͼ��sift����������
figure(2) ; clf ;
imagesc(imread('2.jpg')) ; hold on ;
h  = plotsiftframe(frames2,'style','arrow');
set(h,'Color','g','LineWidth',1); 
title('SIFT feature points in image 2') ;

%%  ��������ͼ��ƥ���������
fprintf('Computing matches....\n') ;
descr1=uint8(512*descr1) ;
descr2=uint8(512*descr2) ;
tic ; 
matches=siftmatch( descr1, descr2 ) ;
fprintf('Matched in %.3f s\n', toc) ;

%%  ��ʾ����ͼ��ƥ���������
figure(3) ; clf ;
plotmatches(I1,I2,frames1(1:2,:),frames2(1:2,:),matches) ;
drawnow ;

%%  �����
fprintf('Result��\n%d feature points in image 1\n', ...
      size(descr1, 2)) ;
fprintf('%d feature points in image 2\n', ...
      size(descr2, 2)) ;
fprintf('%d match points found\n', ...
      size(matches, 2)) ;