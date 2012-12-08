# models
注意点

#### 各モデルの役割
Postクラスの役割は、作成されるとその内容のファイルがコールバックでファイルシステムに作成されること。

そのため、**どのブランチに作成されるかについての責任を持たない**ことに注意。

だから、このモデルを作成したり削除したりする場合は、原則的にController側からブランチを切り替えてやる必要がある。

それ以外にも、或るブランチに特定のファイルを用意するテストを書くときなんかも

    もし /^以下のコミットが存在している:$/ do |table|
      table.rows.each do |repository, branch, msg|
        branch = Repository.find_by_name
          branch.repository.checkout_to(branch.name)
          FactoryGirl.create(:post, branch:branch)
          branch.build_kommit(message:msg).save
          branch.repository.checkout_master
        end
      end
    end
 のようにテストケースごとにチェックアウトしてやらないといけないことに注意。



### memo
#### branchの切り替え
branchの切り替えは基本的にcontrollerでのみ行う

