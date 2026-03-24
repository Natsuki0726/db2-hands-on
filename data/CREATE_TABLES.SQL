--SQLで、二つのハイフンの後ろに書かれている内容は「コメント」として無視される。コードの解説はここに書くとよい。
--今回の条件だと、購入テーブルは一番最後に作る方が都合がいい。

--テーブルを作成するには、CREATE TABLE テーブル名()で作る。
CREATE TABLE 顧客 (
	USERID INTEGER NOT NULL,--それぞれの列の内容を書く。 INTEGERは「数字が入る」という意味。NOT NULLは「必ず値を入れる必要がある」というような意味。
	氏名 VARCHAR(60) NOT NULL,--VARCHARは「文字」が入る。(50)は上限50byte、という意味。Unicodeなら半角英数は1文字1byte,全角文字は3byte,絵文字は4byte。
	メールアドレス VARCHAR (100) NOT NULL,
	電話番号 VARCHAR (60) NOT NULL,--ハイフン抜きに変換してINTEGERで格納した方がいいのかもしれないけれども。
	登録日 DATE,--DATE型は年、月、日の三つの情報を格納する。時間まで格納したいならTIMESTAMP型のほうが良かったりする。
	CONSTRAINT 顧客_PK PRIMARY KEY(USERID)--USERIDをPRIMARY KEY(主キー)に設定するというCONSTRAINT(制約)顧客_PKを作成。主キーは重複もNULLも許されない。
);

CREATE TABLE 商品 (
	商品ID INTEGER NOT NULL,
	商品名 VARCHAR(50) NOT NULL,
	カテゴリ VARCHAR(50),
	価格 INTEGER CHECK (価格 > 0),--CHECKの後ろに条件をかくと、条件を満たさない入力は弾けるようになる。
	在庫 INTEGER CHECK (在庫 >= 0),
	CONSTRAINT 商品_PK PRIMARY KEY (商品ID)
);

CREATE TABLE 購入 (
	購入ID INTEGER NOT NULL,
	USERID INTEGER NOT NULL,
	商品ID INTEGER NOT NULL,
	購入量 INTEGER NOT NULL,
	購入日 DATE,
	総額 INTEGER,
	CONSTRAINT 購入_PK PRIMARY KEY (購入ID),
	CONSTRAINT 購入_顧客情報_FK FOREIGN KEY (USERID) REFERENCES 顧客(USERID),--FOREIGN KEY としてUSERIDを指定し、REFERNCES以下にどこの値と紐づけるか指定する。　この場合、顧客テーブルのUSERIDに存在しないものは、購入テーブルのUSERIDとして指定することができない。
	CONSTRAINT 購入_商品_FK FOREIGN KEY (商品ID) REFERENCES 商品(商品ID)
);


