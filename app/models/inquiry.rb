class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :category, :message, :evaluation, :feedback

  validates :name, :presence => {:message => '名前を入力してください'}
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}
  validates :category, :presence => {:message => 'お問合せ内容を選択してください'}
  validates :evaluation, :presence => {:message => 'アプリの評価を選択してください'}
end