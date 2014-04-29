ReadWriteLock用法
============
 
对象的方法中一旦加入synchronized修饰，则任何时刻只能有一个线程访问synchronized修饰的方法。假设有个数据对象拥有写方法与读方法，多线程环境中要想保证数据的安全，需对该对象的读写方法都要加入 synchronized同步块。这样任何线程在写入时，其它线程无法读取与改变数据；如果有线程在读取时，其他线程也无法读取或写入。这种方式在写入操作远大于读操作时，问题不大，而当读取远远大于写入时，会造成性能瓶颈，因为此种情况下读取操作是可以同时进行的，而加锁操作限制了数据的并发读取。  
####ReadWriteLock解决了这个问题:
    `当写操作时，其他线程无法读取或写入数据，
    而当读操作时，其它线程无法写入数据，但却可以读取数据 。`
    
且看以下例子

    public class ReadWriteLockDemo {
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static void main(String[] args) {
		Data data = new Data();
		Worker t1 = new Worker(data,true);
		Worker t2 = new Worker(data,true);
		t1.start();
		t2.start();
	}

	static class Worker extends Thread {
		Data data;
		boolean read;

		public Worker(Data data, boolean read) {
			this.data = data;
			this.read = read;
		}

		public void run() {
			if (read)
				data.get();
			else
				data.set();
		}
	}

	static class Data {
		ReadWriteLock lock = new ReentrantReadWriteLock();
		Lock read = lock.readLock();
		Lock write = lock.writeLock();
		public  void set() {
			write.lock();
			System.out.println(Thread.currentThread().hashCode()
					+ " set:begin " + sdf.format(new Date()));
			try {
				Thread.sleep(5000);
				//
			} catch (Exception e) {

			} finally {
				System.out.println(Thread.currentThread().hashCode() + " set:end "
						+ sdf.format(new Date()));
				write.unlock();
			}
			

		}

		public  int get() {
			read.lock();
			System.out.println(Thread.currentThread().hashCode()
					+ " get :begin " + sdf.format(new Date()));
			try {
				Thread.sleep(5000);
				//
			} catch (Exception e) {

			} finally {
				System.out.println(Thread.currentThread().hashCode() + " get :end "
						+ sdf.format(new Date()));
				read.unlock();
			}
			

			return 1;
		}
	}
    }


两个线程均是读线程，结果如下

    22474382 get :begin 2011-04-16 18:26:13
    4699264 get :begin 2011-04-16 18:26:13
    22474382 get :end 2011-04-16 18:26:18
    4699264 get :end 2011-04-16 18:26:18
 
两读线程均可同时读取数据，下面看一个是读线程，一个写线程的情况
      
      Data data = new Data();
      Worker t1 = new Worker(data,false);
      Worker t2 = new Worker(data,true);
      
      t2.start();
      Thread.sleep(100);
      t1.start();
 
先启动读取线程，再启动写入线程，看结果 

    14718739 get :begin 2011-04-16 18:54:46
    14718739 get :end 2011-04-16 18:54:51
    14737862 set:begin 2011-04-16 18:54:51
    14737862 set:end 2011-04-16 18:54:56
可以看到读取线程工作时，写入线程是不能访问数据的