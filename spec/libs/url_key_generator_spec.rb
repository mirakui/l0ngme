require 'spec_helper'

describe UrlKeyGenerator do
  before do
    @src_url = "http://www.example.com/foo/bar?param1=value1&param2=value2"
    #@src_url = "http://maps.google.co.jp/maps?um=1&ie=UTF-8&q=%E3%82%AB%E3%83%AC%E3%83%BC&fb=1&gl=jp&hq=%E3%82%AB%E3%83%AC%E3%83%BC&hnear=%E9%AB%98%E5%86%86%E5%AF%BA%E9%A7%85%EF%BC%88%E6%9D%B1%E4%BA%AC%EF%BC%89&view=text&ei=S4iXTI7cFoiycbqd2KQF&sa=X&oi=local_group&ct=more-results&resnum=4&ved=0CGUQtQMwAw"
  end

  it "can generate long key" do
    length = @src_url.length + 100
    key = UrlKeyGenerator.generate(@src_url, length)
    underline = key.gsub(/[^_]/, '')
    underline.length.should > 1
    key.length.should == length
  end

  it "long key has variations" do
    length = @src_url.length + 100
    keys = []
    10.times do |i|
      keys << UrlKeyGenerator.generate(@src_url, length, i)
    end
    keys.should == keys.uniq
  end

  it "can generate short key" do
    length = @src_url.length - 30
    key = UrlKeyGenerator.generate(@src_url, length)
    key.should_not match(/_/)
    key.length.should == length
  end

  it "short key has variations" do
    length = @src_url.length - 30
    keys = []
    10.times do |i|
      keys << UrlKeyGenerator.generate(@src_url, length, i)
    end
    keys.should == keys.uniq
  end

end
