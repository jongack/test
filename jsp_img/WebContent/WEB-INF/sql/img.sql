drop table img;
CREATE TABLE img2 ( 
  imgno   NUMBER(7)     NOT NULL,  -- 글 일련 번호, -9999999 ~ +9999999 
  wname   VARCHAR(20)   NOT NULL,  -- 글쓴이 
  title   VARCHAR(100)  NOT NULL,  -- 제목(*) 
  content VARCHAR(4000) NOT NULL,  -- 글 내용 
  passwd  VARCHAR(15)   NOT NULL,  -- 비밀 번호 
  filename VARCHAR(30)  NOT NULL,
  PRIMARY KEY (imgno)  
); 
 

-- 서브쿼리를 이용한 레코드 추가 
INSERT INTO img2(imgno, wname, title, content, passwd,filename)  
VALUES((SELECT NVL(MAX(imgno), 0) + 1 as imgno FROM img2), 
'왕눈이', '제목', '내용', '123','aaa1.jpg') ;

INSERT INTO img2(imgno, wname, title, content, passwd,filename)  
VALUES((SELECT NVL(MAX(imgno), 0) + 1 as imgno FROM img2), 
'아로미', '제목', '내용', '123','aaa2.jpg') ;

INSERT INTO img2(imgno, wname, title, content, passwd,filename)  
VALUES((SELECT NVL(MAX(imgno), 0) + 1 as imgno FROM img2), 
'투투', '제목', '내용', '123','aaa3.jpg') ;

INSERT INTO img2(imgno, wname, title, content, passwd,filename)  
VALUES((SELECT NVL(MAX(imgno), 0) + 1 as imgno FROM img2), 
'김길동', '제목', '내용', '123','aaa4.jpg') ;

INSERT INTO img2(imgno, wname, title, content, passwd,filename)  
VALUES((SELECT NVL(MAX(imgno), 0) + 1 as imgno FROM img2), 
'홍길동', '제목', '내용', '123','aaa5.jpg') ;

select * from img2

--read에서 여러파일읽어오는 문장
--
SELECT * FROM 
  ( 
     select   
         lag(imgno,2)     over (order by imgno ) pre_imgno2,  --1
         lag(imgno,1)     over (order by imgno ) pre_imgno1, --2
         imgno,--3기준
         lead(imgno,1)    over (order by imgno ) nex_imgno1,  --4
         lead(imgno,2)    over (order by imgno ) nex_imgno2,  --5
         lag(filename,2)  over (order by imgno ) pre_file2,   
         lag(filename,1)  over (order by imgno ) pre_file1,
         filename, 
         lead(filename,1) over (order by imgno ) nex_file1,
         lead(filename,2) over (order by imgno ) nex_file2 
         from ( 
              SELECT imgno, filename  
              FROM img2
              ORDER BY imgno desc
         ) 
  ) 
  WHERE imgno = 3
  