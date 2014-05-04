常用的一些存储方式:
###    SharedPreferences<br>

 To get a SharedPreferences object for your application, use one of two methods:
 
 * `getSharedPreferences()`<br>
        Use this if you need multiple preferences files identified by name, which you specify with the first parameter.
 * `getPreferences()` <br>
   Use this if you need only one preferences file for your Activity. Because this will be the only preferences file for your Activity, you don't supply a name.
To write values:
        
    Call edit() to get a SharedPreferences.Editor.
    Add values with methods such as putBoolean() and putString().
    Commit the new values with commit()

###Internal Storage
You can save files directly on the device's internal storage. By default, files saved to the internal storage are private to your application and other applications cannot access them (nor can the user). When the user uninstalls your application, these files are removed.

To `create` and `write` a private file to the internal storage:

<ol>
  <li> Call <b>openFileOutput()</b>with the name of the file and the operating mode. This returns a FileOutputStream.</li>
<li>Write to the file with <b>write()</b>.</li>
<li>Close the stream with <b>close()</b>.</li>

To `read` a file from internal storage:
<pre>
    <b>1.</b>Call openFileInput() and pass it the name of the file to read. This returns a FileInputStream.
    <b>2.</b>Read bytes from the file with read().
    <b>3.</b>Then close the stream with close().
</pre>

<br>

<h3>Saving cache files</h3>
<p>
If you'd like to cache some data, rather than store it persistently, you should use
<b>getCacheDir()</b> to open a File that represents the internal directory where your application should save temporary cache files.</p>
<p>
When the device is low on internal storage space, Android may delete these cache files to recover space. However, you should not rely on the system to clean up these files for you. You should always maintain the cache files yourself and stay within a reasonable limit of space consumed, such as 1MB. When the user uninstalls your application, these files are removed.</p>

<h3>Other useful methods</h3>
<pre>
    <b>getFilesDir()</b>
    Gets the absolute path to the filesystem directory where your internal files are saved.  
    <b>getDir()</b>
     Creates (or opens an existing) directory within your internal storage space.
    <b>deleteFile()</b> 
    Deletes a file saved on the internal storage.
    <b> fileList()</b> 
    Returns an array of files currently saved by your application.
</pre>




<h3>Using the External Storage</h3>
<p>Every Android-compatible device supports a shared "external storage" that you can use to save files. This can be a removable storage media (such as an SD card) or an internal (non-removable) storage. Files saved to the external storage are world-readable and can be modified by the user when they enable USB mass storage to transfer files on a computer.</p>

<b>Caution:</b> External storage can become unavailable if the user mounts the external storage on a computer or removes the media, and there's no security enforced upon files you save to the external storage. All applications can read and write files placed on the external storage and the user can remove them.

<p><b>Checking media availability</b><br>

Before you do any work with the external storage, you should always call.<i>getExternalStorageState()</i> to check whether the media is available. The media might be mounted to a computer, missing, read-only, or in some other state. For example, here are a couple methods you can use to check the availability:</p>
<pre class="java" name="code">
/* Checks if external storage is available for read and write */
public boolean isExternalStorageWritable() {
    String state = Environment.getExternalStorageState();
    if (Environment.MEDIA_MOUNTED.equals(state)) {
        return true;
    }
    return false;
}

/* Checks if external storage is available to at least read */
public boolean isExternalStorageReadable() {
    String state = Environment.getExternalStorageState();
    if (Environment.MEDIA_MOUNTED.equals(state) ||
        Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
        return true;
    }
    return false;
}
</pre>

<br><br><br><br>
===================================================================================

<div class="col-12" id="doc-col" >

    <h1 itemprop="name" >Storage Options</h1>
      
<div id="jd-content">


    <div class="jd-descr" itemprop="articleBody">
    <div id="qv-wrapper">
<div id="qv">

  <h2>Storage quickview</h2>
  <ul>
    <li>Use Shared Preferences for primitive data</li>
    <li>Use internal device storage for private data</li>
    <li>Use external storage for large data sets that are not private</li>
    <li>Use SQLite databases for structured storage</li>
  </ul>

  <h2>In this document</h2>
  <ol>
    <li><a href="#pref">Using Shared Preferences</a></li>
    <li><a href="#filesInternal">Using the Internal Storage</a></li>
    <li><a href="#filesExternal">Using the External Storage</a></li>
    <li><a href="#db">Using Databases</a></li>
    <li><a href="#netw">Using a Network Connection</a></li>
  </ol>

  <h2>See also</h2>
  <ol>
    <li><a href="#pref">Content Providers and Content Resolvers</a></li>
  </ol>

</div>
</div>

<p>Android provides several options for you to save persistent application data. The solution you
choose depends on your specific needs, such as whether the data should be private to your
application or accessible to other applications (and the user) and how much space your data
requires.
</p>

<p>Your data storage options are the following:</p>

<dl>
  <dt><a href="#pref">Shared Preferences</a></dt>
    <dd>Store private primitive data in key-value pairs.</dd>
  <dt><a href="#filesInternal">Internal Storage</a></dt>
    <dd>Store private data on the device memory.</dd>
  <dt><a href="#filesExternal">External Storage</a></dt>
    <dd>Store public data on the shared external storage.</dd>
  <dt><a href="#db">SQLite Databases</a></dt>
    <dd>Store structured data in a private database.</dd>
  <dt><a href="#netw">Network Connection</a></dt>
    <dd>Store data on the web with your own network server.</dd>
</dl>

<p>Android provides a way for you to expose even your private data to other applications
&mdash; with a <a href="/guide/topics/providers/content-providers.html">content
provider</a>. A content provider is an optional component that exposes read/write access to
your application data, subject to whatever restrictions you want to impose. For more information
about using content providers, see the
<a href="/guide/topics/providers/content-providers.html">Content Providers</a>
documentation.
</p>




<h2 id="pref">Using Shared Preferences</h2>

<p>The <code><a href="/reference/android/content/SharedPreferences.html">SharedPreferences</a></code> class provides a general framework that allows you
to save and retrieve persistent key-value pairs of primitive data types. You can use <code><a href="/reference/android/content/SharedPreferences.html">SharedPreferences</a></code> to save any primitive data: booleans, floats, ints, longs, and
strings. This data will persist across user sessions (even if your application is killed).</p>

<div class="sidebox-wrapper">
<div class="sidebox">
<h3>User Preferences</h3>
<p>Shared preferences are not strictly for saving "user preferences," such as what ringtone a
user has chosen. If you're interested in creating user preferences for your application, see <code><a href="/reference/android/preference/PreferenceActivity.html">PreferenceActivity</a></code>, which provides an Activity framework for you to create
user preferences, which will be automatically persisted (using shared preferences).</p>
</div>
</div>

<p>To get a <code><a href="/reference/android/content/SharedPreferences.html">SharedPreferences</a></code> object for your application, use one of
two methods:</p>
<ul>
  <li><code><a href="/reference/android/content/Context.html#getSharedPreferences(java.lang.String, int)">getSharedPreferences()</a></code> - Use this if you need multiple preferences files identified by name,
which you specify with the first parameter.</li>
  <li><code><a href="/reference/android/app/Activity.html#getPreferences(int)">getPreferences()</a></code> - Use this if you need
only one preferences file for your Activity. Because this will be the only preferences file
for your Activity, you don't supply a name.</li>
</ul>

<p>To write values:</p>
<ol>
  <li>Call <code><a href="/reference/android/content/SharedPreferences.html#edit()">edit()</a></code> to get a <code><a href="/reference/android/content/SharedPreferences.Editor.html">SharedPreferences.Editor</a></code>.</li>
  <li>Add values with methods such as <code><a href="/reference/android/content/SharedPreferences.Editor.html#putBoolean(java.lang.String, boolean)">putBoolean()</a></code> and <code><a href="/reference/android/content/SharedPreferences.Editor.html#putString(java.lang.String, java.lang.String)">putString()</a></code>.</li>
  <li>Commit the new values with <code><a href="/reference/android/content/SharedPreferences.Editor.html#commit()">commit()</a></code></li>
</ol>

<p>To read values, use <code><a href="/reference/android/content/SharedPreferences.html">SharedPreferences</a></code> methods such as <code><a href="/reference/android/content/SharedPreferences.html#getBoolean(java.lang.String, boolean)">getBoolean()</a></code> and <code><a href="/reference/android/content/SharedPreferences.html#getString(java.lang.String, java.lang.String)">getString()</a></code>.</p>

<p>
Here is an example that saves a preference for silent keypress mode in a
calculator:
</p>

<pre>
public class Calc extends Activity {
    public static final String PREFS_NAME = "MyPrefsFile";

    &#64;Override
    protected void onCreate(Bundle state){
       super.onCreate(state);
       . . .

       // Restore preferences
       SharedPreferences settings = getSharedPreferences(PREFS_NAME, 0);
       boolean silent = settings.getBoolean("silentMode", false);
       setSilent(silent);
    }

    &#64;Override
    protected void onStop(){
       super.onStop();

      // We need an Editor object to make preference changes.
      // All objects are from android.context.Context
      SharedPreferences settings = getSharedPreferences(PREFS_NAME, 0);
      SharedPreferences.Editor editor = settings.edit();
      editor.putBoolean("silentMode", mSilentMode);

      // Commit the edits!
      editor.commit();
    }
}
</pre>




<a name="files"></a>
<h2 id="filesInternal">Using the Internal Storage</h2>

<p>You can save files directly on the device's internal storage. By default, files saved
to the internal storage are private to your application and other applications cannot access
them (nor can the user). When the user uninstalls your application, these files are removed.</p>

<p>To create and write a private file to the internal storage:</p>

<ol>
  <li>Call <code><a href="/reference/android/content/Context.html#openFileOutput(java.lang.String, int)">openFileOutput()</a></code> with the
name of the file and the operating mode. This returns a <code><a href="/reference/java/io/FileOutputStream.html">FileOutputStream</a></code>.</li>
  <li>Write to the file with <code><a href="/reference/java/io/OutputStream.html#write(byte[])">write()</a></code>.</li>
  <li>Close the stream with <code><a href="/reference/java/io/FileOutputStream.html#close()">close()</a></code>.</li>
</ol>

<p>For example:</p>

<pre>
String FILENAME = "hello_file";
String string = "hello world!";

FileOutputStream fos = openFileOutput(FILENAME, Context.MODE_PRIVATE);
fos.write(string.getBytes());
fos.close();
</pre>

<p><code><a href="/reference/android/content/Context.html#MODE_PRIVATE">MODE_PRIVATE</a></code> will create the file (or replace a file of
the same name) and make it private to your application. Other modes available are: <code><a href="/reference/android/content/Context.html#MODE_APPEND">MODE_APPEND</a></code>, <code><a href="/reference/android/content/Context.html#MODE_WORLD_READABLE">MODE_WORLD_READABLE</a></code>, and <code><a href="/reference/android/content/Context.html#MODE_WORLD_WRITEABLE">MODE_WORLD_WRITEABLE</a></code>.</p>

<p>To read a file from internal storage:</p>

<ol>
  <li>Call <code><a href="/reference/android/content/Context.html#openFileInput(java.lang.String)">openFileInput()</a></code> and pass it the
name of the file to read. This returns a <code><a href="/reference/java/io/FileInputStream.html">FileInputStream</a></code>.</li>
  <li>Read bytes from the file with <code><a href="/reference/java/io/FileInputStream.html#read(byte[], int, int)">read()</a></code>.</li>
  <li>Then close the stream with  <code><a href="/reference/java/io/FileInputStream.html#close()">close()</a></code>.</li>
</ol>

<p class="note"><strong>Tip:</strong> If you want to save a static file in your application at
compile time, save the file in your project <code>res/raw/</code> directory. You can open it with
<code><a href="/reference/android/content/res/Resources.html#openRawResource(int)">openRawResource()</a></code>, passing the <code>R.raw.<em>&lt;filename&gt;</em></code> resource ID. This method returns an <code><a href="/reference/java/io/InputStream.html">InputStream</a></code>
that you can use to read the file (but you cannot write to the original file).
</p>


<h3 id="InternalCache">Saving cache files</h3>

<p>If you'd like to cache some data, rather than store it persistently, you should use <code><a href="/reference/android/content/Context.html#getCacheDir()">getCacheDir()</a></code> to open a <code><a href="/reference/java/io/File.html">File</a></code> that represents the internal directory where your application should save
temporary cache files.</p>

<p>When the device is
low on internal storage space, Android may delete these cache files to recover space. However, you
should not rely on the system to clean up these files for you. You should always maintain the cache
files yourself and stay within a reasonable limit of space consumed, such as 1MB. When the user
uninstalls your application, these files are removed.</p>


<h3 id="InternalMethods">Other useful methods</h3>

<dl>
  <dt><code><a href="/reference/android/content/Context.html#getFilesDir()">getFilesDir()</a></code></dt>
    <dd>Gets the absolute path to the filesystem directory where your internal files are saved.</dd>
  <dt><code><a href="/reference/android/content/Context.html#getDir(java.lang.String, int)">getDir()</a></code></dt>
    <dd>Creates (or opens an existing) directory within your internal storage space.</dd>
  <dt><code><a href="/reference/android/content/Context.html#deleteFile(java.lang.String)">deleteFile()</a></code></dt>
    <dd>Deletes a file saved on the internal storage.</dd>
  <dt><code><a href="/reference/android/content/Context.html#fileList()">fileList()</a></code></dt>
    <dd>Returns an array of files currently saved by your application.</dd>
</dl>




<h2 id="filesExternal">Using the External Storage</h2>

<p>Every Android-compatible device supports a shared "external storage" that you can use to
save files. This can be a removable storage media (such as an SD card) or an internal
(non-removable) storage. Files saved to the external storage are world-readable and can
be modified by the user when they enable USB mass storage to transfer files on a computer.</p>

<p class="caution"><strong>Caution:</strong> External storage can become unavailable if the user mounts the
external storage on a computer or removes the media, and there's no security enforced upon files you
save to the external storage. All applications can read and write files placed on the external
storage and the user can remove them.</p>

<h3 id="ExternalPermissions">Getting access to external storage</h3>

<p>In order to read or write files on the external storage, your app must acquire the
<code><a href="/reference/android/Manifest.permission.html#READ_EXTERNAL_STORAGE">READ_EXTERNAL_STORAGE</a></code>
or <code><a href="/reference/android/Manifest.permission.html#WRITE_EXTERNAL_STORAGE">WRITE_EXTERNAL_STORAGE</a></code> system
permissions. For example:</p>
<pre>
&lt;manifest ...>
    &lt;uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    ...
&lt;/manifest>
</pre>

<p>If you need to both read and write files, then you need to request only the
<code><a href="/reference/android/Manifest.permission.html#WRITE_EXTERNAL_STORAGE">WRITE_EXTERNAL_STORAGE</a></code> permission, because it
implicitly requires read access as well.</p>

<p class="note"><strong>Note:</strong> Beginning with Android 4.4, these permissions are not
required if you're reading or writing only files that are private to your app. For more
information, see the section below about
<a href="#AccessingExtFiles">saving files that are app-private</a>.</p>



<h3 id="MediaAvail">Checking media availability</h3>

<p>Before you do any work with the external storage, you should always call <code><a href="/reference/android/os/Environment.html#getExternalStorageState()">getExternalStorageState()</a></code> to check whether the media is available. The
media might be mounted to a computer, missing, read-only, or in some other state. For example,
here are a couple methods you can use to check the availability:</p>

<pre>
/* Checks if external storage is available for read and write */
public boolean isExternalStorageWritable() {
    String state = Environment.getExternalStorageState();
    if (Environment.MEDIA_MOUNTED.equals(state)) {
        return true;
    }
    return false;
}

/* Checks if external storage is available to at least read */
public boolean isExternalStorageReadable() {
    String state = Environment.getExternalStorageState();
    if (Environment.MEDIA_MOUNTED.equals(state) ||
        Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
        return true;
    }
    return false;
}
</pre>

<p>The <code><a href="/reference/android/os/Environment.html#getExternalStorageState()">getExternalStorageState()</a></code> method returns other states that you
might want to check, such as whether the media is being shared (connected to a computer), is missing
entirely, has been removed badly, etc. You can use these to notify the user with more information
when your application needs to access the media.</p>


<h3 id="SavingSharedFiles">Saving files that can be shared with other apps</h3>

<div class="sidebox-wrapper" >
<div class="sidebox">

<h4>Hiding your files from the Media Scanner</h4>

<p>Include an empty file named <code>.nomedia</code> in your external files directory (note the dot
prefix in the filename). This prevents media scanner from reading your media
files and providing them to other apps through the <code><a href="/reference/android/provider/MediaStore.html">MediaStore</a></code>
content provider. However, if your files are truly private to your app, you should
<a href="#AccessingExtFiles">save them in an app-private directory</a>.</p>

</div>
</div>

<p>Generally, new files that the user may acquire through your app should be saved to a "public"
location on the device where other apps can access them and the user can easily copy them from the
device. When doing so, you should use to one of the shared public directories, such as <code>Music/</code>, <code>Pictures/</code>, and <code>Ringtones/</code>.</p>

<p>To get a <code><a href="/reference/java/io/File.html">File</a></code> representing the appropriate public directory, call <code><a href="/reference/android/os/Environment.html#getExternalStoragePublicDirectory(java.lang.String)">getExternalStoragePublicDirectory()</a></code>, passing it the type of directory you want, such as
<code><a href="/reference/android/os/Environment.html#DIRECTORY_MUSIC">DIRECTORY_MUSIC</a></code>, <code><a href="/reference/android/os/Environment.html#DIRECTORY_PICTURES">DIRECTORY_PICTURES</a></code>,
<code><a href="/reference/android/os/Environment.html#DIRECTORY_RINGTONES">DIRECTORY_RINGTONES</a></code>, or others. By saving your files to the
corresponding media-type directory,
the system's media scanner can properly categorize your files in the system (for
instance, ringtones appear in system settings as ringtones, not as music).</p>


<p>For example, here's a method that creates a directory for a new photo album in
the public pictures directory:</p>

<pre>
public File getAlbumStorageDir(String albumName) {
    // Get the directory for the user's public pictures directory.
    File file = new File(Environment.getExternalStoragePublicDirectory(
            Environment.DIRECTORY_PICTURES), albumName);
    if (!file.mkdirs()) {
        Log.e(LOG_TAG, "Directory not created");
    }
    return file;
}
</pre>



<h3 id="AccessingExtFiles">Saving files that are app-private</h3>

<p>If you are handling files that are not intended for other apps to use
(such as graphic textures or sound effects used by only your app), you should use
a private storage directory on the external storage by calling <code><a href="/reference/android/content/Context.html#getExternalFilesDir(java.lang.String)">getExternalFilesDir()</a></code>.
This method also takes a <code>type</code> argument to specify the type of subdirectory
(such as <code><a href="/reference/android/os/Environment.html#DIRECTORY_MOVIES">DIRECTORY_MOVIES</a></code>). If you don't need a specific
media directory, pass <code>null</code> to receive
the root directory of your app's private directory.</p>

<p>Beginning with Android 4.4, reading or writing files in your app's private
directories does not require the <code><a href="/reference/android/Manifest.permission.html#READ_EXTERNAL_STORAGE">READ_EXTERNAL_STORAGE</a></code>
or <code><a href="/reference/android/Manifest.permission.html#WRITE_EXTERNAL_STORAGE">WRITE_EXTERNAL_STORAGE</a></code>
permissions. So you can declare the permission should be requested only on the lower versions
of Android by adding the <a
href="/guide/topics/manifest/uses-permission-element.html#maxSdk"><code>maxSdkVersion</code></a>
attribute:</p>
<pre>
&lt;manifest ...>
    &lt;uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
                     android:maxSdkVersion="18" />
    ...
&lt;/manifest>
</pre>

<p class="note"><strong>Note:</strong>
When the user uninstalls your application, this directory and all its contents are deleted.
Also, the system media scanner does not read files in these directories, so they are not accessible
from the <code><a href="/reference/android/provider/MediaStore.html">MediaStore</a></code> content provider. As such, you <b>should not
use these directories</b> for media that ultimately belongs to the user, such as photos
captured or edited with your app, or music the user has purchased with your app&mdash;those
files should be <a href="#SavingSharedFiles">saved in the public directories</a>.</p>

<p>Sometimes, a device that has allocated a partition of the
internal memory for use as the external storage may also offer an SD card slot.
When such a device is running Android 4.3 and lower, the <code><a href="/reference/android/content/Context.html#getExternalFilesDir(java.lang.String)">getExternalFilesDir()</a></code> method provides
access to only the internal partition and your app cannot read or write to the SD card.
Beginning with Android 4.4, however, you can access both locations by calling
<code><a href="/reference/android/content/Context.html#getExternalFilesDirs(java.lang.String)">getExternalFilesDirs()</a></code>,
which returns a <code><a href="/reference/java/io/File.html">File</a></code> array with entries each location. The first entry in the array is considered
the primary external storage and you should use that location unless it's full or
unavailable. If you'd like to access both possible locations while also supporting Android
4.3 and lower, use the <a href="/tools/support-library/index.html">support library's</a>
static method, <code><a href="/reference/android/support/v4/content/ContextCompat.html#getExternalFilesDirs(android.content.Context, java.lang.String)">ContextCompat.getExternalFilesDirs()</a></code>. This also returns a <code><a href="/reference/java/io/File.html">File</a></code> array, but always includes only one entry on Android 4.3 and lower.</p>

<p class="caution"><strong>Caution</strong> Although the directories provided by <code><a href="/reference/android/content/Context.html#getExternalFilesDir(java.lang.String)">getExternalFilesDir()</a></code> and <code><a href="/reference/android/content/Context.html#getExternalFilesDirs(java.lang.String)">getExternalFilesDirs()</a></code> are not accessible by the
<code><a href="/reference/android/provider/MediaStore.html">MediaStore</a></code> content provider, other apps with the <code><a href="/reference/android/Manifest.permission.html#READ_EXTERNAL_STORAGE">READ_EXTERNAL_STORAGE</a></code> permission can access all files on the external
storage, including these. If you need to completely restrict access for your files, you should
instead write your files to the <a href="#filesInternal">internal storage</a>.</p>





<h3 id="ExternalCache">Saving cache files</h3>

<p>To open a <code><a href="/reference/java/io/File.html">File</a></code> that represents the
external storage directory where you should save cache files, call <code><a href="/reference/android/content/Context.html#getExternalCacheDir()">getExternalCacheDir()</a></code>. If the user uninstalls your
application, these files will be automatically deleted.</p>

<p>Similar to <code><a href="/reference/android/support/v4/content/ContextCompat.html#getExternalFilesDirs(android.content.Context, java.lang.String)">ContextCompat.getExternalFilesDirs()</a></code>, mentioned above, you can also access a cache directory on
a secondary external storage (if available) by calling
<code><a href="/reference/android/support/v4/content/ContextCompat.html#getExternalCacheDirs(android.content.Context)">ContextCompat.getExternalCacheDirs()</a></code>.</p>

<p class="note"><strong>Tip:</strong>
To preserve file space and maintain your app's performance,
it's important that you carefully manage your cache files and remove those that aren't
needed anymore throughout your app's lifecycle.</p>




<h2 id="db">Using Databases</h2>

<p>Android provides full support for <a href="http://www.sqlite.org/">SQLite</a> databases.
Any databases you create will be accessible by name to any
class in the application, but not outside the application.</p>

<p>The recommended method to create a new SQLite database is to create a subclass of <code><a href="/reference/android/database/sqlite/SQLiteOpenHelper.html">SQLiteOpenHelper</a></code> and override the <code><a href="/reference/android/database/sqlite/SQLiteOpenHelper.html#onCreate(android.database.sqlite.SQLiteDatabase)">onCreate()</a></code> method, in which you
can execute a SQLite command to create tables in the database. For example:</p>

<pre>
public class DictionaryOpenHelper extends SQLiteOpenHelper {

    private static final int DATABASE_VERSION = 2;
    private static final String DICTIONARY_TABLE_NAME = "dictionary";
    private static final String DICTIONARY_TABLE_CREATE =
                "CREATE TABLE " + DICTIONARY_TABLE_NAME + " (" +
                KEY_WORD + " TEXT, " +
                KEY_DEFINITION + " TEXT);";

    DictionaryOpenHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    &#64;Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(DICTIONARY_TABLE_CREATE);
    }
}
</pre>

<p>You can then get an instance of your <code><a href="/reference/android/database/sqlite/SQLiteOpenHelper.html">SQLiteOpenHelper</a></code>
implementation using the constructor you've defined. To write to and read from the database, call
<code><a href="/reference/android/database/sqlite/SQLiteOpenHelper.html#getWritableDatabase()">getWritableDatabase()</a></code> and <code><a href="/reference/android/database/sqlite/SQLiteOpenHelper.html#getReadableDatabase()">getReadableDatabase()</a></code>, respectively. These both return a
<code><a href="/reference/android/database/sqlite/SQLiteDatabase.html">SQLiteDatabase</a></code> object that represents the database and
provides methods for SQLite operations.</p>

<div class="sidebox-wrapper">
<div class="sidebox">
<p>Android does not impose any limitations beyond the standard SQLite concepts. We do recommend
including an autoincrement value key field that can be used as a unique ID to
quickly find a record.  This is not required for private data, but if you
implement a <a href="/guide/topics/providers/content-providers.html">content provider</a>,
you must include a unique ID using the <code><a href="/reference/android/provider/BaseColumns.html#_ID">BaseColumns._ID</a></code>
constant.
</p>
</div>
</div>

<p>You can execute SQLite queries using the <code><a href="/reference/android/database/sqlite/SQLiteDatabase.html">SQLiteDatabase</a></code>
<code><a href="/reference/android/database/sqlite/SQLiteDatabase.html#query(boolean, java.lang.String, java.lang.String[], java.lang.String, java.lang.String[], java.lang.String, java.lang.String, java.lang.String, java.lang.String)">query()</a></code> methods, which accept various query parameters, such as the table to query,
the projection, selection, columns, grouping, and others. For complex queries, such as
those that require column aliases, you should use
<code><a href="/reference/android/database/sqlite/SQLiteQueryBuilder.html">SQLiteQueryBuilder</a></code>, which provides
several convienent methods for building queries.</p>

<p>Every SQLite query will return a <code><a href="/reference/android/database/Cursor.html">Cursor</a></code> that points to all the rows
found by the query. The <code><a href="/reference/android/database/Cursor.html">Cursor</a></code> is always the mechanism with which
you can navigate results from a database query and read rows and columns.</p>

<p>For sample apps that demonstrate how to use SQLite databases in Android, see the
<a href="/resources/samples/NotePad/index.html">Note Pad</a> and
<a href="/resources/samples/SearchableDictionary/index.html">Searchable Dictionary</a>
applications.</p>


<h3 id="dbDebugging">Database debugging</h3>

<p>The Android SDK includes a <code>sqlite3</code> database tool that allows you to browse
table contents, run SQL commands, and perform other useful functions on SQLite
databases.  See <a href="/tools/help/adb.html#sqlite">Examining sqlite3
databases from a remote shell</a> to learn how to run this tool.
</p>





<h2 id="netw">Using a Network Connection</h2>

<!-- TODO MAKE THIS USEFUL!! -->

<p>You can use the network (when it's available) to store and retrieve data on your own web-based
services. To do network operations, use classes in the following packages:</p>

<ul class="no-style">
  <li><code><code><a href="/reference/java/net/package-summary.html">java.net.*</a></code></code></li>
  <li><code><code><a href="/reference/android/net/package-summary.html">android.net.*</a></code></code></li>
</ul>

