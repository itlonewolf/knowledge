##############################
Primer on Threading and Handlers in Android - Wedding Party

<p>Mobile devices are getting pretty fast, but they aren&rsquo;t infinitely fast yet. If you want your app to be able to do any serious work without affecting the user experience by locking up the interface, you&rsquo;ll have to resort to running things in parallel. On Android, this is done with &ldquo;threads&rdquo;.</p>

<p>Grab yourself a cup of coffee and read this post line by line. I&rsquo;ll introduce you to the concept of threads, talk about how Java uses threads and explain how &ldquo;Handlers&rdquo; in Android help with threading.</p>

<!-- more -->


<p>Whenever you want to do <em>asynchronous/parallel processing</em>, you do it with <strong>threads</strong>.</p>

<h2>Threads you say ?</h2>

<p>A thread or &ldquo;thread of execution&rdquo; is basically a sequence of instructions (of program code), that you send to your operating system.</p>

<div class="tac"><img src="http://upload.wikimedia.org/wikipedia/commons/a/a5/Multithreaded_process.svg" alt='Multi-threaded process' /></div>




<div class="tac" style="font-style:italic">Image Courtesy: Wikipedia.</div>


<br />


<p>&ldquo;Typically&rdquo; your CPU can process one thread, per core, at any time. So a multi-core processor (most Android devices today) by definition can handle multiple-threads of execution (which is to say, they can do multiple things at once).</p>

<h2>Truth to multi-core processing and single-core multitasking</h2>

<p>I say &ldquo;typically&rdquo; because the corollary to the above statement is not necessarily true. Single-core devices can &ldquo;simulate&rdquo; multithreading using multitasking.</p>

<p>Every &ldquo;task&rdquo; that&rsquo;s run on a thread can be broken down into multiple instructions. These instructions don&rsquo;t have to happen all at once. So a single-core device can switch to a thread &ldquo;1&rdquo; finish an instruction 1A, then switch to thread &ldquo;2&rdquo; finish an instruction 2A, switch back to 1 finish 1B, 1C, 1D, switch to 2, finish 2B, 2C and so on&hellip;</p>

<p>This switching between threads happens <em>so fast</em> that it <em>appears</em>, even on a single-core device, that all the threads are making progress at exactly the same time.  It&rsquo;s an illusion caused by speed, much like Agent Brown appearing to have multiple heads and arms.</p>

<p><img src="/images/posts/agent_brown_dodging_bullets.gif" /><br /></p>

<p>Now on to some code.</p>

<h2>Threads in core Java</h2>

<p>In Java, when you want to do parallel processing, you execute your code in a <code>Runnable</code> either by extending the <code>Thread</code> class or implementing the Runnable interface</p>

<figure class='code'><figcaption><span></span></figcaption><div class="highlight"><table><tr><td class="gutter"><pre class="line-numbers"><span class='line-number'>1</span>
<span class='line-number'>2</span>
<span class='line-number'>3</span>
<span class='line-number'>4</span>
<span class='line-number'>5</span>
<span class='line-number'>6</span>
<span class='line-number'>7</span>
<span class='line-number'>8</span>
<span class='line-number'>9</span>
<span class='line-number'>10</span>
<span class='line-number'>11</span>
<span class='line-number'>12</span>
<span class='line-number'>13</span>
<span class='line-number'>14</span>
<span class='line-number'>15</span>
<span class='line-number'>16</span>
<span class='line-number'>17</span>
<span class='line-number'>18</span>
<span class='line-number'>19</span>
<span class='line-number'>20</span>
<span class='line-number'>21</span>
<span class='line-number'>22</span>
<span class='line-number'>23</span>
<span class='line-number'>24</span>
</pre></td><td class='code'><pre><code class='java'><span class='line'><span class="c1">// Version 1</span>
</span><span class='line'><span class="kd">public</span> <span class="kd">class</span> <span class="nc">IAmAThread</span> <span class="kd">extends</span> <span class="n">Thread</span> <span class="o">{</span>
</span><span class='line'>    <span class="kd">public</span> <span class="nf">IAmAThread</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>        <span class="kd">super</span><span class="o">(</span><span class="s">&quot;IAmAThread&quot;</span><span class="o">);</span>
</span><span class='line'>    <span class="o">}</span>
</span><span class='line'>
</span><span class='line'>    <span class="nd">@Override</span>
</span><span class='line'>    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>        <span class="c1">// your code (sequence of instructions)</span>
</span><span class='line'>    <span class="o">}</span>
</span><span class='line'><span class="o">}</span>
</span><span class='line'><span class="c1">// to execute this sequence of instructions in a separate thread.</span>
</span><span class='line'><span class="k">new</span> <span class="nf">IAmAThread</span><span class="o">().</span><span class="na">start</span><span class="o">();</span>
</span><span class='line'>
</span><span class='line'><span class="c1">// Version 2</span>
</span><span class='line'><span class="kd">public</span> <span class="kd">class</span> <span class="nc">IAmARunnable</span> <span class="kd">implements</span> <span class="n">Runnable</span> <span class="o">{</span>
</span><span class='line'>    <span class="nd">@Override</span>
</span><span class='line'>    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>        <span class="c1">// your code (sequence of instructions)</span>
</span><span class='line'>    <span class="o">}</span>
</span><span class='line'><span class="o">}</span>
</span><span class='line'><span class="c1">// to execute this sequence of instructions in a separate thread.</span>
</span><span class='line'><span class="n">IAmARunnable</span> <span class="n">myRunnable</span> <span class="o">=</span> <span class="k">new</span> <span class="n">IAmARunnable</span><span class="o">();</span>
</span><span class='line'><span class="k">new</span> <span class="nf">Thread</span><span class="o">(</span><span class="n">myRunnable</span><span class="o">).</span><span class="na">start</span><span class="o">();</span>
</span></code></pre></td></tr></table></div></figure>


<p>Both of these approaches are fundamentally very similar. Version 1 involves creating an actual thread while Version 2 involves creating a runnable, which in-turn has to be called by a Thread.</p>

<p>Version 2, is generally the preferred approach (and is a much <a href="http://en.wikipedia.org/wiki/Composition_over_inheritance">larger subject</a> <a href="http://stackoverflow.com/questions/541487/implements-runnable-vs-extends-thread">of discussion</a>, beyond the scope of this post).</p>

<h2>Threads in Android</h2>

<p>Whenever your app starts up in Android, all components are run on a single primary thread (by default) called the &ldquo;main&rdquo; thread. The primary role of this thread though, is to handle the user interface and dispatch events to the appropriate widgets/views. For this reason, the main thread is also referred to as the &ldquo;UI&rdquo; thread.</p>

<p><a href="http://android-developers.blogspot.com/2009/05/painless-threading.html">If you have a long running operation on your UI thread</a>, the user interface is going to get locked up until this operation is complete. This is bad for your users! That&rsquo;s why it&rsquo;s important to understand how threads work in Android specifically, so you can offload some of the work to parallel threads. Android is pretty merciless about keeping things off the UI thread. If you have a long running operation on the UI thread you&rsquo;re probably going to run into the infamous <a href="http://developer.android.com/training/articles/perf-anr.html">ANR</a> that will conveniently allow your users to kill your app!</p>

<p>Now Android is all Java, so it supports the usage of the core Java <code>Thread</code> class to perform asynchronous processing. So you could use code very similar to the one shown in the &ldquo;Threads in Java&rdquo; section above, and start using threads in Android right away. But that can be a tad bit difficult.</p>

<h3>Why is using core Java threads in Android difficult?</h3>

<p>Well, parallel processing is not as easy as it sounds because you have to maintain &ldquo;concurrency&rdquo; across the multiple threads. In the words of the <a href="https://www.tbray.org/ongoing/When/201x/2014/01/01/Software-in-2014#p-2">very wise Tim Bray</a>:</p>

<blockquote><p>ordinary humans can&rsquo;t do concurrency at scale (or really at all) &hellip;</p></blockquote>

<p>Specifically for Android, the following is additionally cumbersome:</p>

<ol>
<li>Synchronization with the UI thread is a major <a href="http://www.urbandictionary.com/define.php?term=pita">PITA</a> (you typically want to do this, when you want to send progress updates to the UI, for your background operation)</li>
<li>Things change even more weirdly with orientation/configuration changes because an orientation change causes an activity to be recreated (so background threads may be trying to change the state of a destroyed activity, and if the background thread isn&rsquo;t on the UI thread, well that complicates things even more because of point 1).</li>
<li>There&rsquo;s also no default handling for thread pooling</li>
<li>Canceling thread actions requires custom code</li>
</ol>


<h3>Arr&hellip;ok, so how DO we do parallel processing in Android?</h3>

<p>Some (in)famous Android constructs you&rsquo;ve probably come across:</p>

<ol>
<li><p><a href="http://developer.android.com/reference/android/os/Handler.html"><code>Handler</code></a></p>

<p> This is the subject of our detailed discussion today</p></li>
<li><p><a href="http://developer.android.com/reference/android/os/AsyncTask.html"><code>AsyncTask</code></a></p>

<p> Using AsyncTasks are truly the simplest way to handle threads in Android. That being said, they are also the <a href="http://logc.at/2011/11/08/the-hidden-pitfalls-of-asynctask/">most</a> <a href="http://www.jayway.com/2012/11/28/is-androids-asynctask-executing-tasks-serially-or-concurrently/">error</a> <a href="http://bon-app-etit.blogspot.com/2013/04/the-dark-side-of-asynctask.html">prone</a>.</p></li>
<li><p><a href="http://developer.android.com/reference/android/app/IntentService.html"><code>IntentService</code></a></p>

<p> It requires more boiler plate code, but this is generally my preferred mechanism for off-loading long-running operations to the background. Armed with an EventBus like <a href="http://square.github.io/otto/">Otto</a>, IntentServices become amazingly easy to implement.</p></li>
<li><p><a href="http://developer.android.com/guide/components/loaders.html#summary"><code>Loader</code></a></p>

<p> These are geared more towards performing asynchronous tasks, that have to deal with data from databases or content providers.</p></li>
<li><p><a href="http://developer.android.com/guide/components/services.html"><code>Service</code></a> (honorable mention)</p>

<p> If you&rsquo;ve worked with Services closely, you should know that this is actually a little misleading. A common misconception is that Services run on the background thread. Nope! they &ldquo;appear&rdquo; to run in the background because they don&rsquo;t have a UI component associated with them. They actually run on the UI thread (by default)&hellip;. So they run on the UI thread by default, even though they don&rsquo;t have a UI component?</p></li>
</ol>


<div class="tac"><a href="http://martinvalasek.com/blog/pictures-from-a-developers-life"><img src="http://www.topito.com/wp-content/uploads/2013/01/code-24.gif" /></a></div>


<br />


<div class="tac">Naming has never been Google&#8217;s strong suit. ActivityInstrumentationTestCase &#8230; wait for it &#8230;. 2! Spinner anyone? </div>


<br />


<p>If you want your service to run on a background thread, you&rsquo;ll have to manually spawn another thread and execute your operations in that thread (similar to an approach discussed above). Really you should just use IntentServices but that is a subject for another post.</p>

<h1>Android Handlers:</h1>

<p>From the not-so-dummy-friendly <a href="http://developer.android.com/reference/android/os/Handler.html">Android developer documentation for Handlers</a>:</p>

<blockquote><p>A Handler allows you to send and process Message and Runnable objects associated with a thread&rsquo;s MessageQueue. Each Handler instance is associated with a single thread and that thread&rsquo;s message queue. When you create a new Handler, it is bound to the thread/message queue of the thread that is creating it &mdash; from that point on, it will deliver messages and runnables to that message queue and execute them as they come out of the message queue.</p></blockquote>

<div class="tac"><a href="http://martinvalasek.com/blog/pictures-from-a-developers-life"><img src="http://www.topito.com/wp-content/uploads/2013/01/code-02.gif" /></a></div>


<br />


<p>To understand that better, you probably need to know what <strong>Message Queues</strong> are.</p>

<h2>Message Queues:</h2>

<p>Threads basically have something called a &ldquo;Message Queue&rdquo;. These message queues allow communication between threads and is a sort of pattern, where control (or content) is passed between the threads.</p>

<p>It&rsquo;s actually a wonderful name, because it&rsquo;s exactly just that: a queue of messages or sequence of instructions, for the thread, to perform one by one. This additionally allows us to do two more cool things:</p>

<ul>
<li>&ldquo;schedule&rdquo; Messages and Runnables to be executed at some point in the future</li>
<li>enqueue an action to be performed on a different thread other than your own</li>
</ul>


<p><em>Note: when I mention &lsquo;message&rsquo; from here onwards, it&rsquo;s the same as a runnable object or a sequence of instructions.</em></p>

<p>So going back to Handlers in Android&hellip;. if you read and pause at every single line, the docs make much more sense now:</p>

<blockquote><p>A Handler allows you to send and process Message and Runnable objects associated with a thread&rsquo;s MessageQueue.</p></blockquote>

<p>So, a handler allows you to send messages to a thread&rsquo;s message queue. check ✔ !</p>

<blockquote><p>Each Handler instance is associated with a single thread and that thread&rsquo;s message queue.</p></blockquote>

<p>A handler can only be associated with a single thread. ✔</p>

<blockquote><p>When you create a new Handler, it is bound to the thread / message queue of the thread that is creating it</p></blockquote>

<p>So, which thread is a handler associated with? The thread that creates it. ✔</p>

<blockquote><p>&mdash; from that point on, it will deliver messages and runnables to that message queue and execute them as they come out of the message queue.</p></blockquote>

<p>Yeah yeah we already know that. Moving on&hellip;</p>

<p><em>Tip: Here&rsquo;s something you probably didn&rsquo;t know : in Android, every thread is associated with an instance of a Handler class, and it allows the thread to run along with other threads and communicate with them through messages.</em></p>

<p><em>Another Tip (if you&rsquo;ve dealt with the more common AsyncTasks): AsyncTasks use Handlers but don&rsquo;t run in the UI thread. They provide a channel to talk back to the UI, using the postExecute method.</em></p>

<h2>This is all cool yo, so how do I create them Handlers?</h2>

<p>Two ways:</p>

<ol>
<li>using the default constructor: new Handler()</li>
<li>using a parameterized constructor that takes a runnable object or callback object</li>
</ol>


<h2>What useful methods does the Handler API give me?</h2>

<p>Remember:</p>

<ul>
<li>Handlers simply send messages or &ldquo;posts&rdquo; to the message queues.</li>
<li>They are convenience methods that help syncing back with the UI thread.</li>
</ul>


<p>If you look at the <a href="http://developer.android.com/reference/android/os/Handler.html">API for Handlers</a> now, the main methods provided make sense:</p>

<ol>
<li>post</li>
<li>postDelayed</li>
<li>postAtTime</li>
</ol>


<h2>Code samples:</h2>

<p>The examples below are rudimentary, what you actually want to be closely following are the comments.</p>

<h3>Example 1: using &ldquo;post&rdquo; method of the Handler</h3>

<figure class='code'><figcaption><span></span></figcaption><div class="highlight"><table><tr><td class="gutter"><pre class="line-numbers"><span class='line-number'>1</span>
<span class='line-number'>2</span>
<span class='line-number'>3</span>
<span class='line-number'>4</span>
<span class='line-number'>5</span>
<span class='line-number'>6</span>
<span class='line-number'>7</span>
<span class='line-number'>8</span>
<span class='line-number'>9</span>
<span class='line-number'>10</span>
<span class='line-number'>11</span>
<span class='line-number'>12</span>
<span class='line-number'>13</span>
<span class='line-number'>14</span>
<span class='line-number'>15</span>
<span class='line-number'>16</span>
<span class='line-number'>17</span>
<span class='line-number'>18</span>
<span class='line-number'>19</span>
<span class='line-number'>20</span>
<span class='line-number'>21</span>
<span class='line-number'>22</span>
<span class='line-number'>23</span>
<span class='line-number'>24</span>
<span class='line-number'>25</span>
<span class='line-number'>26</span>
<span class='line-number'>27</span>
<span class='line-number'>28</span>
<span class='line-number'>29</span>
<span class='line-number'>30</span>
<span class='line-number'>31</span>
<span class='line-number'>32</span>
<span class='line-number'>33</span>
<span class='line-number'>34</span>
<span class='line-number'>35</span>
<span class='line-number'>36</span>
<span class='line-number'>37</span>
<span class='line-number'>38</span>
<span class='line-number'>39</span>
<span class='line-number'>40</span>
<span class='line-number'>41</span>
<span class='line-number'>42</span>
<span class='line-number'>43</span>
<span class='line-number'>44</span>
<span class='line-number'>45</span>
<span class='line-number'>46</span>
<span class='line-number'>47</span>
<span class='line-number'>48</span>
<span class='line-number'>49</span>
<span class='line-number'>50</span>
<span class='line-number'>51</span>
<span class='line-number'>52</span>
<span class='line-number'>53</span>
<span class='line-number'>54</span>
<span class='line-number'>55</span>
</pre></td><td class='code'><pre><code class='java'><span class='line'><span class="kd">public</span> <span class="kd">class</span> <span class="nc">TestActivity</span> <span class="kd">extends</span> <span class="n">Activity</span> <span class="o">{</span>
</span><span class='line'>
</span><span class='line'>    <span class="c1">// ...</span>
</span><span class='line'>    <span class="c1">// all standard stuff</span>
</span><span class='line'>
</span><span class='line'>    <span class="nd">@Override</span>
</span><span class='line'>    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">onCreate</span><span class="o">(</span><span class="n">Bundle</span> <span class="n">savedInstanceState</span><span class="o">)</span> <span class="o">{</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// ...</span>
</span><span class='line'>        <span class="c1">// all standard stuff</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// we&#39;re creating a new handler here</span>
</span><span class='line'>        <span class="c1">// and we&#39;re in the UI Thread (default)</span>
</span><span class='line'>        <span class="c1">// so this Handler is associated with the UI thread</span>
</span><span class='line'>        <span class="n">Handler</span> <span class="n">mHandler</span> <span class="o">=</span> <span class="k">new</span> <span class="n">Handler</span><span class="o">();</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// I want to start doing something really long</span>
</span><span class='line'>        <span class="c1">// which means I should run the fella in another thread.</span>
</span><span class='line'>        <span class="c1">// I do that by sending a message - in the form of another runnable object</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// But first, I&#39;m going to create a Runnable object or a message for this</span>
</span><span class='line'>        <span class="n">Runnable</span> <span class="n">mRunnableOnSeparateThread</span> <span class="o">=</span> <span class="k">new</span> <span class="n">Runnable</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>            <span class="nd">@Override</span>
</span><span class='line'>            <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span> <span class="o">()</span> <span class="o">{</span>
</span><span class='line'>
</span><span class='line'>                <span class="c1">// do some long operation</span>
</span><span class='line'>                <span class="n">longOperation</span><span class="o">();</span>
</span><span class='line'>
</span><span class='line'>                <span class="c1">// After mRunnableOnSeparateThread is done with it&#39;s job,</span>
</span><span class='line'>                <span class="c1">// I need to tell the user that i&#39;m done</span>
</span><span class='line'>                <span class="c1">// which means I need to send a message back to the UI thread</span>
</span><span class='line'>
</span><span class='line'>                <span class="c1">// who do we know that&#39;s associated with the UI thread?</span>
</span><span class='line'>                <span class="n">mHandler</span><span class="o">.</span><span class="na">post</span><span class="o">(</span><span class="k">new</span> <span class="n">Runnable</span><span class="o">(){</span>
</span><span class='line'>                    <span class="nd">@Override</span>
</span><span class='line'>                    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span><span class="o">(){</span>
</span><span class='line'>                        <span class="c1">// do some UI related thing</span>
</span><span class='line'>                        <span class="c1">// like update a progress bar or TextView</span>
</span><span class='line'>                        <span class="c1">// ....</span>
</span><span class='line'>                    <span class="o">}</span>
</span><span class='line'>                <span class="o">});</span>
</span><span class='line'>
</span><span class='line'>
</span><span class='line'>            <span class="o">}</span>
</span><span class='line'>        <span class="o">};</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// Cool but I&#39;ve not executed the mRunnableOnSeparateThread yet</span>
</span><span class='line'>        <span class="c1">// I&#39;ve only defined the message to be sent</span>
</span><span class='line'>        <span class="c1">// When I execute it though, I want it to be in a different thread</span>
</span><span class='line'>        <span class="c1">// that was the whole point.</span>
</span><span class='line'>
</span><span class='line'>        <span class="k">new</span> <span class="nf">Thread</span><span class="o">(</span><span class="n">mRunnableOnSeparateThread</span><span class="o">).</span><span class="na">start</span><span class="o">();</span>
</span><span class='line'>    <span class="o">}</span>
</span><span class='line'>
</span><span class='line'> <span class="o">}</span>
</span></code></pre></td></tr></table></div></figure>


<p>If I didn&rsquo;t have a handler object, posting back to the UI thread would have been pretty tricky.</p>

<h3>Example 2: using postDelayed</h3>

<p>In a recent feature for Wedding Party, I had to emulate the auto-complete functionality with an EditText. Every change in text triggered an API call to retrieve some data from our servers.</p>

<p>I wanted to reduce the number of API calls shot out by the app, so I used the Handler&rsquo;s postDelayed method to achieve this.</p>

<p>This example doesn&rsquo;t focus on parallel processing, but rather the ability for the Handler to function as a Message Queue and schedule messages to be executed at some later point in the future</p>

<figure class='code'><figcaption><span></span></figcaption><div class="highlight"><table><tr><td class="gutter"><pre class="line-numbers"><span class='line-number'>1</span>
<span class='line-number'>2</span>
<span class='line-number'>3</span>
<span class='line-number'>4</span>
<span class='line-number'>5</span>
<span class='line-number'>6</span>
<span class='line-number'>7</span>
<span class='line-number'>8</span>
<span class='line-number'>9</span>
<span class='line-number'>10</span>
<span class='line-number'>11</span>
<span class='line-number'>12</span>
<span class='line-number'>13</span>
<span class='line-number'>14</span>
<span class='line-number'>15</span>
<span class='line-number'>16</span>
<span class='line-number'>17</span>
<span class='line-number'>18</span>
<span class='line-number'>19</span>
<span class='line-number'>20</span>
<span class='line-number'>21</span>
<span class='line-number'>22</span>
<span class='line-number'>23</span>
<span class='line-number'>24</span>
<span class='line-number'>25</span>
<span class='line-number'>26</span>
<span class='line-number'>27</span>
<span class='line-number'>28</span>
<span class='line-number'>29</span>
<span class='line-number'>30</span>
<span class='line-number'>31</span>
<span class='line-number'>32</span>
<span class='line-number'>33</span>
<span class='line-number'>34</span>
<span class='line-number'>35</span>
</pre></td><td class='code'><pre><code class='java'><span class='line'><span class="c1">// the below code is inside a TextWatcher</span>
</span><span class='line'><span class="c1">// which implements the onTextChanged method</span>
</span><span class='line'><span class="c1">// I&#39;ve simplified it to only highlight the parts we&#39;re</span>
</span><span class='line'><span class="c1">// interested in</span>
</span><span class='line'>
</span><span class='line'><span class="kd">private</span> <span class="kt">long</span> <span class="n">lastChange</span> <span class="o">=</span> <span class="mi">0</span><span class="o">;</span>
</span><span class='line'>
</span><span class='line'><span class="nd">@Override</span>
</span><span class='line'><span class="kd">public</span> <span class="kt">void</span> <span class="nf">onTextChanged</span><span class="o">(</span><span class="kd">final</span> <span class="n">CharSequence</span> <span class="n">chars</span><span class="o">,</span>
</span><span class='line'>                          <span class="kt">int</span> <span class="n">start</span><span class="o">,</span> <span class="kt">int</span> <span class="n">before</span><span class="o">,</span> <span class="kt">int</span> <span class="n">count</span><span class="o">)</span> <span class="o">{</span>
</span><span class='line'>
</span><span class='line'>        <span class="c1">// The handler is spawned from the UI thread</span>
</span><span class='line'>        <span class="k">new</span> <span class="nf">Handler</span><span class="o">().</span><span class="na">postDelayed</span><span class="o">(</span>
</span><span class='line'>
</span><span class='line'>            <span class="c1">// argument 1 for postDelated = message to be sent</span>
</span><span class='line'>            <span class="k">new</span> <span class="nf">Runnable</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>                <span class="nd">@Override</span>
</span><span class='line'>                <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>
</span><span class='line'>                    <span class="k">if</span> <span class="o">(</span><span class="n">noChangeInText_InTheLastFewSeconds</span><span class="o">())</span> <span class="o">{</span>
</span><span class='line'>                        <span class="n">searchAndPopulateListView</span><span class="o">(</span><span class="n">chars</span><span class="o">.</span><span class="na">toString</span><span class="o">());</span>  <span class="c1">// logic</span>
</span><span class='line'>                    <span class="o">}</span>
</span><span class='line'>                <span class="o">}</span>
</span><span class='line'>            <span class="o">},</span>
</span><span class='line'>
</span><span class='line'>            <span class="c1">// argument 2 for postDelated = delay before execution</span>
</span><span class='line'>            <span class="mi">300</span><span class="o">);</span>
</span><span class='line'>
</span><span class='line'>        <span class="n">lastChange</span> <span class="o">=</span> <span class="n">System</span><span class="o">.</span><span class="na">currentTimeMillis</span><span class="o">();</span>
</span><span class='line'><span class="o">}</span>
</span><span class='line'>
</span><span class='line'>
</span><span class='line'><span class="kd">private</span> <span class="kt">boolean</span> <span class="nf">noChangeInText_InTheLastFewSeconds</span><span class="o">()</span> <span class="o">{</span>
</span><span class='line'>    <span class="k">return</span> <span class="n">System</span><span class="o">.</span><span class="na">currentTimeMillis</span><span class="o">()</span> <span class="o">-</span> <span class="n">lastChange</span> <span class="o">&gt;=</span> <span class="mi">300</span>
</span><span class='line'><span class="o">}</span>
</span></code></pre></td></tr></table></div></figure>


<p>I leave the &ldquo;postAtTime&rdquo; as an exercise for the reader. Got a grip on Handlers? Happy threading!</p>

<p><em>Follow the discussion on <a href="https://news.ycombinator.com/item?id=7921979">Hacker News</a> or <a href="http://www.reddit.com/r/androiddev/comments/28nsty/primer_on_threading_and_handlers_in_android/">Reddit</a> or <a href="https://plus.google.com/106712246601366256750/posts/KMU37xoYGuY">Google Plus</a></em>.</p>

<div class="marketing">If you can spend all day chatting with people on topics like these, <a href=" http://weddingpartyapp.com/jobs">we&#8217;re hiring Android engineers</a>!</div>
