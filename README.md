1. 创建project和question表

2. 增加邮件发送功能

3. 创建question的时候就发送邮件

log：
```
Started POST "/questions" for 127.0.0.1 at 2023-06-06 22:09:22 +0800
Processing by QuestionsController#create as TURBO_STREAM
  Parameters: {"authenticity_token"=>"[FILTERED]", "question"=>{"title"=>"test", "content"=>"test", "status"=>"已分发", "level"=>"低", "assigned_to"=>"1208215066@qq.com", "start_day"=>"2023-06-06T01:39", "project_id"=>"1"}, "commit"=>"Create Question"}
  User Load (0.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["id", 1], ["LIMIT", 1]]
  TRANSACTION (0.1ms)  BEGIN
  ↳ app/controllers/questions_controller.rb:27:in `block in create'
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/controllers/questions_controller.rb:27:in `block in create'
  Question Create (0.2ms)  INSERT INTO "questions" ("title", "content", "status", "level", "assigned_to", "start_day", "created_at", "updated_at", "project_id") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING "id"  [["title", "test"], ["content", "test"], ["status", "已分发"], ["level", "低"], ["assigned_to", "1208215066@qq.com"], ["start_day", "2023-06-06 01:39:00"], ["created_at", "2023-06-06 14:09:22.769603"], ["updated_at", "2023-06-06 14:09:22.769603"], ["project_id", 1]]
  ↳ app/controllers/questions_controller.rb:27:in `block in create'
  TRANSACTION (0.4ms)  COMMIT
  ↳ app/controllers/questions_controller.rb:27:in `block in create'
  Rendering layout layouts/mailer.html.erb
  Rendering question_mailer/question_assigned.html.erb within layouts/mailer
  Rendered question_mailer/question_assigned.html.erb within layouts/mailer (Duration: 0.6ms | Allocations: 174)
  Rendered layout layouts/mailer.html.erb (Duration: 1.0ms | Allocations: 394)
QuestionMailer#question_assigned: processed outbound mail in 5.1ms
Delivered mail 647f3e12beb1e_6658d3bc4806c@linlin-i5.mail (11.0ms)
Date: Tue, 06 Jun 2023 22:09:22 +0800
From: from@example.com
To: 1208215066@qq.com
Message-ID: <647f3e12beb1e_6658d3bc4806c@linlin-i5.mail>
Subject: =?UTF-8?Q?=E6=82=A8=E6=9C=89=E4=B8=80=E9=A1=B9=E6=96=B0=E7=9A=84=E4=BB=BB=E5=8A=A1?=
 =?UTF-8?Q?_-_#<Question:0x00007fbb4e2fb118>?=
Mime-Version: 1.0
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf=
-8" />
    <style>
      /* Email styles need to be inline */
    </style>
  </head>

  <body>
    <h1>=E6=82=A8=E6=9C=89=E4=B8=80=E9=A1=B9=E6=96=B0=E7=9A=84=E4=BB=BB=E5=
=8A=A1</h1>
<p>=E4=BB=BB=E5=8A=A1=EF=BC=9Atest</p>
<p>=E9=A1=B9=E7=9B=AE=EF=BC=9Abaogong</p>

  </body>
</html>

Redirected to http://localhost:3333/questions/5
Completed 302 Found in 23ms (ActiveRecord: 0.8ms | Allocations: 10869)


```
rails c -e p
Loading production environment (Rails 7.0.5)
irb(main):001:0> QuestionMailer.question_assigned(a).deliver_now
(irb):1:in `<main>': undefined local variable or method `a' for main:Object (NameError)
irb(main):002:0> a = Question.last
=>
#<Question:0x00007fa5a97a9aa8
...
irb(main):003:0> QuestionMailer.question_assigned(a).deliver_now
  Rendered question_mailer/question_assigned.html.erb within layouts/mailer (Duration: 0.6ms | Allocations: 254)
  Rendered layout layouts/mailer.html.erb (Duration: 1.1ms | Allocations: 499)
Delivered mail 647f46e3342b3_795ddcd0-4dd@linlin-i5.mail (1622.1ms)
=> #<Mail::Message:45740, Multipart: false, Headers: <Date: Tue, 06 Jun 2023 22:46:59 +0800>, <From:  1208215066@qq.com>, <To: 1208215066@qq.com>, <Message-ID: <647f46e3342b3_795ddcd0-4dd@linlin-i5.mail>>, <Subject: 您有一项新的任务 - #<Question:0x00007fa5a97a9aa8>>, <Mime-Version: 1.0>, <Content-Type: text/html>, <Content-Transfer-Encoding: quoted-printable>>
irb(main):004:0>


