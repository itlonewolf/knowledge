1.空指针引起的原因
----
* 调用空对象的方法
* 访问或更新空对象的变量
* 获取空集合的长度
* 访问或更新空集合中的内容
* 抛出空的Throwable对象
* 同步空对象

2.避免空指针
----
为避免空指针，应当在使用之前确保对其做了适当的初始化。

1. 比较字符串时，模板在前，如：
<pre><code>
    Sting str = null;
    if("test".equals(str)){
      //do something
     }
</code><pre>
2. 检查方法传进来的参数是否为空，如：
<pre><code>
 public static int getLength(){
  if(s == null){
  throw new IllegalArgumentException("The argument cannot be null");    
   }
   return s.length();
   }</code><pre>
3. 使用String.valueOf()而不是toString()
4. 使用三元操作符,如：
  <pre><code> String message = (str == null) ? "":"message";</code><pre>
5. 方法返回空集合，而不是null，如：
	<pre><code> private static List<Integer> getList(String jsonData){
  if(jsonData == null){
    return Collections.emptyList();
   }
   //do something
   }</code><pre>
6. 使用Apache StringUtils类（如果是Android的话，可以使用TextUtils.isEmpty()方法），如：
	    <pre><code>  if(TextUtils.isEmpty(str))</code><pre>
7. 合理使用contains(),containsKey,containsValue等方法，如：
* 
	<pre><code> Map<String, String> map = ...
	 ...
	 String key = ...
	 if(map.containsKey(key)){
   //do something
   }</code><pre>
*  <pre><code> JSONObject jsonObject= new JSONObject() ;
   String key = ...
   if (jsonObject.has(key)) {
     try {
     long result = jsonObject.getLong(key);
     } catch (JSONException e) {
     e.printStackTrace();
   }
   }</code><pre>
8. 检查外部方法的返回值是否为空
9. 使用Assertions(断言)，如：
	<pre><code> 
	public static int getLength(String str){
   /*确定string不为空*/
   assert(str!=null);
   return str.length();
   }</code><pre>
	
    	此时如果str为空，那么则抛出java.lang.AssertionError异常而不是空指针异常
10. 使用Unit Tests
