FasdUAS 1.101.10   ��   ��    k             l     ��  ��    J D ThreadWatcher example "Download Thread" script, by Mr. Freeze, 2010     � 	 	 �   T h r e a d W a t c h e r   e x a m p l e   " D o w n l o a d   T h r e a d "   s c r i p t ,   b y   M r .   F r e e z e ,   2 0 1 0   
  
 l     ��  ��    [ U-------------------------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��    [ U gets the url of the front most browser window, prompts the user for tags and ratings     �   �   g e t s   t h e   u r l   o f   t h e   f r o n t   m o s t   b r o w s e r   w i n d o w ,   p r o m p t s   t h e   u s e r   f o r   t a g s   a n d   r a t i n g s      l     ��  ��    H B then downloads and saves the images to the users downloads folder     �   �   t h e n   d o w n l o a d s   a n d   s a v e s   t h e   i m a g e s   t o   t h e   u s e r s   d o w n l o a d s   f o l d e r      l     ��  ��    \ V--------------------------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��������  ��  ��       !   l     �� " #��   " ) # make sure ThreadWatcher is running    # � $ $ F   m a k e   s u r e   T h r e a d W a t c h e r   i s   r u n n i n g !  % & % l    % '���� ' Z     % ( )�� * ( >    	 + , + n      - . - 1    ��
�� 
prun . 5     �� /��
�� 
capp / m     0 0 � 1 1 4 c o m . f r e e z e c o . t h r e a d w a t c h e r
�� kfrmID   , m    ��
�� boovtrue ) O    2 3 2 I   ������
�� .miscactvnull��� ��� null��  ��   3 m     4 4�                                                                                      @ alis    �  Startup                    ��~�H+   
TfThreadWatcher.app                                               ��p�n�x        ����  	                	Downloads     ��p�      �n�x     
Tf 
�  �T  3Startup:Users:frogblast:Downloads:ThreadWatcher.app   $  T h r e a d W a t c h e r . a p p    S t a r t u p  +Users/frogblast/Downloads/ThreadWatcher.app   /    ��  ��   * k    % 5 5  6 7 6 l   �� 8 9��   8 5 / if it was already running, open a new document    9 � : : ^   i f   i t   w a s   a l r e a d y   r u n n i n g ,   o p e n   a   n e w   d o c u m e n t 7  ;�� ; O   % < = < I   $���� >
�� .corecrel****      � null��   > �� ?��
�� 
kocl ? m     ��
�� 
docu��   = m     @ @�                                                                                      @ alis    �  Startup                    ��~�H+   
TfThreadWatcher.app                                               ��p�n�x        ����  	                	Downloads     ��p�      �n�x     
Tf 
�  �T  3Startup:Users:frogblast:Downloads:ThreadWatcher.app   $  T h r e a d W a t c h e r . a p p    S t a r t u p  +Users/frogblast/Downloads/ThreadWatcher.app   /    ��  ��  ��  ��   &  A B A l     ��������  ��  ��   B  C D C l     �� E F��   E L F find out which browser is running, so we can display the dialog in it    F � G G �   f i n d   o u t   w h i c h   b r o w s e r   i s   r u n n i n g ,   s o   w e   c a n   d i s p l a y   t h e   d i a l o g   i n   i t D  H I H l  & a J���� J Z   & a K L M N K =  & / O P O n   & - Q R Q 1   + -��
�� 
prun R 5   & +�� S��
�� 
capp S m   ( ) T T � U U 2 o r g . w e b k i t . n i g h t l y . W e b K i t
�� kfrmID   P m   - .��
�� boovtrue L r   2 5 V W V m   2 3 X X � Y Y  W e b K i t W o      ���� 0 
thebrowser   M  Z [ Z =  8 A \ ] \ n   8 ? ^ _ ^ 1   = ?��
�� 
prun _ 5   8 =�� `��
�� 
capp ` m   : ; a a � b b   c o m . a p p l e . S a f a r i
�� kfrmID   ] m   ? @��
�� boovtrue [  c d c r   D G e f e m   D E g g � h h  S a f a r i f o      ���� 0 
thebrowser   d  i j i =  J S k l k n   J Q m n m 1   O Q��
�� 
prun n 5   J O�� o��
�� 
capp o m   L M p p � q q & o r g . m o z i l l a . f i r e f o x
�� kfrmID   l m   Q R��
�� boovtrue j  r�� r r   V Y s t s m   V W u u � v v  F i r e f o x t o      ���� 0 
thebrowser  ��   N r   \ a w x w m   \ _ y y � z z  T h r e a d W a t c h e r x o      ���� 0 
thebrowser  ��  ��   I  { | { l     ��������  ��  ��   |  } ~ } l     ��  ���    3 - display dialogs for entering tags and rating    � � � � Z   d i s p l a y   d i a l o g s   f o r   e n t e r i n g   t a g s   a n d   r a t i n g ~  � � � l  b � ����� � O   b � � � � k   i � � �  � � � I  i n������
�� .miscactvnull��� ��� null��  ��   �  � � � r   o � � � � I  o |�� � �
�� .sysodlogaskr        TEXT � m   o r � � � � � T E n t e r   t a g s   f o r   i m a g e s ,   s e p e r a t e d   b y   c o m m a s � �� ���
�� 
dtxt � m   u x � � � � �  ��   � o      ���� 0 enteredtags   �  � � � r   � � � � � l  � � ����� � n   � � � � � 1   � ���
�� 
ttxt � o   � ����� 0 enteredtags  ��  ��   � o      ���� 0 	tagstring   �  � � � r   � � � � � I  � ��� � �
�� .sysodlogaskr        TEXT � m   � � � � � � � : E n t e r   r a t i n g   f o r   i m a g e s   ( 0 - 5 ) � �� ���
�� 
dtxt � m   � � � � � � �  ��   � o      ���� 0 enteredrating   �  ��� � r   � � � � � c   � � � � � l  � � ����� � l  � � ����� � n   � � � � � 1   � ���
�� 
ttxt � o   � ����� 0 enteredrating  ��  ��  ��  ��   � m   � ���
�� 
doub � o      ���� 0 ratingstring  ��   � 4   b f�� �
�� 
capp � o   d e���� 0 
thebrowser  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � e _ start fetching the thread. replace 'path to downloads folder' with your prefered save location    � � � � �   s t a r t   f e t c h i n g   t h e   t h r e a d .   r e p l a c e   ' p a t h   t o   d o w n l o a d s   f o l d e r '   w i t h   y o u r   p r e f e r e d   s a v e   l o c a t i o n �  � � � l     �� � ���   � x r change 'fetchThreadFromBrowser' to 'watchThreadFromBrowser' if you want ThreadWatcher to keep watching the thread    � � � � �   c h a n g e   ' f e t c h T h r e a d F r o m B r o w s e r '   t o   ' w a t c h T h r e a d F r o m B r o w s e r '   i f   y o u   w a n t   T h r e a d W a t c h e r   t o   k e e p   w a t c h i n g   t h e   t h r e a d �  � � � l     �� � ���   � Z T if you use the watch command it will download and save new images as they are found    � � � � �   i f   y o u   u s e   t h e   w a t c h   c o m m a n d   i t   w i l l   d o w n l o a d   a n d   s a v e   n e w   i m a g e s   a s   t h e y   a r e   f o u n d �  ��� � l  � � ����� � O   � � � � � O   � � � � � I  � ����� �
�� .borwsurlnull���     docu��   � �� � �
�� 
omtg � o   � ����� 0 	tagstring   � �� � �
�� 
rate � o   � ����� 0 ratingstring   � �� ���
�� 
insh � I  � ��� ���
�� .earsffdralis        afdr � m   � ���
�� afdrdown��  ��   � 4  � ��� �
�� 
docu � m   � �����  � m   � � � ��                                                                                      @ alis    �  Startup                    ��~�H+   
TfThreadWatcher.app                                               ��p�n�x        ����  	                	Downloads     ��p�      �n�x     
Tf 
�  �T  3Startup:Users:frogblast:Downloads:ThreadWatcher.app   $  T h r e a d W a t c h e r . a p p    S t a r t u p  +Users/frogblast/Downloads/ThreadWatcher.app   /    ��  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �  % � �  H � �  � � �  �����  ��  ��   �   � $�� 0���� 4�������� T X�� a g p u y ��� ��������� � ���������~�}�|�{�z�y
�� 
capp
�� kfrmID  
�� 
prun
�� .miscactvnull��� ��� null
�� 
kocl
�� 
docu
�� .corecrel****      � null�� 0 
thebrowser  
�� 
dtxt
�� .sysodlogaskr        TEXT�� 0 enteredtags  
�� 
ttxt�� 0 	tagstring  �� 0 enteredrating  
�� 
doub�� 0 ratingstring  
� 
omtg
�~ 
rate
�} 
insh
�| afdrdown
�{ .earsffdralis        afdr�z 
�y .borwsurlnull���     docu�� �)���0�,e � *j UY � 	*��l UO)���0�,e  �E�Y +)���0�,e  �E�Y )���0�,e  �E�Y a E�O*��/ G*j Oa a a l E` O_ a ,E` Oa a a l E` O_ a ,a &E` UO� '*�k/ *a _ a _ a a  j !a " #UUascr  ��ޭ