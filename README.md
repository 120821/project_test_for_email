# delayed_job

### 简单使用

1. 修改Gemfile

```
gem 'delayed_job_active_record'
```

2. 创建作业表

```
rails generate delayed_job:active_record
rake db:migrate
```

3. 修改config/application.rb

在 Rails 4.2+ 中，在 config/application.rb 中设置queue_adapter

```
config.active_job.queue_adapter = :delayed_job
```

4. 查看bin文件夹
```
ls bin/
bundle  delayed_job  importmap  rails  rake  setup

```
bin/delayed_job 可用于管理后台进程，该进程将 开始工作。
5. 添加 gem "daemons" 到Gemfile

```
gem "daemons"
```
6. 运行脚本

```
ruby scripts/create_files.rb
```

```
{"fast":530,"fastest":530,"safeLow":143,"average":143,"block_time":12.694444444444445,"blockNum":15537392,"speed":0.7801066667730836,"safeLowWait":1.5,"avgWait":1.5,"fastWait":0.5,"fastestWait":0.5,"gasPriceRange":{"4":211.6,"6":211.6,"8":211.6,"10":211.6,"20":211.6,"30":211.6,"40":211.6,"50":211.6,"60":211.6,"70":211.6,"80":211.6,"90":211.6,"100":211.6,"110":211.6,"120":211.6,"130":211.6,"140":211.6,"143":1.5,"150":1.4,"160":1.2,"170":1.2,"180":1,"190":0.9,"210":0.8,"230":0.8,"250":0.7,"270":0.7,"290":0.7,"310":0.7,"330":0.7,"350":0.6,"370":0.6,"390":0.6,"410":0.6,"430":0.6,"450":0.6,"470":0.6,"490":0.6,"510":0.6,"530":0.5}}
530
143
end
```
7. 查看delayed_job任务的数量

```
rails c
```

查看delayed_job任务的数量
```
Delayed::Job.all
```
详情
```
Loading development environment (Rails 7.0.5)
irb(main):001:0> Delayed::Job.all
  priority: 0,
  attempts: 0,
  handler:
   "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: WriteToFileJob\n  job_id: 07ab6ce3-0af6-48af-b626-d69c5649d393\n  provider_job_id:\n  queue_name: default\n  priority:\n  arguments:\n  - Hello, Delayed Job!\n  - delayed_job_demo.txt\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2023-06-04T05:19:19Z'\n",
  last_error: nil,
  run_at: Sun, 04 Jun 2023 05:19:29.878768000 UTC +00:00,
  locked_at: nil,
  failed_at: nil,
  locked_by: nil,
  queue: "default",
  created_at: Sun, 04 Jun 2023 05:19:19.918858000 UTC +00:00,
  updated_at: Sun, 04 Jun 2023 05:19:19.918858000 UTC +00:00>,
 #<Delayed::Backend::ActiveRecord::Job:0x00007fc7c1e3add8
  id: 2,
  priority: 0,
  attempts: 0,
  handler:
   "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: WriteToFileJob\n  job_id: 826382b6-f2e3-45f1-b670-3ac683da3620\n  provider_job_id:\n  queue_name: default\n  priority:\n  arguments:\n  - fast: 530\n    fastest: 530\n    safeLow: 143\n    average: 143\n    block_time: 12.694444444444445\n    blockNum: 15537392\n    speed: 0.7801066667730836\n    safeLowWait: 1.5\n    avgWait: 1.5\n    fastWait: 0.5\n    fastestWait: 0.5\n    gasPriceRange:\n      '4': 211.6\n      '6': 211.6\n      '8': 211.6\n      '10': 211.6\n      '20': 211.6\n      '30': 211.6\n      '40': 211.6\n      '50': 211.6\n      '60': 211.6\n      '70': 211.6\n      '80': 211.6\n      '90': 211.6\n      '100': 211.6\n      '110': 211.6\n      '120': 211.6\n      '130': 211.6\n      '140': 211.6\n      '143': 1.5\n      '150': 1.4\n      '160': 1.2\n      '170': 1.2\n      '180': 1\n      '190': 0.9\n      '210': 0.8\n      '230': 0.8\n      '250': 0.7\n      '270': 0.7\n      '290': 0.7\n      '310': 0.7\n      '330': 0.7\n      '350': 0.6\n      '370': 0.6\n      '390': 0.6\n      '410': 0.6\n      '430': 0.6\n      '450': 0.6\n      '470': 0.6\n      '490': 0.6\n      '510': 0.6\n      '530': 0.5\n      _aj_symbol_keys: []\n    _aj_symbol_keys: []\n  - delayed_job_demo2.txt\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2023-06-04T05:19:19Z'\n",
  last_error: nil,
  run_at: Sun, 04 Jun 2023 05:19:29.929404000 UTC +00:00,
  locked_at: nil,
  failed_at: nil,
  locked_by: nil,
  queue: "default",
  created_at: Sun, 04 Jun 2023 05:19:19.930420000 UTC +00:00,
  updated_at: Sun, 04 Jun 2023 05:19:19.930420000 UTC +00:00>]
```
查看delayed_job任务的数量

```
Delayed::Job.all.count
```
详情
```
irb(main):002:0> Delayed::Job.all.count
  Delayed::Backend::ActiveRecord::Job Count (1.5ms)  SELECT COUNT(*) FROM "delayed_jobs"
=> 2
```
删除txt文件
```
rm *.txt
```

8. 启动任务

启动
```
RAILS_ENV=production bin/delayed_job start
```

查看delayed_job的数量

```
irb(main):003:0> Delayed::Job.all.count
  Delayed::Backend::ActiveRecord::Job Count (0.6ms)  SELECT COUNT(*) FROM "delayed_jobs"
=> 0
```
查看目录，已经生成了文件
```
 ls
app  config     db                     delayed_job_demo.txt  Gemfile       lib  public    readme.md  scripts  test  vendor
bin  config.ru  delayed_job_demo2.txt  dump.rdb              Gemfile.lock  log  Rakefile  README.md  storage  tmp

```

9. 继续测试

删除txt文件
```
rm *.txt
```

运行脚本

```
ruby scripts/create_files.rb
```

```
{"fast":530,"fastest":530,"safeLow":143,"average":143,"block_time":12.694444444444445,"blockNum":15537392,"speed":0.7801066667730836,"safeLowWait":1.5,"avgWait":1.5,"fastWait":0.5,"fastestWait":0.5,"gasPriceRange":{"4":211.6,"6":211.6,"8":211.6,"10":211.6,"20":211.6,"30":211.6,"40":211.6,"50":211.6,"60":211.6,"70":211.6,"80":211.6,"90":211.6,"100":211.6,"110":211.6,"120":211.6,"130":211.6,"140":211.6,"143":1.5,"150":1.4,"160":1.2,"170":1.2,"180":1,"190":0.9,"210":0.8,"230":0.8,"250":0.7,"270":0.7,"290":0.7,"310":0.7,"330":0.7,"350":0.6,"370":0.6,"390":0.6,"410":0.6,"430":0.6,"450":0.6,"470":0.6,"490":0.6,"510":0.6,"530":0.5}}
530
143
end
```
```
ruby scripts/create_files.rb
```

```
{"fast":530,"fastest":530,"safeLow":143,"average":143,"block_time":12.694444444444445,"blockNum":15537392,"speed":0.7801066667730836,"safeLowWait":1.5,"avgWait":1.5,"fastWait":0.5,"fastestWait":0.5,"gasPriceRange":{"4":211.6,"6":211.6,"8":211.6,"10":211.6,"20":211.6,"30":211.6,"40":211.6,"50":211.6,"60":211.6,"70":211.6,"80":211.6,"90":211.6,"100":211.6,"110":211.6,"120":211.6,"130":211.6,"140":211.6,"143":1.5,"150":1.4,"160":1.2,"170":1.2,"180":1,"190":0.9,"210":0.8,"230":0.8,"250":0.7,"270":0.7,"290":0.7,"310":0.7,"330":0.7,"350":0.6,"370":0.6,"390":0.6,"410":0.6,"430":0.6,"450":0.6,"470":0.6,"490":0.6,"510":0.6,"530":0.5}}
530
143
end
```
查看任务数量，可以看到恢复了2

稍等几秒，看到任务已经为0
查看目录,可以看到文件已经生成。
```
 ls
app  config     db                     delayed_job_demo.txt  Gemfile       lib  public    readme.md  scripts  test  vendor
bin  config.ru  delayed_job_demo2.txt  dump.rdb              Gemfile.lock  log  Rakefile  README.md  storage  tmp
```
所以启动`RAILS_ENV=production bin/delayed_job start`命令后，再次增加任务，可以不用再次start.
# project_test_for_email
