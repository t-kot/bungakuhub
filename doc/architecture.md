設計メモ

#### ユーザは互いにメッセージを送ることができる
Messageクラス

◯Model

- sender_id(integer) 送信した人のid
- receiver_id(integer) 受信した人のid 
- body(text) 本文
- check(boolean) 既読？

◯Routing

- (GET) inbox/messages user1が受信したメッセージ一覧
- (GET) messages/1 user1が受信したメッセージ
- (GET) outbox/message user1が送信したメッセージ一覧
- (DELETE) messages/1 message1の削除(senderのみが削除可能)

#### ユーザは他のユーザをフォローできる
FollowingShipクラス

◯Model

- follower_id フォローする側のUserのid
- following_id フォローされる側のUserのid

@user.followersで**@userをフォローしているユーザ一覧** 、@user.followingsで**@userがフォローしているユーザ一覧**が取得できる

@user.follows?(user) #=> userを@userがフォローしているかどうか

◯Routing

UsersControllerにfollowingsとfollowersアクションを定義　

あるいは FollowersController(index)とFollowingsController(index)を作成

- (GET) /users/1/followings user1がフォローしている一覧(誰でも見れる)
- (GET) /users/1/followers user1をフォローしている一覧(誰でも見れる)
- (POST) /followings 新しくフォローする(フォローの対象をidでPOST,current_user限定)
- (DELETE) /followings/1 user1をアンフォローする(current_user限定)
- (DELETE) /followers/1 user1をブロックする(current_user限定)


#### フォローしているユーザの行動がフィードで表示される
	Feed(STI)
	 |- Tweet ユーザのつぶやき、自由な書き込み
	 |- News システム側から作成される、ユーザの行動
	 	 |- RepositoryCreateNews レポジトリを作成しましたというニュース
	 	 |- RepositoryUpdateNews レポジトリを更新したというニュース
	 	 |- GetReputationNews レポジトリの評価を受けたというニュース
	 	 |- RepositoryReputateNews レポジトリを評価した(いいねと言っているなど)というニュース
	 	 |- RepositoryForkedNews レポジトリをフォークしたというニュース
	 	 |- StartFollowNews ユーザをフォローし始めたというニュース
	 	 |- 

リレーション

	class StartFollowNews < News
		attr_accessible :target_user_id
		belongs_to :user
		belongs_to :target_user, class: "User"
	end
これでStartFollowNews.target_user #=> #<User>

なお、StartFollowNewsはtarget_userを必要とするがそうでないものもある

これについてはサブクラスで使用可能な関連をattr_accessibleで制限して抽象クラスではこれを認めないことにする
	

◯Model

#####Feed

######Attributes

- user_id そのNewsやTweetが誰のものか(主語)
- type TweetかNewsの種類
- repository_id レポジトリに対して参照を持つfeedの場合(目的語)
- target_user_id ユーザに対して参照を持つfeedの場合(目的語)
- body Tweetの本文など

###### INSTANCE METHODS

- body tweetのときはDBのbodyの値を返し、そうでないときは動的に文字列を生成する

◯Routing

- (GET) /timeline/feeds timeline/feeds#index 自分がフォローしているユーザのfeed一覧(要ログイン)
- (GET) /timeline/tweets timeline/tweets#index 自分がフォローしているユーザのtweet一覧(要ログイン)
- (GET) /timeline/news timeline/news#index 自分がフォローしているユーザのnews一覧(要ログイン)
- (GET) /users/1/feeds feeds#index user1のフィード
- (GET) /users/1/tweets tweets#index user1のtweet一覧
- (GET) /users/1/news news#index user1のnews一覧
- (POST) /tweets tweets#create ログインしているユーザが自分のtweetを投稿する
- (DELETE) /tweets/1 tweets#destroy tweet1を削除する




 
(n+1)問題・・・current_user.followings.map{|following| following.feeds} #=>これじゃダメ

	class Feed
		self.followed_by(user)
			followed_ids = user.followings.map(&:id).join(",")
			where("user_id IN (#{followed_ids}) 
			OR user_id=:user_id", {user_id:user})
		end
	end
	
#### 特定のバージョン時のファイルの内容を表示できる
- (GET) /admin/branches/1/kommits/1/files/(ファイル名)

	def show
		


#### ファイルの一部だけを前のバージョンに戻すことができる

- (PUT) /admin/branches/1/kommits/1/files/(ファイル名)/checkout

ファイルの一つ、あるいは複数を選択して(チェックボックス)以前のコミットの状態に戻すことができる


#### レポジトリの全体をあるコミット時点に巻き戻せる
- (POST) /admin/branches/1/kommits/1/rollback

これでBranch.find(1)のpostsを全てKommit.find(1)の時点に書き直す

コミットするかどうかは将来的にはオプションにしたいが、現行ではコミットしないでもよいか。

#### Revertができる

機能をすべて見直す必要がある


#### カテゴリ登録

◯model

Category 

- name:{ja:"文学", en:"Literature"}
- type STIのためのtype

	Category
	|- TextCategory
	|- ComicCategory


Category has_many => Repository

Repositoryを作成するときに、対応するRepository_typeのCategoryを選択する


#### Tag登録
TagとRepositoryは多対多関係。中間のモデルにRepositoryTagRelationshipなどを作る。

◯Model

Tag

- name: "エンタテインメント"

RepositoryTagRelationship

- tag_id
- repository_id

インクリメンタルサーチなどの実装がけっこうチャレンジングなので後回し。


#### Issue
RepositoryとIssueTopicは1対多関係。さらにIssueTopicはIssueCommentをhas_many.

Repository =has_many => IssueTopic has_many=>IssueComment

IssueTopic

- title:string
- body:text
- author:user
- open:boolean

IssueComment
- issue_topic_id:integer
- body:text
- author:user




















