Ant打包android程序步骤，及注意事项
=====================
参考链接
Managing Projects from the Command Line
http://developer.android.com/tools/projects/projects-cmdline.html#UpdatingAProject
Ant Build Android Project With Dependencies
http://stackoverflow.com/questions/12308849/ant-build-android-project-with-dependencies

------------------
**NOTE:在遇到各种android相关的问题中，通过baidu，google发现，其实最好的资源还是google的android相关网站http://developer.android.com/
各种版本的答案，溯其源头，大部分都是来自此网站。
故，有时间还是要多查看此网站，答案就在手头上！ **

>  **前提:**已创建了android项目，因某需求，需要Ant来管理


项目说明
----------------------------------

*  实例项目的目录结构(应该是相对复杂的，如果了解了此项目的ant管理，那么一般项目基本无障碍)


> app
> > dependent
> > > actionbarsherlock-new
> > > android-times-sequare
> > > android-uitableview		
> > > AppMsg-library		
> > > customShapeImageView		
> > > ResideMenu		
> > > sliding_menu_library


* 依赖说明
	1.  app依赖于dependent目录中的actionbarsherlock-new,android-times-sequare，android-uitableview，AppMsg-library，customShapeImageView，ResideMenu，sliding_menu_library
	2.  sliding_menu_library依赖于actionbarsherlock-new

管理步骤
---------------


1. **变更工程，使用Ant来管理**

	*  **正常项目工程（如本实例中的app）**
		进入根目录，然后执行以下代码:
         > android update project --name app --target android-20 --path .

	具体参数说明查看: http://developer.android.com/tools/projects/projects-cmdline.html#UpdatingAProject

	* **如果是第三方依赖库(如本实例中的actionbarsherlock-new等)**
		进入对应的第三方库文件的目录，执行以下代码
        > android update lib-project --target android-20 --path .


执行之后的目录结构如下：

> app
> > dependent
> > > actionbarsherlock-new
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties

> > > android-times-sequare
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties

		
> > > android-uitableview
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties

> > > AppMsg-library
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties
             
> > > customShapeImageView
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties
             
> > > ResideMenu
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties
             
> > > sliding_menu_library
> > > > AndroidManifest.xml

> > > > build.xml

> > > > local.properties

> > > > project.properties             
	
> AndroidManifest.xml

> build.xml

> local.properties

> project.properties

**2. 增加所需文件**
* 在根目录增加以下两个文件:
	* custom_rules.xml
		包含如下内容:
		<property file="ant.properties" />
		<property file="local.properties" />
		<property name="out.dir" value="out" />
		
	* ant.properties
		内容如下:
        	#签名文件
        	key.store=app-release-key.keystore
            #密码
            key.store.password=pswd
            #别名
            key.alias=alias
            #别名对应密码
            key.alias.password=pswd
            #混淆文件
            proguard.config=proguard-project.txt

**3.clean并编译项目**
在根目录中执行
> ant clean release

一般会运行失败...>_<

注意事项：
-------
1. 项目配置
	* 查看app目录中的project.properties文件，是否如下：【1】
    >	android.library.reference.1=dependent/actionbarsherlock-new
	>	android.library.reference.2=dependent/android-times-sequare
	>	android.library.reference.3=dependent/android-uitableview
	>	android.library.reference.4=dependent/AppMsg-library
	>	android.library.reference.5=dependent/customShapeImageView
	>	android.library.reference.6=dependent/ResideMenu
	>	android.library.reference.7=dependent/sliding_menu_library
	>	\# Project target.
	>	target=android-20

	* 查看各第三方库（除sliding_menu_library外）目录中的project.properties，是否如下：【2】
    >	\# Project target.
	>	target=android-20
	>	**android.library=true**
	* 查看sliding_menu_library目录中的project.properties文件，是否如下：【3】
	>	**android.library.reference.1=../actionbarsherlock-new**
	>	\# Project target.
	>	target=android-20
	>	**android.library=true**
2. 注意点:
	* 对比【1】、【2】、【3】可知，如果是第三方库的话，project.properties文件中一定有:`android.library=true`
	* 对第三方库的引用，路径是相对的，否则可能会出现含有如下文字的异常:
	>	resolve to a path with no project.properties file for project	
    
  	原因查看此处: http://stackoverflow.com/questions/12308849/ant-build-android-project-with-dependencies



3.**排查异常时，仔细分析异常**

