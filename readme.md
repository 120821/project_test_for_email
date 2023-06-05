# rails delayed_job 的简单使用
1.创建新的项目，用来测试

```
rails new delayed_job
```

进入文件夹
```
cd delayed_job/
```
2.修改Gemfile, 增加gem

```
gem 'httparty'
gem 'sidekiq'
gem 'pg'
```

修改config/application.rb,增加
```
config.active_job.queue_adapter = :sidekiq
```

修改config/database.yml
```
default: &default
  adapter: postgresql
  pool: <%= ENV["DATABASE_POOL"] || 64 %>
  timeout: 5000
  encoding: utf-8
  user: 用户名
  username: 用户名
  password: 你的密码
  port: 5432

development:
  <<: *default
  database: delayed_job

test:
  <<: *default
  database: delayed_job_test

production:
  <<: *default
  database: delayed_job
```

3.启动redis sidekiq

```
redis-server
```

```
bundle exec sidekiq
```

4.创建表

```
rails generate delayed_job:active_record
```
或者

```
rails generate migration AddDelayedJob
```
修改生成的migrate文件
```
class AddDelayedJob < ActiveRecord::Migration[7.0]
  def change
    create_table :delayed_jobs do |t|
      t.integer :priority, default: 0, null: false  # The priority of the job, defaults to 0
      t.integer :attempts, default: 0, null: false  # Number of attempts to execute the job, defaults to 0
      t.text :handler, null: false                   # YAML-encoded string of the object that will be processed. Must be able to be unmarshalled by Delayed::Job.
      t.text :last_error                              # Contains the last error raised, if any, while processing this job.
      t.datetime :run_at                              # When to run the job. Might be immediately or sometime in the future.
      t.datetime :locked_at                           # When a worker acquired this job for processing.
      t.datetime :failed_at                           # When the job last failed.
      t.string :locked_by                             # Who is working on this object, if locked.
      t.string :queue                                 # The name of the queue this job is in.
      t.timestamps null: true
    end
    add_index :delayed_jobs, %i[priority run_at], name: "delayed_jobs_priority"
  end
end
```

5.创建测试的脚本，来调取job

```
vim scripts/delayed_job_test.rb
```
内容如下
```
ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails'
require 'rubygems'
require 'json'

require 'httparty'


temp = HTTParty.get "https://ethgasstation.info/api/ethgasAPI.json", timeout: 10
#temp = HTTParty.get "https://ethgasstation.info/api/ethgasAPI.json"

puts temp.body

temp2 = JSON.parse(temp.body)

puts temp2["fastest"]
puts temp2["safeLow"]


WriteToFileJob.set(wait: 10.seconds).perform_later(temp.body, "ethgasAPI.txt")
WriteToFileJob.set(wait: 10.seconds).perform_later(temp2['fastest'], "ethgasAPI_fastest.txt")


puts 'end'
```
运行脚本
```
ruby scripts/delayed_job_test.rb
```

得到返回结果

```
{"fast":530,"fastest":530,"safeLow":143,"average":143,"block_time":12.694444444444445,"blockNum":15537392,"speed":0.7801066667730836,"safeLowWait":1.5,"avgWait":1.5,"fastWait":0.5,"fastestWait":0.5,"gasPriceRange":{"4":211.6,"6":211.6,"8":211.6,"10":211.6,"20":211.6,"30":211.6,"40":211.6,"50":211.6,"60":211.6,"70":211.6,"80":211.6,"90":211.6,"100":211.6,"110":211.6,"120":211.6,"130":211.6,"140":211.6,"143":1.5,"150":1.4,"160":1.2,"170":1.2,"180":1,"190":0.9,"210":0.8,"230":0.8,"250":0.7,"270":0.7,"290":0.7,"310":0.7,"330":0.7,"350":0.6,"370":0.6,"390":0.6,"410":0.6,"430":0.6,"450":0.6,"470":0.6,"490":0.6,"510":0.6,"530":0.5}}
530
143
2023-06-04T04:38:58.615Z pid=321630 tid=6vdi INFO: Sidekiq 7.1.1 connecting to Redis with options {:size=>10, :pool_name=>"internal", :url=>nil}
end
```


查看
```
 ls
app  config     db                     delayed_job_demo.txt  ethgasAPI_fastest.txt  Gemfile       lib  public    readme.md  scripts  test  vendor
bin  config.ru  delayed_job_demo2.txt  dump.rdb              ethgasAPI.txt          Gemfile.lock  log  Rakefile  README.md  storage  tmp

```
查看sidekiq日志

```
2023-06-03T07:31:18.894Z pid=290658 tid=63mi class=WriteToFileJob jid=96744ea75cf2c2c97a56fe14 elapsed=0.126 INFO: done
2023-06-04T04:39:13.385Z pid=290658 tid=63mi class=WriteToFileJob jid=dda0089e583324372a73a5f4 INFO: start
2023-06-04T04:39:13.386Z pid=290658 tid=63ly class=WriteToFileJob jid=a06b5df9d91b5d03c01d45f4 INFO: start
2023-06-04T04:39:13.396Z pid=290658 tid=63mi class=WriteToFileJob jid=dda0089e583324372a73a5f4 INFO: Performing WriteToFileJob (Job ID: 77391551-3fc5-45fd-983e-542d13171233) from Sidekiq(default) enqueued at 2023-06-04T04:38:58Z with arguments: "{\"fast\":530,\"fastest\":530,\"safeLow\":143,\"average\":143,\"block_time\":12.694444444444445,\"blockNum\":15537392,\"speed\":0.7801066667730836,\"safeLowWait\":1.5,\"avgWait\":1.5,\"fastWait\":0.5,\"fastestWait\":0.5,\"gasPriceRange\":{\"4\":211.6,\"6\":211.6,\"8\":211.6,\"10\":211.6,\"20\":211.6,\"30\":211.6,\"40\":211.6,\"50\":211.6,\"60\":211.6,\"70\":211.6,\"80\":211.6,\"90\":211.6,\"100\":211.6,\"110\":211.6,\"120\":211.6,\"130\":211.6,\"140\":211.6,\"143\":1.5,\"150\":1.4,\"160\":1.2,\"170\":1.2,\"180\":1,\"190\":0.9,\"210\":0.8,\"230\":0.8,\"250\":0.7,\"270\":0.7,\"290\":0.7,\"310\":0.7,\"330\":0.7,\"350\":0.6,\"370\":0.6,\"390\":0.6,\"410\":0.6,\"430\":0.6,\"450\":0.6,\"470\":0.6,\"490\":0.6,\"510\":0.6,\"530\":0.5}}", "ethgasAPI.txt"
2023-06-04T04:39:13.396Z pid=290658 tid=63ly class=WriteToFileJob jid=a06b5df9d91b5d03c01d45f4 INFO: Performing WriteToFileJob (Job ID: 034467c3-e4bb-4bb1-a877-7fe600d4ab9f) from Sidekiq(default) enqueued at 2023-06-04T04:38:58Z with arguments: 530, "ethgasAPI_fastest.txt"
2023-06-04T04:39:13.396Z pid=290658 tid=63mi class=WriteToFileJob jid=dda0089e583324372a73a5f4 INFO: Performed WriteToFileJob (Job ID: 77391551-3fc5-45fd-983e-542d13171233) from Sidekiq(default) in 0.44ms
2023-06-04T04:39:13.397Z pid=290658 tid=63mi class=WriteToFileJob jid=dda0089e583324372a73a5f4 elapsed=0.012 INFO: done
2023-06-04T04:39:13.397Z pid=290658 tid=63ly class=WriteToFileJob jid=a06b5df9d91b5d03c01d45f4 INFO: Performed WriteToFileJob (Job ID: 034467c3-e4bb-4bb1-a877-7fe600d4ab9f) from Sidekiq(default) in 0.48ms
2023-06-04T04:39:13.397Z pid=290658 tid=63ly class=WriteToFileJob jid=a06b5df9d91b5d03c01d45f4 elapsed=0.011 INFO: done
```









(待定)
创建了一个表，原想保存数据使用，但是生成文件测试了，就没有使用。
```
bundle exec rails g scaffold myfiles name:string text:text
```

