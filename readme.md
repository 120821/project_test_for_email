# rails delayed_job 的简单使用
1.创建新的项目，用来测试

```
rails new tasks_app
```

进入文件夹
```
cd tasks_app/
```
2.使用devise, 修改Gemfile, 增加gem

```
gem "devise"
gem 'pg'
```
```
rails generate devise:install
```

修改config/database.yml
```
default: &default
  adapter: postgresql
  pool: <%= ENV["DATABASE_POOL"] || 64 %>
  timeout: 5000
  encoding: utf-8
  user: postgres
  username: postgres
  password: 88888888
  port: 5432

development:
  <<: *default
  database: task

test:
  <<: *default
  database: task_test

production:
  <<: *default
  database: task
```

3.创建user表,修改配置文件

在`config/environments/development.rb`增加：
```
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

创建user

```
rails generate devise user
```

返回结果
```
invoke  active_record
create    db/migrate/20230605141936_devise_create_users.rb
create    app/models/user.rb
invoke    test_unit
create      test/models/user_test.rb
create      test/fixtures/users.yml
insert    app/models/user.rb
route  devise_for :users
```

运行`rails db:migrate`
```
== 20230605141936 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0050s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0014s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0011s
== 20230605141936 DeviseCreateUsers: migrated (0.0077s) =======================
```

4. 设置登录验证

修改`app/controllers/application_controller.rb`, 增加
```
before_action :authenticate_user!
```

此时需要重启服务器，不然就会出现报错：

```
undefined method `devise_for' for #<ActionDispatch::Routing::Mapper:0x00007fc638079d50 @set=#<ActionDispatch::Routing::RouteSet:0x00007fc63a1406b0>, @draw_paths=[#<Pathname:/workspace/test_apps2023/tasks_app/config/routes>], @scope=#<ActionDispatch::Routing::Mapper::Scope:0x00007fc638079cd8 @hash={:path_names=>{:new=>"new", :edit=>"edit"}}, @parent=#<ActionDispatch::Routing::Mapper::Scope:0x00007fc6399817a8 @hash=nil, @parent=nil, @scope_level=nil>, @scope_level=nil>, @concerns={}>
```

重启server后， 打开`http://localhost:3333/`会显示默认的rails页面，但是打开`http://localhost:3333/projects`则会自动跳转到`http://localhost:3333/users/sign_in`
此时可以选择注册，注册时密码要至少6位，否则会失效，如果登录输入错误密码，也无法成功登录。
5. 增加邮件发送功能
登录后可以创建project和question，目前css问题可以先放着。功能问题需要优先实现。
首先创建两个user(注册), admin@linlin.com,以及qq邮箱(用来测试邮件发送).
在`config/environments/development.rb` 和`config/environments/production.rb`文件增加
```
config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            '<Gmail username>',
  password:             '<Gmail password>',
  authentication:       'plain',
  enable_starttls_auto: true
}
```

